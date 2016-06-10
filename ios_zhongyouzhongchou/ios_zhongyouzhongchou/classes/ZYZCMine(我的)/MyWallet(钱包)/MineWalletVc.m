//
//  MineWalletVc.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineWalletVc.h"

@interface MineWalletVc ()
@property (nonatomic, strong) UIView *headMapView;

@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation MineWalletVc

#pragma mark - system方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.translucent = NO;
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    
    [self configUI];
}
#pragma mark - setUI方法
- (void)configUI
{
    self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];

    [self createHeadView];
    
    
}

- (void)createHeadView
{
    _headMapView = [[UIView alloc] initWithFrame:CGRectMake(0, KNAV_STATUS_HEIGHT, KSCREEN_W, (KSCREEN_H - KNAV_STATUS_HEIGHT) / 2.0)];
    _headMapView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_headMapView];
    //标题
    CGFloat titleLabelW = KSCREEN_W;
    CGFloat titleLabelH = 20;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = KEDGE_DISTANCE;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.text = @"可提现旅费";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_headMapView addSubview:titleLabel];
    
    //金额
    CGFloat moneyLabelW = KSCREEN_W;
    CGFloat moneyLabelH = 20;
    CGFloat moneyLabelX = 0;
    CGFloat moneyLabelY = 50;
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH)];
    _moneyLabel.center = CGPointMake(_headMapView.width * 0.5, _headMapView.height * 0.5);
    _moneyLabel.backgroundColor = [UIColor blueColor];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    _moneyLabel.text = @"￥8000.00";
    [_headMapView addSubview:_moneyLabel];
    
    
    
}
#pragma mark - requsetData方法

#pragma mark - set方法

#pragma mark - button点击方法

#pragma mark - delegate方法

@end
