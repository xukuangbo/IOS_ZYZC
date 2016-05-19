//
//  AppDelegate.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/4.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define IOS8 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0
#import "AppDelegate.h"
#import "ZYZCTabBarController.h"
#import "ZYZCOSSManager.h"
#import <RongIMKit/RongIMKit.h>
#import "WXApi.h"
#import "WXApiManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.layer.cornerRadius=5;
    self.window.layer.masksToBounds=YES;
    [self.window makeKeyAndVisible];
    //设置状态栏
    [self setStatusBarStyle];
    //设置根控制器
    [self getRootViewController];
    //在documents中创建资源文件夹
    [self createResoureFilefolderInDocuments];
    //清除临时文件夹内容
    [self cleanTmpFile];
    //更改appBadge
    [self changeAppBadge];
    //首次进入app获取地名库
//    [self saveLocalDesct];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *tmpFileName=[NSString stringWithFormat:@"%@/%@",KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP];
    NSString *tmpFile=KMY_ZHONGCHOU_DOCUMENT_PATH(tmpFileName);
    NSArray *tmpFileArr=[fileManager subpathsAtPath:tmpFile];
    NSLog(@"%@",tmpFileArr);
    NSLog(@"%@",KMY_ZHONGCHOU_DOCUMENT_PATH(@""));
    /**
     初始化微信
     */
    [self initWithWechat];
    [self initRCloud];
    [self getAppVersion];
    [self deleteFailDataInOss];
//    [self getFileToTmp];
    return YES;
}

-(void)initRCloud
{
    [[RCIM sharedRCIM] initWithAppKey:@"sfci50a7c25fi"];
}

#pragma mark --- 设置根控制器
-(void)getRootViewController
{
    UIStoryboard *storyboard= [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ZYZCTabBarController *mainTab=[storyboard instantiateViewControllerWithIdentifier:@"ZYZCTabBarController"];
    self.window.rootViewController=mainTab;
}

#pragma mark --- 设置状态栏
-(void)setStatusBarStyle
{
    [[UIApplication sharedApplication] setStatusBarStyle:
     UIStatusBarStyleLightContent];
}

#pragma mark --- 存储app版本号，判断app是否是下载或更新后第一次进入
-(void)getAppVersion
{
    NSString *version=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *myVersion=[user objectForKey:KAPP_VERSION];
    //下载或更新后第一次进入
    if (!myVersion||![myVersion isEqualToString:version]) {
        [user setObject:version forKey:KAPP_VERSION];
        [user synchronize];
    }
}

/**
 初始化微信
 */
- (void)initWithWechat
{
    [WXApi registerApp:kAppOpenid withDescription:@"ZYZC"];
}

#pragma mark - 打开微信，回调微信
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

#pragma mark --- 微信支付方法回调(添加通知)
-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                NSNotification *notification = [NSNotification notificationWithName:KORDER_PAY_NOTIFICATION object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default: {
                NSNotification *notification = [NSNotification notificationWithName:KORDER_PAY_NOTIFICATION object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}

#pragma mark --- 在Documents中创建资源文件存放视屏、语音、图片
-(void)createResoureFilefolderInDocuments
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,KDOCUMENT_FILE];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        BOOL fileCreate=[fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (fileCreate==YES) {
            
            NSString *createTmpPath = [NSString stringWithFormat:@"%@/%@/%@", pathDocuments,KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP];
            if (![[NSFileManager defaultManager] fileExistsAtPath:createTmpPath]) {
                [fileManager createDirectoryAtPath:createTmpPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            
            NSString *createDocPath = [NSString stringWithFormat:@"%@/%@/%@", pathDocuments,KDOCUMENT_FILE,KMY_ZHONGCHOU_DOC];
            if (![[NSFileManager defaultManager] fileExistsAtPath:createDocPath]) {
                [fileManager createDirectoryAtPath:createDocPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }
    }
}

#pragma mark --- 删除临时文件


-(void)cleanTmpFile
{
    NSString *fileName=[NSString stringWithFormat:@"%@/%@",KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP];
    NSString *tmpDir=KMY_ZHONGCHOU_DOCUMENT_PATH(fileName);
    
    NSFileManager *manager=[NSFileManager defaultManager];
    
    NSArray *fileArr=[manager subpathsAtPath:tmpDir];
    
    for (NSString *fileName in fileArr) {
        NSString *filePath = [tmpDir stringByAppendingPathComponent:fileName];
        dispatch_async(dispatch_get_global_queue(0, 0), ^
                       {
                           [manager removeItemAtPath:filePath error:nil];
                       });
    }
}

#pragma mark --- 删除oss上上传失败的文件
-(void)deleteFailDataInOss
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *failDataFile=[user objectForKey:KFAIL_UPLOAD_OSS];
    if (failDataFile) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            ZYZCOSSManager *ossManager=[ZYZCOSSManager defaultOSSManager];
            [ossManager deleteObjectsByPrefix:failDataFile andSuccessUpload:^
             {
                 [user setObject:nil forKey:KFAIL_UPLOAD_OSS];
                 [user synchronize];
             }
                                andFailUpload:^
             {
             }];
        });
    }
}

#pragma mark --- 更改app的Badge
-(void)changeAppBadge{
    UIApplication *app = [UIApplication sharedApplication];
    //IOS8以后,需要先注册权限
    //区分版本号
    if(IOS8)
    {
        //定义通知类型
        //很多app为了避免多次麻烦用户,在一开始就将3种权限都注册好
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        //设置选项
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        //注册
        [app registerUserNotificationSettings:setting];
    }
    [app setApplicationIconBadgeNumber:10];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //删除临时文件
    [self cleanTmpFile];
    
}

@end
