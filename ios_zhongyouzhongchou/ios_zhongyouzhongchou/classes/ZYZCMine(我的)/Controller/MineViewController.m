//
//  MineViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadView.h"
#import "MineCenterTableView.h"
#import "MineFootTableView.h"

//const CGFloat MineTopViewH = 200;
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) MineCenterTableView *centerTableView;
@property (nonatomic, weak) MineFootTableView *footTableView;
@end

@implementation MineViewController
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setBackItem];
    
    /**
     *  设置导航栏的颜色
     */
    [self setUpNavi];
    
    /**
     *  创建2个tableView
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
//    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    //    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

/**
 *  创建头视图
 */
- (void)createHeadView
{
    CGFloat topViewX = 0;
//    CGFloat topViewY = -MineTopViewH * KCOFFICIEMNT;
    CGFloat topViewY = 0;
    CGFloat topViewW = KSCREEN_W;
    CGFloat topViewH = MineTopViewH * KCOFFICIEMNT;
    MineHeadView *topView = [[MineHeadView alloc] initWithFrame:CGRectMake(topViewX,topViewY, topViewW, topViewH)];
    
    topView.image = [UIImage imageNamed:@"abc"];
    topView.contentMode = UIViewContentModeScaleAspectFill;
    __weak typeof(&*self) weakSelf = self;
    topView.headChangeBlock = ^(UIButton *button){
        if (button.tag == KMineHeadViewChangeType) {//是我的中心
            weakSelf.topView.myCenterButton.backgroundColor = [UIColor whiteColor];
            [weakSelf.topView.myCenterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            weakSelf.topView.myFootButton.backgroundColor = kMineChangeButtonNormalColor;
            [weakSelf.topView.myFootButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //这里开始让tableview显示跟隐藏
            weakSelf.centerTableView.hidden = NO;
            weakSelf.footTableView.hidden = YES;
        }else if (button.tag == KMineHeadViewChangeType + 1){
            //我的足迹
            weakSelf.topView.myFootButton.backgroundColor = [UIColor whiteColor];
            [weakSelf.topView.myFootButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            weakSelf.topView.myCenterButton.backgroundColor = kMineChangeButtonNormalColor;
            [weakSelf.topView.myCenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            weakSelf.centerTableView.hidden = YES;
            weakSelf.footTableView.hidden = NO;
        }
    };
    [self.view addSubview:topView];
    self.topView = topView;
}

/**
 *  创建tableView
 */
- (void)createTableView
{
    /**
     *  创建centertableView
     */
//    UITableView *centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(KEDGE_DISTANCE, 0, KSCREEN_W - KEDGE_DISTANCE * 2, KSCREEN_H - KTABBAR_HEIGHT - KEDGE_DISTANCE) style:UITableViewStylePlain];
    MineCenterTableView *centerTableView = [[MineCenterTableView alloc] initWithFrame:CGRectMake(KEDGE_DISTANCE, 0, KSCREEN_W - KEDGE_DISTANCE * 2, KSCREEN_H - KTABBAR_HEIGHT - KEDGE_DISTANCE) style:UITableViewStylePlain];
    [self.view addSubview:centerTableView];
    self.centerTableView = centerTableView;
    
    /**
    *  创建foottableView
    */
    MineFootTableView *footTableView = [[MineFootTableView alloc] initWithFrame:CGRectMake(KEDGE_DISTANCE, 0, KSCREEN_W - KEDGE_DISTANCE * 2, KSCREEN_H - KTABBAR_HEIGHT - KEDGE_DISTANCE) style:UITableViewStylePlain];
    [self.view insertSubview:footTableView belowSubview:centerTableView];
    self.footTableView = footTableView;
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
//        cell.textLabel.text = [NSString stringWithFormat:@"第%zd个cell",indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}

/**
 *  暂时不做下拉放大
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下拽了多少距离
    CGFloat down = -(MineTopViewH * KCOFFICIEMNT) - scrollView.contentOffset.y;
    if (down < 0){
        self.topView.top = down;
        return;
    }else{
        self.topView.top = 0;
        CGRect frame = self.topView.frame;
        // 5决定图片变大的速度,值越大,速度越快
        frame.size.height = MineTopViewH * KCOFFICIEMNT + down * 1;
        self.topView.frame = frame;
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 向下拽了多少距离
//    CGFloat down = -(MineTopViewH * KCOFFICIEMNT * 0.7) - scrollView.contentOffset.y;
//    if (down < 0) return;
//    
//    CGRect frame = se lf.topView.frame;
//    // 5决定图片变大的速度,值越大,速度越快
//    frame.size.height = MineTopViewH * KCOFFICIEMNT + down * 3;
//    self.topView.frame = frame;
//}



@end
