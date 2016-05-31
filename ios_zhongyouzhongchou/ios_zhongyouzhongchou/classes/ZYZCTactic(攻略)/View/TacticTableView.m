//
//  TacticTableView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticTableView.h"
#import "SDCycleScrollView.h"
#import "TacticMainViewController.h"
#import "TacticModel.h"
#import "MJExtension.h"
#import "TacticCustomMapView.h"

#import "TacticTableViewCell.h"
@interface TacticTableView ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSArray *headImageArray;
@end

@implementation TacticTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor ZYZC_BgGrayColor];
        self.separatorColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        
        //这里要集成下拉刷新还有
        __weak typeof(&*self) weakSelf = self;
        self.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf reloadRefreshData];
            
            [weakSelf reloadData];
            [weakSelf.mj_header endRefreshing];
        }];
        
        [self.mj_header beginRefreshing];
    }
    return self;
}
/**
 *  下拉刷新数据
 */
- (void)reloadRefreshData
{
//    NSString *Json_path = [[NSBundle mainBundle] pathForResource:@"HomeMessage.json" ofType:nil];
//    //==Json数据
//    NSData *data=[NSData dataWithContentsOfFile:Json_path];
//    //==JsonObject
//    
//    NSDictionary *JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    //拿到字典，转化成模型
//    TacticModel *model = [TacticModel mj_objectWithKeyValues:JsonObject[@"data"]];
//    _tacticModel = model;
//    
//    _headImageArray = model.pics;
    NSString *url = [NSString stringWithFormat:@"http://www.sosona.cn:8080/viewSpot/getIndexHot.action"];
    //访问网络
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            //请求成功，转化为数组
            TacticModel *tacticModel = [TacticModel mj_objectWithKeyValues:result[@"data"]];
            weakSelf.tacticModel = tacticModel;
            
            [weakSelf reloadData];
        }
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
    
}

#pragma mark - UITableDelegate和Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        NSString *ID = @"TacticTableViewCell";
        TacticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[TacticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.tacticModel = _tacticModel;
        
        return cell;
    }
    static NSString *ID = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 网络加载 --- 创建带标题的图片轮播器
//    NSArray *titles = @[@"柳亮机器人一号",@"柳亮机器人二号",@"柳亮机器人三号",@"柳亮机器人四号",@"柳亮机器人五号"];
    SDCycleScrollView *headView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, KSCREEN_W, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //添加渐变条
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, 64)];
    bgImg.image=[UIImage imageNamed:@"Background"];
    [headView addSubview:bgImg];
    
    headView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    headView.pageDotColor = [UIColor whiteColor];
    headView.currentPageDotColor = [UIColor ZYZC_MainColor]; // 自定义分页控件小圆标颜色
    NSMutableArray *headURLArray = [NSMutableArray array];
    if (self.tacticModel.pics) {
        for (NSString *urlString in self.tacticModel.pics) {
            NSString *tempUrlString = KWebImage(urlString);
            [headURLArray addObject:tempUrlString];
        }
    }
    headView.imageURLStringsGroup = headURLArray;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (threeViewMapHeight * 2) + TacticTableViewCellMargin * 3;
}
/**
 *  navi背景色渐变的效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    TacticMainViewController *homeVC = (TacticMainViewController *)self.viewController;
    if (offsetY <= headViewHeight) {
        CGFloat alpha = MAX(0, offsetY/headViewHeight);
        
        [homeVC.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(alpha)];
        
    } else {
        [homeVC.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    //    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}
@end
