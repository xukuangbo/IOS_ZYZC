//
//  MoreFZCViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCViewController.h"

#import "MoreFZCGoalTableView.h"
#import "MoreFZCRaiseMoneyTableView.h"
#import "MoreFZCTravelTableView.h"
#import "MoreFZCReturnTableView.h"
#import "ZYZCTool+getLocalTime.h"
#import "MoreFZCDataManager.h"
#import "FZCReplaceDataKeys.h"
#import "MBProgressHUD+MJ.h"
#import "ZYZCOSSManager.h"
#import "NecessoryAlertManager.h"

#define kMoreFZCToolBar 20
#define kNaviBar 64

#define ALERT_BACK_TAG   1
#define ALERT_UPLOAD_TAG 2
#define ALERT_PUBLISH_TAG 3

@interface MoreFZCViewController ()<MoreFZCToolBarDelegate,UIAlertViewDelegate>
@property (nonatomic, copy  ) NSString *oneResouceFile;
@property (nonatomic, copy  ) NSString *archiveDataPath;
@property (nonatomic, assign) BOOL isFirstTimeToSave;
@property (nonatomic, assign) BOOL needPopVC;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy  ) NSString *myZhouChouMarkName;
@property (nonatomic, strong) NSMutableArray *uploadDataState;
@property (nonatomic, assign) NSInteger uploadDataNumber;
@property (nonatomic, assign) BOOL hasPulish;
@property (nonatomic, assign) BOOL hasUpload;
@end

@implementation MoreFZCViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
   
    [super viewDidLoad];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:[NSNumber numberWithInteger:0] forKey:KMOREFZC_RETURN_SUPPORTTYPE];
    [user synchronize];
     self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    _uploadDataState=[NSMutableArray array];
    [self setBackItem];
    [self createToolBar];
    [self createClearMapView];
    [self createBottomView];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotify:) name:@"uploadData" object:nil];
}
/**
 *  创建空白容器，并创建4个tableview
 */
- (void)createClearMapView
{
    //1.创建空白的view
    UIView *clearMapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H)];
    clearMapView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:clearMapView belowSubview:self.toolBar];
    self.clearMapView = clearMapView;
    
    //!重点：IOS7 UIScrollerView 的一个特点 如果UIScView是父view的第一个子view 会自动添加偏移量 uitableview继承自UIscview 所以有偏移，所以！！！我加了一个view放在底部，防止偏移
    UIView *clearView1 = [[UIView alloc] initWithFrame:clearMapView.bounds];
    clearView1.backgroundColor = [UIColor clearColor];
    [clearMapView addSubview:clearView1];
    
    MoreFZCGoalTableView *goalTableView = [[MoreFZCGoalTableView alloc] initWithFrame:clearMapView.bounds style:UITableViewStylePlain];
    goalTableView.tag = MoreFZCToolBarTypeGoal;
    [clearMapView addSubview:goalTableView];
    
    MoreFZCRaiseMoneyTableView *raiseMoneyTableView = [[MoreFZCRaiseMoneyTableView alloc] initWithFrame:clearMapView.bounds style:UITableViewStylePlain];
    raiseMoneyTableView.tag = MoreFZCToolBarTypeRaiseMoney;
    [clearMapView insertSubview:raiseMoneyTableView belowSubview:goalTableView];
//    [clearMapView addSubview:raiseMoneyTableView];
    
    MoreFZCTravelTableView *travelTableView = [[MoreFZCTravelTableView alloc] initWithFrame:clearMapView.bounds style:UITableViewStylePlain];
    
    [clearMapView insertSubview:travelTableView belowSubview:goalTableView];
     travelTableView.tag = MoreFZCToolBarTypeTravel;
//    [clearMapView addSubview:travelTableView];
    
    MoreFZCReturnTableView *returnTableView = [[MoreFZCReturnTableView alloc] initWithFrame:clearMapView.bounds style:UITableViewStylePlain];
    returnTableView.tag = MoreFZCToolBarTypeReturn;
    [clearMapView insertSubview:returnTableView belowSubview:goalTableView];
}

/**
 *  创建工具条
 */
