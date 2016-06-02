//
//  RCManager.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/31.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCRCManager.h"
#import "ChatListViewController.h"
#import "ZYZCConversationController.h"
#import <RongIMKit/RCConversationViewController.h>
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "ZYZCDataBase.h"

static ZYZCRCManager *_RCManager;

@interface ZYZCRCManager()

@end


@implementation ZYZCRCManager

+(instancetype )defaultRCManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!_RCManager) {
            _RCManager=[[ZYZCRCManager alloc]init];
        }
    });
    
    return _RCManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *myToken=[user objectForKey:KCHAT_TOKEN];
        if (myToken&&!_hasLogin) {
            [self loginRongCloudByToken:myToken];
        }
    }
    return self;
}

#pragma mark --- 登陆融云
- (void)loginRongCloudByToken:(NSString *)myToken
{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    NSLog(@"myToken:%@",myToken);
    
//    在 App 整个生命周期，您只需要调用一次此方法与融云服务器建立连接
    [[RCIM sharedRCIM] connectWithToken:myToken success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        _hasLogin=YES;
        NSLog(@"Login successfully with userId: %@.", userId);
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
}

#pragma amrk ---代理方法
/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    NSLog(@"userId:%@",userId);
    ZYZCDataBase  *dataBase=[ZYZCDataBase sharedDBManager];
    ChatUserModel *chatUserModel= [dataBase searchOneUerWithUserID:userId];
    if (chatUserModel) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = chatUserModel.userId;
        user.name = chatUserModel.name;
        user.portraitUri = chatUserModel.portraitUri;
        return completion(user);
    }
//    if ([userId isEqualToString:@"oulbuvtpzxiOe6t9hVBh2mNRgiaI"]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"oulbuvtpzxiOe6t9hVBh2mNRgiaI";
//        user.name = @"柳亮";
//        user.portraitUri = @"http://wx.qlogo.cn/mmopen/YPVmKnq3lLzRXoWtF1MePPbo5dd0oRb9QC0tpzKKFPSq8apbgaxia0XNh2Ig435v9iclzD7UibOkdZ0JicEFjXNQxBMhoOm4EKOM/0";
//        return completion(user);
//    }
//    else if
//        ([userId isEqualToString:@"oulbuvolvV8uHEyZwU7gAn8icJFw"]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"oulbuvolvV8uHEyZwU7gAn8icJFw";
//        user.name = @"李丞";
//        user.portraitUri = @"http://wx.qlogo.cn/mmopen/1giaZZicLzGZS24WLORvJyicksTt3cPMUDribbDuQhaayD64WmVOxiclKMNG07IefibUFicJLiamM5YrkHeicriae4ERpF9g/0";
//        return completion(user);
//    }
}


#pragma mark --- 获取融云的Token
-(void)getRCloudToken
{
//     ZYZCAccountModel *model = [ZYZCAccountTool account];
    
}

#pragma mark ---直接进入聊天界面
-(void)connectTarget:(NSString *)targetId andSuperViewController:(UIViewController *)viewController
{
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    ZYZCConversationController  *conversationVC = [[ZYZCConversationController alloc]init];
    conversationVC.hidesBottomBarWhenPushed=YES;
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = targetId;
    conversationVC.title = @"聊天";
    [viewController.navigationController pushViewController:conversationVC animated:YES];
}

#pragma mark --- 获取会话列表
-(void)getMyConversationListWithSupperController:(UIViewController *)viewContrroller
{
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
    chatListViewController.hidesBottomBarWhenPushed=YES;
    [viewContrroller.navigationController pushViewController:chatListViewController animated:YES];
}

@end
