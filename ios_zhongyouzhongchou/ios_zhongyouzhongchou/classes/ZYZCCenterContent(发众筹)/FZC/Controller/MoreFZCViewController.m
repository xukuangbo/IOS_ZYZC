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
@interface MoreFZCViewController ()<MoreFZCToolBarDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSString *oneResouceFile;
@property (nonatomic, strong) NSString *archiveDataPath;
@property (nonatomic, strong) NSMutableArray *picesSaveState;
@property (nonatomic, assign) BOOL isFirstTimeToSave;
@end

@implementation MoreFZCViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
   
    [super viewDidLoad];
     self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    _picesSaveState=[NSMutableArray array];
    [self setBackItem];
    [self createToolBar];
    [self createClearMapView];
    [self createBottomView];
}
#pragma mark - 自定义方法
/**
 *  重写返回键方法
 */
-(void)pressBack
{
    //退出时，如果有填写发众筹内容，提示保存
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    NSDictionary *managerDict = manager.mj_keyValues;
    NSLog(@"%ld",managerDict.count);
    if (managerDict.count>6||manager.goal_goals.count>1) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"是否保存已编辑的数据" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
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
    //保存数据
    if (buttonIndex ==1)
    {
        [self saveData];
    }
    //不保存
    else
    {
        
        //释放单例中存储的内容
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        [manager initAllProperties];
         //删除临时文件夹内容
        [self cleanTmpFile];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark --- 删除临时文件
-(void)cleanTmpFile
{
    NSString *tmpDir = NSTemporaryDirectory();
    
    NSFileManager *manager=[NSFileManager defaultManager];
    
    NSArray *fileArr=[manager subpathsAtPath:tmpDir];
    
    for (NSString *fileName in fileArr) {
        
        NSString *filePath = [tmpDir stringByAppendingPathComponent:fileName];
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             [manager removeItemAtPath:filePath error:nil];
         });
    }
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
            [self saveData];
            break;
    }
}

-(void)nextOneOrPublish:(UIButton *)button
{
    //下一步
    if (button.tag<MoreFZCToolBarTypeReturn) {
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
        NSLog(@"发布");
        [self publishMyZhongChou];

    }
}

