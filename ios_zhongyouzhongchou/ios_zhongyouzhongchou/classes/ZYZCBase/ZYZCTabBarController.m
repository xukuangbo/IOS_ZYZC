//
//  ZYZCTabBarController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/4.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCTabBarController.h"
#import "ZYZCCenterContentView.h"
#import "FXBlurView.h"
@interface ZYZCTabBarController ()
{
    FXBlurView *blurView;
    UIView *bgView;
    ZYZCCenterContentView *contentView;
}
@end

@implementation ZYZCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent = NO;
    self.tabBar.alpha=0.95;
    
     [self getCustomItems];
    [self insertSpaceItem];
}

-(void)getCustomItems
{
    
    NSArray *titleArray = @[@"攻略",@"众筹",@"商城",@"我的"];
    NSArray *imageArray = @[@"tab_one_gl",@"tab_two_zc",@"tab_thr_sc",@"tab_fou_min"];
    for (int i=0; i<4; i++){
        UINavigationController *navi = self.viewControllers[i];
        navi.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:[[UIImage imageNamed:imageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",imageArray[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    
    self.tabBar.tintColor = [UIColor ZYZC_MainColor];

}

-(void)insertSpaceItem
{
    UIViewController *spaceVC=[[UIViewController alloc]init];
    spaceVC.view.backgroundColor=[UIColor whiteColor];
    NSMutableArray *viewControllers=[NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers insertObject:spaceVC atIndex:2];
    self.viewControllers=viewControllers;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIView *coverView= [[UIView alloc]initWithFrame:CGRectMake(KSCREEN_W/2-40, 0, 80, self.tabBar.frame.size.height)];
    [self.tabBar addSubview:coverView];
    UIButton *moreBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(KSCREEN_W/2-22.5,(self.tabBar.frame.size.height-45)/2, 45, 45);
    [moreBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"tab_thr_fb"] forState:UIControlStateNormal];
    [self.tabBar addSubview:moreBtn];
}

#pragma mark --- 创建半框
-(void)clickBtn
{
    CGFloat origin_y=KSCREEN_H-302.5;
    //创建毛玻璃
    blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, origin_y, KSCREEN_W, 302.5)];
    [blurView setDynamic:YES];
//    blurView.blurRadius=10;
    [self.view addSubview:blurView];
    //给毛玻璃润色
    UIView *blackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, 302.5)];
    blackView.backgroundColor=[UIColor blackColor];
    blackView.alpha=0.35;
    [blurView addSubview:blackView];
    //毛玻璃以上添加黑色背景
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, origin_y)];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.3;
    [self.view addSubview:bgView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delete)];
    [bgView addGestureRecognizer:tap];
    //将内容栏覆盖到毛玻璃上
    contentView=[[ZYZCCenterContentView alloc]initWithFrame:CGRectMake(0, origin_y, KSCREEN_W, 302.5)];
    __weak typeof (&*self)weakSelf=self;
    contentView.deleteBlock=^()
    {
        [weakSelf delete];
    };
    contentView.pushVCBlock=^(ZYZCBaseViewController *zyzcVC)
    {
        zyzcVC.hidesBottomBarWhenPushed=YES;
        [weakSelf.selectedViewController pushViewController:zyzcVC animated:YES];
    };
    
    [contentView.deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:contentView];
}

#pragma mark --- 退出半框
-(void)delete
{
    [blurView removeFromSuperview];
    [bgView removeFromSuperview];
    [contentView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
