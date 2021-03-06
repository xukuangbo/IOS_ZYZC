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

#import "FZCSaveDraftData.h"
#import "ZCProductDetailController.h"


#define kMoreFZCToolBar 20
#define kNaviBar 64

#define ALERT_BACK_TAG    1
#define ALERT_UPLOAD_TAG  2
#define ALERT_PUBLISH_TAG 3

@interface MoreFZCViewController ()<MoreFZCToolBarDelegate,UIAlertViewDelegate>
@property (nonatomic, assign) BOOL needPopVC;
                              //记录发布的数据在oss的位置
@property (nonatomic, copy  ) NSString *myZhouChouMarkName;
                              //记录发布的所有文件的状态
//@property (nonatomic, strong) NSMutableArray *uploadDataState;
                              //要上传到oss上的文件个数
@property (nonatomic, assign) NSInteger uploadDataNumber;
                              //发布成功个数
@property (nonatomic, assign) NSInteger  uploadSuccessNumber;
                              //记录发布成功的状态
@property (nonatomic, assign) BOOL hasPulish;
                              //记录上传数据成功的状态
@property (nonatomic, assign) BOOL hasUpload;

                              //发布数据的参数
@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) ZCOneModel   *oneModel;

@property (nonatomic, strong) ZCDetailProductModel  *detailProductModel;

@property (nonatomic, strong) MBProgressHUD *mbProgress;


@end

@implementation MoreFZCViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
   
    [super viewDidLoad];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:[NSNumber numberWithInteger:0] forKey:KMOREFZC_RETURN_SUPPORTTYPE];
    [user synchronize];
     self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    _uploadDataState=[NSMutableArray array];
    [self setBackItem];
    [self createToolBar];
    [self createClearMapView];
    [self createBottomView];
//    [self getHttpData];
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
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"直接退出,所有数据将清除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=ALERT_BACK_TAG;
    [alert show];
}

#pragma mark --- alertView代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==ALERT_BACK_TAG) {
        //保存数据
        if (buttonIndex ==1)
        {
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            NSString *myDraftState=[user objectForKey:KMY_ZC_DRAFT_SAVE];
            //如果没有保存，则清空
            if (!myDraftState) {
                [ZYZCTool cleanZCDraftFile];
            }
            // 释放单例中存储的内容
            MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
            [manager initAllProperties];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    //数据上传到oss失败，提示重新上传
    else if (alertView.tag ==ALERT_UPLOAD_TAG)
    {
        //点击确定，重新上传数据到oss
        if (buttonIndex ==1) {
            [self uploadDataToOSS];
        }
    }
    //发布网络出错
    else if (alertView.tag ==ALERT_PUBLISH_TAG)
    {
//        if (buttonIndex ==1) {
//            [self publishMyZhongchou];
//        }
    }
}


#pragma mark --- 点击底部按钮触发事件
-(void)clickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case SkimType:
            [self skimZhongchou];
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

#pragma mark --- 浏览我的众筹
-(void)skimZhongchou
{
    _oneModel=[[ZCOneModel alloc]init];
    _detailProductModel=[[ZCDetailProductModel alloc]init];
    __weak typeof (&*self)weakSelf=self;
    [FZCSaveDraftData saveDraftDataInOneModel:_oneModel andDetailProductModel:_detailProductModel andDoBlock:^{
        [weakSelf zcDraftDetail];
    }];
}

-(void)zcDraftDetail
{
    ZCDetailModel *detailModel=[[ZCDetailModel alloc]init];
    detailModel.detailProductModel=_detailProductModel;
    ZCProductDetailController *draftDetailVC=[[ZCProductDetailController alloc]init];
    draftDetailVC.oneModel=_oneModel;
    draftDetailVC.oneModel.productType=ZCDetailProduct;
    draftDetailVC.detailModel=detailModel;
    draftDetailVC.schedule=_detailProductModel.schedule;
    draftDetailVC.detailProductType=DraftDetailProduct;
    [self.navigationController pushViewController:draftDetailVC animated:YES];

    
//    ZCPersonInfoController *personInfoVC=[[ZCPersonInfoController alloc]init];
//    personInfoVC.oneModel=_oneModel;
//    personInfoVC.detailModel=detailModel;
//    personInfoVC.schedule=_detailProductModel.schedule;
//    personInfoVC.zcType=MyDraft;
//    [self.navigationController pushViewController:personInfoVC animated:YES];
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
    
     _mbProgress=[MBProgressHUD showMessage:@"正在发布..."];
    _uploadSuccessNumber=0;
//    if (_uploadDataState.count) {
//        [_uploadDataState removeAllObjects];
//    }
//
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *failDataFile=[user objectForKey:KFAIL_UPLOAD_OSS];
    //如果上次标记的失败文件没有删除，先删除掉
    if (failDataFile) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            ZYZCOSSManager *ossManager=[ZYZCOSSManager defaultOSSManager];
            [ossManager deleteObjectsByPrefix:failDataFile andSuccessUpload:^
             {
                 [user setObject:nil forKey:KFAIL_UPLOAD_OSS];
                 [user synchronize];
                 dispatch_async(dispatch_get_main_queue(), ^{
                      [self continueUploadDataToOss];
                 });
             }
            andFailUpload:^
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [MBProgressHUD hideHUD];
                     UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"网络异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
                     [alertView show];

                 });
            }];

        });
    }
    else
    {
        [self continueUploadDataToOss];
    }
}

