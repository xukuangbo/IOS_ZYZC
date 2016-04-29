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

#define kMoreFZCToolBar 20
#define kNaviBar 64
@interface MoreFZCViewController ()<MoreFZCToolBarDelegate>
@end

@implementation MoreFZCViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
   
    [super viewDidLoad];
     self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
//    NSLog(@"manager:%@",manager);
    
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
    [super pressBack];
    /**
     *  释放单例中存储的内容
     */
    
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
    
    NSArray *titleArr=@[@"预   览",@"下一步",@"保   存"];
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
    
//    if (_travelTableIsCover==1) {
//        UITableView *tableView=(UITableView *)[self.clearMapView viewWithTag:MoreFZCToolBarTypeTravel];
//        [tableView reloadData];
//    }
    
    if (tableView.tag!=MoreFZCToolBarTypeGoal) {
        if (_goalKeyBordHidden) {
            _goalKeyBordHidden();
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
            
            break;
        default:
        case SaveType:
            //保存数据
            [self saveData];
            break;
    }
}

#pragma mark --- 保存数据
-(void)saveData
{
    //保存旅游每日行程安排到单例中
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    
    [manager.travelDetailDays removeAllObjects];
    MoreFZCTravelTableView *travelTable=[(MoreFZCTravelTableView *)self.clearMapView viewWithTag:MoreFZCToolBarTypeTravel];
    for (NSInteger i=0; i<travelTable.travelDetailCellArr.count; i++) {
        TravelSecondCell *travelSecondCell=travelTable.travelDetailCellArr[i];
        [travelSecondCell saveTravelOneDayDetailData];
        [manager.travelDetailDays addObject:travelSecondCell.oneDetailModel];
    }
    
    
    
    //归档
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *localTime=[ZYZCTool getLocalTime];
    NSString *filePath=[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"WSMContentData%@.data",localTime]];
    NSLog(@"归档数据filePath:%@",filePath);
    [NSKeyedArchiver archiveRootObject:manager toFile:filePath];
    //解档
    MoreFZCDataManager *fileManager=[NSKeyedUnarchiver  unarchiveObjectWithFile:filePath];
    
    // 模型转字典
    NSDictionary *dataDict = fileManager.mj_keyValues;
    NSLog(@"dataDict:%@",dataDict);
    
    
    NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:dataDict];
    [mutDic addEntriesFromDictionary:@{@"openid": @"o6_bmjrPTlm6_2sgVt7hMZOPfL2M"}];
    
    NSDictionary *dataDic=@{
                            @"openid": @"o6_bmjrPTlm6_2sgVt7hMZOPfL2M",
                            @"status":@1,
                            @"title":@"海岛游",
                            @"productCountryId":@[@"1",@"2"],
                            @"dest":@[@"普吉岛",@"清迈"],
                            @"spell_buy_price":@5000,
                            @"start_time":@"2016-4-28",
                            @"end_time":@"2016-5-10",
                            @"spell_end_time":@"2016-7-28",
                            @"people":@8,
                            @"cover":@"http://....",
                            @"desc":@"筹旅费文字描述",
                            @"voice":@"http://....",
                            @"movie":@"http://....",
                            @"schedule":@[
                                        @{
                                             @"day": @1,
                                             @"spot": @"景点描述",
                                             @"spots":@[@"url1",@"url2"],
                                             @"trans":@"交通描述",
                                             @"live":@"住宿描述",
                                             @"food":@"饮食描述",
                                             @"desc":@"第一天描述",
                                             @"voice":@"http://...",
                                             @"movie":@"http://..."
                                           },
                                        @{
                                            @"day": @2,
                                            @"spot": @"景点描述2",
                                            @"spots":@[@"url1",@"url2"],
                                            @"trans":@"交通描述2",
                                            @"live":@"住宿描述2",
                                            @"desc":@"第二天描述",
                                            @"voice":@"http://...",
                                            @"movie":@"http://..."
                                        },
                                        @{
                                            @"day": @3,
                                            @"spot": @"景点描述3",
                                            @"spots":@[@"url1",@"url2"],
                                            @"trans":@"交通描述3",
                                            @"live":@"住宿描述3",
                                            @"desc":@"第三天描述",
                                            @"voice":@"http://...",
                                            @"movie":@"http://..."
                                        }],
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
                                           @"desc": @"回报目的",
                                           @"voice":@"http://",
                                           @"movie":@"http://"
                                       },
                                       @{
                                           @"style": @4,
                                           @"people":@8,
                                           @"price": @100
                                       },
                                       @{
                                           @"style": @5,
                                           @"price": @1000
                                        },
                                       @{
                                           @"style": @6,
                                           @"price": @1000
                                        },
                                       @{
                                           @"style": @7,
                                           @"price": @1000
                                        },
                                       @{
                                           @"style": @8,
                                           @"price": @1000
                                        }
                                       ]
                            
                    };
    NSLog(@"dataDic:%@",dataDic);
    [ZYZCHTTPTool postHttpDataWithEncrypt:NO andURL:ADDPRODUCT andParameters:dataDic andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        
    }
    andFailBlock:^(id failResult)
    {
        NSLog(@"%@",failResult);
        
    }];
}

-(NSString *)turnJson:(NSDictionary *)dic
{
//   转换成json
    NSData *data = [NSJSONSerialization dataWithJSONObject :dic options : NSJSONWritingPrettyPrinted error:NULL];
    
    NSString *jsonStr = [[ NSString alloc ] initWithData :data encoding : NSUTF8StringEncoding];
    return jsonStr;
}

#pragma mark --- 将临时文件移到documents中
-(NSString *)copyTmpFileToDocument:(NSString *)tmpFilePath
{
    
    NSFileManager*fileManager =[NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString*filePath =[documentsDirectory stringByAppendingPathComponent:[ZYZCTool getLocalTime]];
    
    if([fileManager fileExistsAtPath:filePath]== NO){
        if ([fileManager fileExistsAtPath:tmpFilePath]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSError*error;
                [fileManager copyItemAtPath:tmpFilePath toPath:filePath error:&error];
            });
            
        }
    }
    return filePath;
}

-(void)viewWillDisappear:(BOOL)animated
{
//    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
//    [manager initAllProperties];
//    NSLog(@"manager:%@",manager);
}


@end