- (void)createToolBar
{
    //2.toolbar的创建
    MoreFZCToolBar *toolBar = [[MoreFZCToolBar alloc] initWithFrame:CGRectMake( 0, kNaviBar, KSCREEN_W, 44)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}


/**
 *  返回被选中的view
 */
- (UIView *)selectdView:(NSInteger)buttonTag
{
    
    for (UIView *subView in self.clearMapView.subviews) {
//        NSLog(@"%ld-----%ld",subView.tag , buttonTag);
            if (subView.tag == buttonTag) {
                return subView;
            }
    }
    return nil;
}
#pragma mark --- 创建底部视图
-(void)createBottomView
{
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, KSCREEN_H-KTABBAR_HEIGHT , KSCREEN_W, KTABBAR_HEIGHT)];
    bottomView.backgroundColor=[UIColor ZYZC_TabBarGrayColor];
    [self.view addSubview:bottomView];
    
    [bottomView addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, KSCREEN_W, 0.5) andColor:[UIColor lightGrayColor]]];
    
    NSArray *titleArr=@[@"预览",@"下一步",@"保存"];
    CGFloat btn_width=100;
    CGFloat btn_edg  =(KSCREEN_W-btn_width*3)/4;
    for (int i=0; i<3; i++) {
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame=CGRectMake(btn_edg+(btn_width+btn_edg)*i, KTABBAR_HEIGHT/2-20, btn_width, 40);
        [sureBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        sureBtn.layer.cornerRadius=KCORNERRADIUS;
        sureBtn.layer.masksToBounds=YES;
        [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag=SkimType+i;
        [bottomView addSubview:sureBtn];
    }
    self.bottomView=bottomView;
}

#pragma mark - MoreFZCToolBarDelegate
- (void)toolBarWithButton:(NSInteger)buttonTag
{
    //把tableview带到前面去
    UITableView *tableView=(UITableView *)[self selectdView:buttonTag];
    [self.clearMapView bringSubviewToFront:tableView];

    if (tableView.tag!=MoreFZCToolBarTypeRaiseMoney)
    {
        [tableView reloadData];
    }
    
    if (tableView.tag!=MoreFZCToolBarTypeGoal) {
        if (_goalKeyBordHidden) {
            _goalKeyBordHidden();
        }
    }
    if (tableView.tag!=MoreFZCToolBarTypeRaiseMoney) {
        if (_raiseKeyBordHidden) {
            _raiseKeyBordHidden();
        }
    }
    if (tableView.tag!=MoreFZCToolBarTypeReturn) {
        if (_returnKeyBordHidden) {
            _returnKeyBordHidden();
        }
    }
}

#pragma mark - 自定义方法
/**
 *  重写返回键方法
 */
-(void)pressBack
{
    //  退出时，如果有填写发众筹内容，提示保存
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    NSDictionary *managerDict = manager.mj_keyValues;
    if (managerDict.count>6||(managerDict.count==6&&manager.goal_goals.count>1)||(managerDict.count==6&&manager.travelDetailDays.count>0)) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"是否保存数据" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        alertView.tag=ALERT_BACK_TAG;
        [alertView show];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark --- alertView代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==ALERT_BACK_TAG) {
        //保存数据
        if (buttonIndex ==1)
        {
            [self cleanTmpFile];
            _needPopVC=YES;
//            [self saveData];
        }
        //不保存
        else
        {
            //删除Documents中临时存储文件
            [self cleanTmpFile];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        // 释放单例中存储的内容
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        [manager initAllProperties];
    }
    //数据上传到oss失败，提示重新上传
    else if (alertView.tag ==ALERT_UPLOAD_TAG)
    {
        //点击确定，重新上传数据到oss
        if (buttonIndex ==1) {
            [self uploadDataToOSS];
        }
        //点击取消，删除oss上已上传的数据
        else if (buttonIndex ==0)
        {
            ZYZCOSSManager *ossManager=[ZYZCOSSManager defaultOSSManager];
            [ossManager deleteObjectsByPrefix:[NSString stringWithFormat:@"%@/%@",[ZYZCTool getUserId],_myZhouChouMarkName]];
        }
    }
    //发布请求失败，提示重新发布
    else if (alertView.tag ==ALERT_PUBLISH_TAG)
    {
        if (buttonIndex ==1) {
            [self publishMyZhongchou];
        }
    }
}

#pragma mark --- 删除Documents中临时存储文件
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

#pragma mark --- 点击底部按钮触发事件
-(void)clickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case SkimType:
            break;
        case NextType:
            [self nextOneOrPublish:self.toolBar.preClickBtn];
            break;
        default:
        case SaveType:
            //保存数据
//            [self saveData];
            break;
    }
}