#pragma mark --- 上传新数据到oss
-(void)continueUploadDataToOss
{
    _myZhouChouMarkName=[ZYZCTool getLocalTime];
    
    //上传数据到oss,首先将远程文件标记为上传失败的文件，以免上传过程中意外退出导致部分文件留在oss上，文件上传成功将标记移除
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:[NSString stringWithFormat:@"%@/%@",[ZYZCTool getUserId],_myZhouChouMarkName] forKey:KFAIL_UPLOAD_OSS];
    [user synchronize];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSString *tmpFile=[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0],KMY_ZHONGCHOU_FILE];
    
    NSArray *tmpFileArr=[fileManager subpathsAtPath:tmpFile];
    _uploadDataNumber=tmpFileArr.count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^
       {
           for (int i=0; i<tmpFileArr.count; i++) {
               //文件上传到oss中以openId为文件名下的以_myZhouChouMarkName为文件名下
               ZYZCOSSManager *ossManager=[ZYZCOSSManager defaultOSSManager];
               BOOL uploadSuccess=[ossManager uploadObjectSyncByFileName:[NSString stringWithFormat:@"%@/%@",self.myZhouChouMarkName,tmpFileArr[i]]  andFilePath:[tmpFile stringByAppendingPathComponent:tmpFileArr[i]]];
//               [self.uploadDataState addObject:[NSNumber numberWithBool:uploadSuccess]];
               //上传失败
               if (!uploadSuccess) {
                   break;
               }
               //上传成功
               else
               {
                   _uploadSuccessNumber++;
                   //在主线程更行进度条
                   dispatch_async(dispatch_get_main_queue(), ^{
//                       NSInteger successNumber=_uploadDataState.count;
//                       NSLog(@"successNumber:%ld,%ld",successNumber,_uploadDataNumber);
                       _mbProgress.labelText=[NSString stringWithFormat:@"正在发布,已完成%.f％",(float)_uploadSuccessNumber/(float)_uploadDataNumber*100.0];
                   });
               }
           }
           //回到主线程
           dispatch_async(dispatch_get_main_queue(), ^
          {
              _hasUpload=_uploadSuccessNumber>=_uploadDataNumber;
              //数据上传成功，发布众筹
              if (_hasUpload) {
                  [self publishMyZhongchou];
              }
              //上传失败，提示重新上传
              else
              {
                  [MBProgressHUD hideHUD];
                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"网络异常，发布失败，是否重新发布" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                  alert.tag=ALERT_UPLOAD_TAG;
                  [alert show];
              }
          });
       });
}

#pragma mark --- 发布我的众筹
-(void)publishMyZhongchou
{
    //将数据转化成上传数据对应的类型
    FZCReplaceDataKeys *replaceKeys=[[FZCReplaceDataKeys alloc]init];
    [replaceKeys replaceDataKeysBySubFileName:_myZhouChouMarkName];
    // 模型转字典
    NSDictionary *dataDict = [replaceKeys mj_keyValuesWithIgnoredKeys:@[@"myZhouChouMarkName"]];
    
    NSMutableDictionary *newParameters=[NSMutableDictionary dictionaryWithDictionary:dataDict];
    [newParameters addEntriesFromDictionary:@{@"productCountryId":@1}];
//    //=======================================================
//    [newParameters setObject:@"http://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/12333.jpg" forKey:@"cover"];
//    //=======================================================
    _dataDic=newParameters;
     NSLog(@"_dataDic:%@",_dataDic);
    
    [self publishHttpData];
}

#pragma mark --- 发布请求
-(void)publishHttpData
{
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:ADDPRODUCT  andParameters:_dataDic andSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            //发送成功，删除本地数据
//            [self cleanTmpFile];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"发布成功!"];
             //将标记的失败文件置空，取消标记
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:nil forKey:KFAIL_UPLOAD_OSS];
            [user synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
            MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
            [manager initAllProperties];
//            [self cleanTmpFile];
            _hasPulish=YES;
        }
        else
        {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"数据丢失，发布失败"];
        }
    } andFailBlock:^(id failResult) {
        NSLog(@"_dataDic:%@",_dataDic);
        NSLog(@"failResult:%@",failResult);
        [MBProgressHUD hideHUD];
        //提示发布失败
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"数据错误,发布失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        alert.tag=ALERT_PUBLISH_TAG;
        [alert show];
    }];
}

-(void)getHttpData
{
    NSString *dest=[@"普吉岛" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",dest);
    
     NSString *str01=[@"⚽️" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str01);
     NSString *str02=[@"😄" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str02);

    NSString* str = [str02 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",str);
    NSDictionary *dataDic=@{
                            @"openid": @"oulbuvolvV8uHEyZwU7gAn8icJFw",
                            @"status":@1,
                            @"title":@"测试0002",
                            @"productCountryId":@"1",
                            @"dest":@[@"普吉岛"],
                            @"spell_buy_price":@5000,
                            @"start_time":@"2016-09-18",
                            @"end_time":@"2016-09-21",
                            @"spell_end_time":@"2016-09-03",
                            @"cover":@"http://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/oulbuvolvV8uHEyZwU7gAn8icJFw/20160517181332/20160517181124.png",
                            @"desc":@"筹旅费文字描述",
                            @"schedule":@[
                                    @{
                                        @"day": @1,
                                        @"desc":@"第一天描述",
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
                                        @"style": @3,
                                        @"price": @200,
                                        @"people": @5,
                                        @"desc": @"回报目的1",
                                        @"voice":@"www.baidu.com",
                                        @"video":@"www.souhu.com",
                                        @"videoUrl":@"www.tengxun.com"
                                        },
                                    @ {
                                        @"style": @4,
                                        @"people":@8,
                                        @"price": @100
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


-(NSString *)turnJson:(id )dic
{
//    转换成json
        NSData *data = [NSJSONSerialization dataWithJSONObject :dic options : NSJSONWritingPrettyPrinted error:NULL];
    
        NSString *jsonStr = [[ NSString alloc ] initWithData :data encoding : NSUTF8StringEncoding];
    
    return jsonStr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
}

@end
