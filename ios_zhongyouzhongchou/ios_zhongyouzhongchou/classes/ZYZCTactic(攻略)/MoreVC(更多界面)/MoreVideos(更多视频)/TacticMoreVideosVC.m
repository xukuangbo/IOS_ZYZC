//
//  TacticMoreVideosVC.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticMoreVideosVC.h"
#import "TacticMoreCollectionViewCell.h"
#import "TacticThreeMapView.h"
#import "TacticImageView.h"
#import "TacticVideoModel.h"

@interface TacticMoreVideosVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *moreVideosModelArray;

@end

@implementation TacticMoreVideosVC
static NSString *const ID = @"TacticMoreVideosCell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [self requestData];
    
}

- (void)configUI
{
    [self setBackItem];
    self.title = @"更多攻略视频";
    self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H - 49) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    [collectionView registerClass:[TacticMoreCollectionViewCell class] forCellWithReuseIdentifier:ID];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}


- (void)requestData
{
    NSString *url = GET_TACTIC_More_Videos;
    NSLog(@"%@",url);
    //访问网络
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            //请求成功，转化为数组
            weakSelf.moreVideosModelArray = [TacticVideoModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [weakSelf.collectionView reloadData];
        }
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.moreVideosModelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TacticMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    TacticVideoModel *moreModel = self.moreVideosModelArray[indexPath.item];
    
    cell.imageView.pushType = threeMapViewTypeCityView;
    
    cell.imageView.tacticVideoModel = moreModel;
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ((collectionView.width - 5 * KEDGE_DISTANCE) / 3);
    return CGSizeMake(width, width);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
}

@end