#pragma mark --- 下一步或发布
-(void)nextOneOrPublish:(UIButton *)button
{
    //下一步
    if (button.tag<MoreFZCToolBarTypeReturn) {
        
        if (button.tag==MoreFZCToolBarTypeGoal) {
            BOOL lossMessage01=[NecessoryAlertManager showNecessoryAlertView01];
            if (lossMessage01) {
                return;
            }
        }
        if (button.tag==MoreFZCToolBarTypeRaiseMoney) {
            BOOL lossMessage02=[NecessoryAlertManager showNecessoryAlertView02];
            if (lossMessage02) {
                return;
            }
        }
        if (button.tag==MoreFZCToolBarTypeTravel) {
            [self saveModelInManager];
            BOOL lossMessage03=[NecessoryAlertManager showNecessoryAlertView03];
            if (lossMessage03) {
                return;
            }
        }
        UIButton *btn=(UIButton *)[self.toolBar viewWithTag:(button.tag+1)];
        [self.toolBar buttonClickAction:btn];
        UIButton *nextBtn=(UIButton *)[self.bottomView viewWithTag:NextType];
        if (btn.tag==MoreFZCToolBarTypeReturn) {
            [nextBtn setTitle:@"发布" forState:UIControlStateNormal];
            [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            nextBtn.backgroundColor=[UIColor ZYZC_MainColor];
        }
    }
    //发  布
    else
    {
        [self saveModelInManager];
        if (button.tag==MoreFZCToolBarTypeReturn) {
            BOOL lossMessage04=[NecessoryAlertManager showNecessoryAlertView04];
            if (lossMessage04) {
                return;
            }
        }
        [self uploadDataToOSS];
    }
}

#pragma mark --- 发布我的众筹
//上传数据到oss
-(void)uploadDataToOSS
{
    if (_hasUpload) {
        [self publishMyZhongchou];
        return;
    }
    if (_hasPulish) {
        [MBProgressHUD showSuccess:@"您已发布成功!"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在发布,请稍等..."];
    
    if (_uploadDataState.count) {
        [_uploadDataState removeAllObjects];
    }
//    //上传数据到oss
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *tmpFileName=[NSString stringWithFormat:@"%@/%@",KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP];
    NSString *tmpFile=KMY_ZHONGCHOU_DOCUMENT_PATH(tmpFileName);
    NSArray *tmpFileArr=[fileManager subpathsAtPath:tmpFile];
    _uploadDataNumber=tmpFileArr.count;
    _myZhouChouMarkName=[ZYZCTool getLocalTime];
    dispatch_async(dispatch_get_global_queue(0, 0), ^
    {
        for (int i=0; i<tmpFileArr.count; i++) {
            __weak typeof (&*self )weakSelf=self;
            //文件上传到oss中已openId为文件名下的以_myZhouChouMarkName为文件名下
            ZYZCOSSManager *ossManager=[ZYZCOSSManager defaultOSSManager];
            [ossManager uploadObjectAsyncByFileName:[NSString stringWithFormat:@"%@/%@",weakSelf.myZhouChouMarkName,tmpFileArr[i]] andFilePath:[tmpFile stringByAppendingPathComponent:tmpFileArr[i]] withSuccessUpload:^
             {
                 [weakSelf.uploadDataState addObject:[NSNumber numberWithBool:YES]];
                 [weakSelf reciveUploadResult];
             }
                                      andFailUpload:^
             {
                 [weakSelf.uploadDataState addObject:[NSNumber numberWithBool:NO]];
                 [weakSelf reciveUploadResult];
             }];
        }
    });
}

#pragma mark --- 每个文件上传到oss后的结果
-(void)reciveUploadResult
{
    BOOL hasAlert=NO;
    //如果有一个数据上传失败，则表示数据上传失败
    if (_uploadDataState.count) {
        for (NSNumber *obj in _uploadDataState) {
            if (![obj boolValue]) {
                [MBProgressHUD hideHUD];
                if (!hasAlert) {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"发布失败，是否重新发布" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag=ALERT_UPLOAD_TAG;
                    [alert show];
                    hasAlert=YES;
                }
                return;
            }
        }
    }
    //如果_uploadDataState中的结果数与上传文件数相同，说明文件都进行了上传并且上传成功
    if (_uploadDataState.count==_uploadDataNumber) {
        _hasUpload=YES;
        [self publishMyZhongchou];
    }
    
}

#pragma mark --- 发布我的众筹
-(void)publishMyZhongchou
{
    //将oss的链接保存到manager中
    [self changeManagerFileName];
    
    //将数据转化成上传数据对应的类型
    FZCReplaceDataKeys *replaceKeys=[[FZCReplaceDataKeys alloc]init];
    [replaceKeys replaceDataKeys];
    // 模型转字典
    NSDictionary *dataDict = replaceKeys.mj_keyValues;
    NSLog(@"%@",dataDict);
    NSMutableDictionary *newParameters=[NSMutableDictionary dictionaryWithDictionary:dataDict];
    [newParameters addEntriesFromDictionary:@{@"productCountryId":@1}];
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:ADDPRODUCT andParameters:dataDict andSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            //发送成功，删除本地数据
            [self cleanTmpFile];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"发布成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
            [manager initAllProperties];
            [self cleanTmpFile];
            _hasPulish=YES;
        }
        else
        {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"数据丢失，发布失败"];
        }
    } andFailBlock:^(id failResult) {
        [MBProgressHUD hideHUD];
        //提示发布失败
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"网络出错，发布失败，是否重新发布" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=ALERT_PUBLISH_TAG;
        [alert show];
    }];
}


