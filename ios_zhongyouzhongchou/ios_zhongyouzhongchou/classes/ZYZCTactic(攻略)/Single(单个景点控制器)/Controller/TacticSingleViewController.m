//
//  TacticSingleViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleViewController.h"
#import "TacticSingleModel.h"
#import "TacticSingleFoodModel.h"
#import "TacticSingleTipsModel.h"
#import "TacticSingleTableViewCell.h"
#import "TacticSingleHeadView.h"
#import "UIView+TacticMapView.h"
@interface TacticSingleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) TacticSingleModel *tacticSingleModel;
@end



@implementation TacticSingleViewController

- (instancetype)initWithViewId:(NSInteger)viewId
{
    self = [super init];
    if (self) {
        self.viewId = viewId;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackItem];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    /**
     *  设置导航栏
     */
    [self setUpNavi];
    /**
     *  创建tableView
     */
    [self createTableView];
    
    /**
     *  刷新数据
     */
    [self refreshDataWithViewId:self.viewId];
    
}

- (void)setViewId:(NSInteger)viewId
{
    if (_viewId != viewId) {
        _viewId = viewId;
        
    }
}
/**
 *  刷新数据
 */
- (void)refreshDataWithViewId:(NSInteger)viewId
{
//    http://localhost:8080/viewSpot/getViewSpot.action?viewId=13
    NSString *url = [NSString stringWithFormat:@"http://121.40.225.119:8080/viewSpot/getViewSpot.action?viewId=%ld",(long)viewId];
    //访问网络
    
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            //请求成功，转化为数组
//            NSLog(@"%@",result);
            TacticSingleModel *tacticSingleModel = [TacticSingleModel mj_objectWithKeyValues:result[@"data"]];
            weakSelf.tacticSingleModel = tacticSingleModel;
            
            [weakSelf.tableView reloadData];
        }
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}


/**
 *  设置导航栏
 */
- (void)setUpNavi
{
    [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(0)];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

/**
 *  创建tableView
 */
- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"TacticSingleTableViewCell";
    TacticSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TacticSingleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    //这里进行模型的赋值
    cell.singleModel = self.tacticSingleModel;
    return cell;
}

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TacticSingleHeadViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TacticSingleHeadView *headView = [[TacticSingleHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, 50)];
    headView.nameLabel.text = self.tacticSingleModel.name;
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    
    [headView sd_setImageWithURL:[NSURL URLWithString:KWebImage(self.tacticSingleModel.viewImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
    headView.backgroundColor = [UIColor redColor];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (oneViewHeight * 3) + (TacticTableViewCellMargin * 5) + 120;
}


/**
 *  navi背景色渐变的效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= oneViewHeight) {
        CGFloat alpha = MAX(0, offsetY/oneViewHeight);
        
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(alpha)];
        self.title = @"";
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
        if (self.tacticSingleModel) {
            self.title = self.tacticSingleModel.name;
        }
        
    }
}


@end