#pragma mark --- 发布我的众筹
-(void)publishMyZhongChou
{
    [self saveModelInManager];
    BOOL hasLossMessage= [NecessoryAlertManager showNecessoryAlertView];
    if (!hasLossMessage) {
        //可发布状态
        [MBProgressHUD showMessage:@"正在发布,请稍等..."];
        
        [MBProgressHUD hideHUD];
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
    _oneResouceFile=[self resoureSubFilePath];
    [MBProgressHUD showMessage:nil];
    
    [self saveModelInManager];
    
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    __weak typeof (&*self)weakSelf=self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //将图片，语音，视屏文件从tmp中移动到documents中
        manager.goal_travelThemeImgUrl=[weakSelf copyTmpFileToDocument:manager.goal_travelThemeImgUrl ];
        manager.raiseMoney_voiceUrl=[weakSelf copyTmpFileToDocument:manager.raiseMoney_voiceUrl ];
        manager.raiseMoney_movieUrl=[weakSelf copyTmpFileToDocument:manager.raiseMoney_movieUrl ];
        manager.raiseMoney_movieImg=[weakSelf copyTmpFileToDocument:manager.raiseMoney_movieImg ];
        for (int i=0; i<manager.travelDetailDays.count; i++) {
            MoreFZCTravelOneDayDetailMdel *model=manager.travelDetailDays[i];
            model.voiceUrl=[weakSelf copyTmpFileToDocument:model.voiceUrl ];
            model.movieUrl=[weakSelf copyTmpFileToDocument:model.movieUrl ];
            model.movieImg=[weakSelf copyTmpFileToDocument:model.movieImg ];
            [manager.travelDetailDays replaceObjectAtIndex:i withObject:model];
        }
        manager.return_voiceUrl=[weakSelf copyTmpFileToDocument:manager.return_voiceUrl ];
        manager.return_movieUrl=[weakSelf copyTmpFileToDocument:manager.return_movieUrl ];
        manager.return_movieImg=[weakSelf copyTmpFileToDocument:manager.return_movieImg ];
        manager.return_voiceUrl01=[weakSelf copyTmpFileToDocument:manager.return_voiceUrl01 ];
        manager.return_movieUrl01=[weakSelf copyTmpFileToDocument:manager.return_movieUrl01 ];
        manager.return_movieImg01=[weakSelf copyTmpFileToDocument:manager.return_movieImg01 ];
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
            [self saveDataInMyZhongChouPlist];
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
        if (modelDict.count>3) {
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

#pragma mark --- 在resoure文件下创建子文件来保存众筹的相关图片、语音、视屏资源
-(NSString *)resoureSubFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/%@/%@", pathDocuments,KDOCUMENT_FILE,[ZYZCTool getLocalTime]];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return createPath;
}


#pragma mark --- 将临时文件移到documents中
-(NSString *)copyTmpFileToDocument:(NSString *)tmpFilePath
{
    NSFileManager*fileManager =[NSFileManager defaultManager];
    NSString *filePath=nil;
    if ([fileManager fileExistsAtPath:tmpFilePath]) {
        NSRange fileNameRange=[tmpFilePath rangeOfString:@"tmp/"];
        NSString *fileName= [tmpFilePath substringFromIndex:fileNameRange.location+fileNameRange.length];
        filePath=[NSString stringWithFormat:@"%@/%@",_oneResouceFile,fileName];
    if([fileManager fileExistsAtPath:filePath]==NO){
            NSError*error;
            BOOL hasCopy=[fileManager copyItemAtPath:tmpFilePath toPath:filePath error:&error];
           [_picesSaveState addObject:[NSNumber numberWithBool:hasCopy]];
        }
    }
    return filePath;
}


//    NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:dataDict];
//    [mutDic addEntriesFromDictionary:@{@"openid": @"o6_bmjrPTlm6_2sgVt7hMZOPfL2M"}];

//    NSDictionary *dataDic=@{
//                            @"openid": @"o6_bmjrPTlm6_2sgVt7hMZOPfL2M",
//                            @"status":@1,
//                            @"title":@"海岛游",
//                            @"productCountryId":@[@"1",@"2"],
//                            @"dest":@[@"普吉岛",@"清迈"],
//                            @"spell_buy_price":@5000,
//                            @"start_time":@"2016-4-28",
//                            @"end_time":@"2016-5-10",
//                            @"spell_end_time":@"2016-7-28",
//                            @"people":@8,
//                            @"cover":@"http://....",
//                            @"desc":@"筹旅费文字描述",
//                            @"voice":@"http://....",
//                            @"video":@"http://....",
//                            @"videoImg":@"http://...",
//                            @"schedule":@[
//                                        @{
//                                             @"day": @1,
//                                             @"spot": @"景点描述",
//                                             @"spots":@[@"url1",@"url2"],
//                                             @"trans":@"交通描述",
//                                             @"live":@"住宿描述",
//                                             @"food":@"饮食描述",
//                                             @"desc":@"第一天描述",
//                                             @"voice":@"http://...",
//                                             @"video":@"http://...",
//                                             @"videoImg":@"http://..."
//                                           },
//                                        @{
//                                            @"day": @2,
//                                            @"spot": @"景点描述2",
//                                            @"spots":@[@"url1",@"url2"],
//                                            @"trans":@"交通描述2",
//                                            @"live":@"住宿描述2",
//                                            @"desc":@"第二天描述",
//                                            @"voice":@"http://...",
//                                            @"video":@"http://...",
//                                            @"videoImg":@"http://..."
//                                        },
//                                        @{
//                                            @"day": @3,
//                                            @"spot": @"景点描述3",
//                                            @"spots":@[@"url1",@"url2"],
//                                            @"trans":@"交通描述3",
//                                            @"live":@"住宿描述3",
//                                            @"desc":@"第三天描述",
//                                            @"voice":@"http://...",
//                                            @"video":@"http://...",
//                                            @"videoImg":@"http://..."
//                                        }],
//                            @"report": @[
//                                       @{
//                                           @"style": @1,
//                                           @"price": @1
//                                       },
//                                       @{
//                                           @"style": @2,
//                                           @"price": @0
//                                       },
//                                       @{
//                                           @"style": @3,
//                                           @"price": @200,
//                                           @"people": @5,
//                                           @"desc": @"回报目的1",
//                                           @"voice":@"http://",
//                                           @"video":@"http://",
//                                           @"videoImg":@"http://..."
//                                       },
//                                       @{
//                                           @"style": @4,
//                                           @"price": @300,
//                                           @"people": @6,
//                                           @"desc": @"回报目的2",
//                                           @"voice":@"http://",
//                                           @"video":@"http://",
//                                           @"videoImg":@"http://..."
//                                        },
//                                       @{
//                                           @"style": @5,
//                                           @"people":@8,
//                                           @"price": @100
//                                       },
//                                       @{
//                                           @"style": @6,
//                                           @"price": @1000
//                                        },
//                                       @{
//                                           @"style": @7,
//                                           @"price": @1000
//                                        },
//                                       @{
//                                           @"style": @8,
//                                           @"price": @1000
//                                        },
//                                       @{
//                                           @"style": @9,
//                                           @"price": @1000
//                                        }
//                                       ]
//
//                    };
//    [ZYZCHTTPTool postHttpDataWithEncrypt:NO andURL:ADDPRODUCT andParameters:dataDic andSuccessGetBlock:^(id result, BOOL isSuccess) {
//        NSLog(@"%@",result);
//
//    }
//    andFailBlock:^(id failResult)
//    {
//        NSLog(@"%@",failResult);
//
//    }];

@end