#pragma mark --- 存储数据上传到oss后的链接
-(void)changeManagerFileName
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    manager.goal_travelThemeImgUrl=[self changeFileName:manager.goal_travelThemeImgUrl];
    manager.raiseMoney_voiceUrl=[self changeFileName:manager.raiseMoney_voiceUrl];
    manager.raiseMoney_movieUrl=[self changeFileName:manager.raiseMoney_movieUrl];
    manager.raiseMoney_movieImg=[self changeFileName:manager.raiseMoney_movieImg];
    for (MoreFZCTravelOneDayDetailMdel *model in manager.travelDetailDays) {
        model.voiceUrl=[self changeFileName:model.voiceUrl];
        model.movieUrl=[self changeFileName:model.movieUrl];
        model.movieImg=[self changeFileName:model.movieImg];
    }
    
    manager.return_voiceUrl=[self changeFileName:manager.return_voiceUrl];
    manager.return_movieUrl=[self changeFileName:manager.return_movieUrl];
    manager.return_movieImg=[self changeFileName:manager.return_movieImg];
    manager.return_voiceUrl01=[self changeFileName:manager.return_voiceUrl01];
    manager.return_movieUrl01=[self changeFileName:manager.return_movieUrl01];
    manager.return_movieImg01=[self changeFileName:manager.return_movieImg01];
}

#pragma mark --- 本地路径名改成网络数据链接名
-(NSString *)changeFileName:(NSString *)fileName
{
    NSString *subFileName=nil;
    NSRange strRange=[fileName rangeOfString:KMY_ZHONGCHOU_TMP];
    if (strRange.length) {
       subFileName=[fileName substringFromIndex:(strRange.location+strRange.length+1)];
    }
    if (subFileName) {
        return [NSString stringWithFormat:@"%@/%@/%@/%@",KHTTP_FILE_HEAD,[ZYZCTool getUserId],_myZhouChouMarkName,subFileName];
    }
    else
    {
        return nil;
    }
}


