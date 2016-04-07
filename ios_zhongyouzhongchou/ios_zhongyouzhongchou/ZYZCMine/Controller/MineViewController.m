//
//  MineViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadView.h"

const CGFloat MineTopViewH = 200;
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  头视图
 */
@property (nonatomic, weak) MineHeadView *topView;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation MineViewController
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackItem];
    
    /**
     *  设置导航栏的颜色
     */
    [self setUpNavi];
    
    /**
     *  创建tableView
     */
    [self createTableView];
    
    //创建一个头视图的view
    [self createHeadView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 自定义初始化方法
/**
 *  设置导航栏的颜色
 */
- (void)setUpNavi{
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    //    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

/**
 *  创建头视图
 */
- (void)createHeadView
{
    CGFloat topViewX = 0;
    CGFloat topViewY = -MineTopViewH * KCOFFICIEMNT;
    CGFloat topViewW = KSCREEN_W;
    CGFloat topViewH = MineTopViewH * KCOFFICIEMNT;
    MineHeadView *topView = [[MineHeadView alloc] initWithFrame:CGRectMake(topViewX,topViewY, topViewW, topViewH)];
    
    topView.image = [UIImage imageNamed:@"abc"];
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:topView atIndex:0];
//    [self.view addSubview:topView];
    self.topView = topView;
}

/**
 *  创建tableView
 */
- (void)createTableView
{
    /**
     *  创建tableView
     */
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    __weak typeof(&*self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        NSLog(@"---------下拉刷新一次");
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    // 设置内边距(让cell往下移动一段距离)
    self.tableView.contentInset = UIEdgeInsetsMake(MineTopViewH * KCOFFICIEMNT, 0, 0, 0);
    NSLog(@"%@",NSStringFromCGRect(self.tableView.bounds));
    //
    //  UIImageView *topView = [[UIImageView alloc] init];
    //    topView.image = [UIImage imageNamed:@"biaoqingdi"];
    //    topView.frame = CGRectMake(0, -MineTopViewH, 320, MineTopViewH);
    //    topView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.tableView insertSubview:topView atIndex:0];
    //    self.topView = topView;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.contentView.backgroundColor = [UIColor greenColor];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}

/**
 *  暂时不做下拉放大
 */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 向下拽了多少距离
//    CGFloat down = -(MineTopViewH * KCOFFICIEMNT * 0.7) - scrollView.contentOffset.y;
//    if (down < 0) return;
//    
//    CGRect frame = self.topView.frame;
//    // 5决定图片变大的速度,值越大,速度越快
//    frame.size.height = MineTopViewH * KCOFFICIEMNT + down * 3;
//    self.topView.frame = frame;
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 向下拽了多少距离
//    CGFloat down = -(MineTopViewH * KCOFFICIEMNT * 0.7) - scrollView.contentOffset.y;
//    if (down > 0) {
//        return;
//    }
//    
//    self.topView.top += down;
//}
@end
