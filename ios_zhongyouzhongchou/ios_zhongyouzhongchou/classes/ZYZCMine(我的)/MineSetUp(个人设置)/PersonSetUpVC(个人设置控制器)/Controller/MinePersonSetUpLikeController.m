//
//  MinePersonSetUpLikeController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonSetUpLikeController.h"

#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]
@interface MinePersonSetUpLikeController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation MinePersonSetUpLikeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackItem];
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];
    
    [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
    
    self.title = @"选择旅行标签";
    
//    [self createUI];
}

//- (void)createUI
//{
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:scrollView];
//    self.scrollView = scrollView;
//    scrollView.backgroundColor = [UIColor redColor];
//    
//    //白色背景容器
//    CGFloat mapViewX = KEDGE_DISTANCE;
//    CGFloat mapViewY = KEDGE_DISTANCE;
//    CGFloat mapViewW = KSCREEN_W - KEDGE_DISTANCE * 2;
//    CGFloat mapViewH = 300;
//    UIImageView *mapView = [[UIImageView alloc] initWithFrame:CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH)];
//    mapView.layer.cornerRadius = 5;
//    mapView.layer.masksToBounds = YES;
//    mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
//    [scrollView addSubview:mapView];
//    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, mapView.width - 10 * 2, mapView.height - 10 * 2) collectionViewLayout:flowLayout];
////    collectionView registerClass:[] forCellWithReuseIdentifier:<#(nonnull NSString *)#>
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    [scrollView addSubview:collectionView];
//    
//}
//
//#pragma mark - UICollectionViewDataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 20;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell =
//}
@end