#pragma mark --- 保存数据
-(void)saveData
{
    if (_oneResouceFile) {
        //数据已保存过，再次保存时需删除这个众筹的资源文件
        NSFileManager *manager=[NSFileManager defaultManager];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [manager removeItemAtPath:_oneResouceFile error:nil];
        });
    }
   //创建保存某个众筹的资源文件
    NSString *pathDocuments=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    _oneResouceFile = [NSString stringWithFormat:@"%@/%@/%@", pathDocuments,KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP];
    [MBProgressHUD showMessage:nil];
    
    [self saveModelInManager];
    
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    __weak typeof (&*self)weakSelf=self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      
        dispatch_async(dispatch_get_main_queue(), ^{
            //将数据转化成上传数据对应的类型
            FZCReplaceDataKeys *replaceKeys=[[FZCReplaceDataKeys alloc]init];
            [replaceKeys replaceDataKeys];
            // 模型转字典
            NSDictionary *dataDict = replaceKeys.mj_keyValues;
            NSLog(@"dataDict:%@",dataDict);
            
            //归档
            weakSelf.archiveDataPath=[NSString stringWithFormat:@"%@/%@.data",_oneResouceFile,[ZYZCTool getLocalTime]];
            [NSKeyedArchiver archiveRootObject:manager toFile:weakSelf.archiveDataPath];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"保存成功!"];
            [weakSelf saveDataInMyZhongChouPlist];
            if (weakSelf.needPopVC) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                weakSelf.needPopVC=NO;
            }
        });
    });
}

#pragma mark --- 保存行程安排model到manager中
-(void)saveModelInManager
{
    //保存每日行程安排到单例中
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    [manager.travelDetailDays removeAllObjects];
    MoreFZCTravelTableView *travelTable=[(MoreFZCTravelTableView *)self.clearMapView viewWithTag:MoreFZCToolBarTypeTravel];
    for (NSInteger i=0; i<travelTable.travelDetailCellArr.count; i++) {
        TravelSecondCell *travelSecondCell=travelTable.travelDetailCellArr[i];
        [travelSecondCell saveTravelOneDayDetailData];
        NSDictionary *modelDict = travelSecondCell.oneDetailModel.mj_keyValues;
        if (modelDict.count>2) {
            [manager.travelDetailDays addObject:travelSecondCell.oneDetailModel];
        }
    }
}

#pragma mark --- 保存数据到plist文档中
-(void)saveDataInMyZhongChouPlist
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *plistPath=[path stringByAppendingPathComponent:@"MyZhongChou.plist"];
    NSArray *arr=[NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *mutArr=[NSMutableArray arrayWithArray:arr];
     NSDictionary *dict=@{@"oneResouceFile":_oneResouceFile,@"archiveDataPath":_archiveDataPath};
    if (!_isFirstTimeToSave) {
        [mutArr addObject:dict];
        _isFirstTimeToSave=YES;
    }
    else
    {
        [mutArr replaceObjectAtIndex:mutArr.count-1 withObject:dict];
    }
    [mutArr writeToFile:plistPath atomically:YES];
}

#pragma mark --- 将临时文件移到documents中
-(void)copyTmpFileToDoc
{
    NSFileManager*fileManager =[NSFileManager defaultManager];
    
    NSString *tmpFileName=[NSString stringWithFormat:@"%@/%@",KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP];
    NSString *tmpFile=KMY_ZHONGCHOU_DOCUMENT_PATH(tmpFileName);
    
    NSString *docFileName=[NSString stringWithFormat:@"%@/%@",KDOCUMENT_FILE,KMY_ZHONGCHOU_DOC];
    NSString *docFile=KMY_ZHONGCHOU_DOCUMENT_PATH(docFileName);
    
    //清空doc中文件
    NSArray *docFileArr=[fileManager subpathsAtPath:docFile];
    for (NSString *fileName in docFileArr) {
        NSString *filePath = [docFile stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
    //将tmpFile中的文件移动到doc中
    NSArray *tmpFileArr=[fileManager subpathsAtPath:tmpFile];
    for (NSString *fileName in tmpFileArr) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSError *error;
            NSString * tmpFilePath = [tmpFile stringByAppendingPathComponent:fileName];
            NSString * docFilePath = [docFile stringByAppendingPathComponent:fileName];
            [fileManager copyItemAtPath:tmpFilePath toPath:docFilePath error:&error];
        });
    }
    
//    if ([fileManager fileExistsAtPath:tmpFilePath]) {
//        NSRange fileNameRange=[tmpFilePath rangeOfString:@"tmp/"];
//        NSString *fileName= [tmpFilePath substringFromIndex:fileNameRange.location+fileNameRange.length];
//        filePath=[NSString stringWithFormat:@"%@/%@",_oneResouceFile,fileName];
//    if([fileManager fileExistsAtPath:filePath]==NO){
//            NSError*error;
//            BOOL hasCopy=[fileManager copyItemAtPath:tmpFilePath toPath:filePath error:&error];
//           [_picesSaveState addObject:[NSNumber numberWithBool:hasCopy]];
//        }
//    }
//    return filePath;
}


//    NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:dataDict];
//    [mutDic addEntriesFromDictionary:@{@"openid": @"o6_bmjrPTlm6_2sgVt7hMZOPfL2M"}];

-(void)getHttpData
{
    NSString *dest=[@"普吉岛" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",dest);
    
    NSDictionary *dataDic=@{
                            @"openid": @"oulbuvtpzxiOe6t9hVBh2mNRgiaI",
                            @"status":@1,
                            @"title":@"海岛游",
                            @"productCountryId":@"2",
                            @"dest":@[@"普吉岛"],
                            @"spell_buy_price":@5000,
                            @"start_time":@"2016-4-28",
                            @"end_time":@"2016-5-10",
                            @"spell_end_time":@"2016-7-28",
                            @"cover":@"http://....",
                            @"desc":@"筹旅费文字描述",
//                            @"voice":@"http://....",
                            @"video":@"http://....",
                            @"videoImg":@"http://...",
                            @"schedule":@[
                                    @{
                                        @"day": @1,
//                                        @"spot": @"景点描述",
//                                        @"spots":@[@"url1",@"url2"],
//                                        @"trans":@"交通描述",
//                                        @"live":@"住宿描述",
//                                        @"food":@"饮食描述",
//                                        @"desc":@"第一天描述",
                                        @"voice":@"http://...",
                                        @"video":@"http://...",
                                        @"videoImg":@"http://..."
                                        }
                                    ],
                            @"report": @[
                                    @{
                                        @"style": @1,
                                        @"price": @1
                                        },
                                    @{
                                        @"style": @2,
                                        @"price": @0
                                        },
                                    @{
                                        @"style": @5,
                                        @"people":@8,
                                        @"price": @100
                                        },
                                    @{
                                        @"style": @6,
                                        @"price": @0
                                        },
                                    @{
                                        @"style": @7,
                                        @"price": @0
                                        },
                                    @{
                                        @"style": @8,
                                        @"price": @0
                                        },
                                    @{
                                        @"style": @9,
                                        @"price": @1000
                                        }
                                    ]
                            
                            };
    NSLog(@"%@",[self turnJson:dataDic]);
    [ZYZCHTTPTool postHttpDataWithEncrypt:NO andURL:ADDPRODUCT andParameters:dataDic andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        
    }
    andFailBlock:^(id failResult)
     {
         NSLog(@"%@",failResult);
         
     }];
}

-(void)getHttp
{
    [ZYZCHTTPTool getHttpDataByURL:@"http://121.40.225.119:8080/user/getCountryInfo.action?" withSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
    } andFailBlock:^(id failResult) {
        
    }];
}

-(NSString *)turnJson:(NSDictionary *)dic
{
//    转换成json
        NSData *data = [NSJSONSerialization dataWithJSONObject :dic options : NSJSONWritingPrettyPrinted error:NULL];
    
        NSString *jsonStr = [[ NSString alloc ] initWithData :data encoding : NSUTF8StringEncoding];
    
    return jsonStr;
}

#pragma mark --- 定时保存数据
-(void)timeRunToSaveData
{
    
}

@end
