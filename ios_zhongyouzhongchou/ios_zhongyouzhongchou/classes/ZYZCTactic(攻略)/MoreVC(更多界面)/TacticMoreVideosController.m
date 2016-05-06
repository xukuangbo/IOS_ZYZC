//
//  TacticMoreVideosController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticMoreVideosController.h"
#import "TacticMoreCollectionViewCell.h"
#import "TacticSingleModel.h"
#import "TacticVideoModel.h"
#import "TacticSingleFoodModel.h"
#import "TacticImageView.h"
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]
#define naviHeight 64
@interface TacticMoreVideosController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, assign) PushVCType pushType;
@end
static NSString *const ID = @"MoreCollectioncell";
@implementation TacticMoreVideosController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)configUI
{
    [self setBackItem];
    
    self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H - 49) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    [collectionView registerClass:[TacticMoreCollectionViewCell class] forCellWithReuseIdentifier:ID];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
}

- (void)setMoreArray:(NSArray *)moreArray
{
    _moreArray = moreArray;
    if (moreArray.count > 0) {
        if ([moreArray[0] isKindOfClass:[TacticVideoModel class]]) {
            //说明是更多视频
            self.pushType = pushVCTypeVideo;
        }else if ([moreArray[0] isKindOfClass:[TacticSingleFoodModel class]]){
            //说明是更多食物
            self.pushType = pushVCTypeFood;
        }else{
            //说明是更多景点
            self.pushType = pushVCTypeSingleView;
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.moreArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TacticMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (self.pushType == pushVCTypeVideo) {
        TacticVideoModel *model = self.moreArray[indexPath.item];
        cell.imageView.tacticVideoModel = model;
    }else if (self.pushType == pushVCTypeFood){
        TacticSingleFoodModel *model = self.moreArray[indexPath.item];
        cell.imageView.tacticSingleFoodModel = model;
    }else if (self.pushType == pushVCTypeSingleView){
        TacticSingleModel *model = self.moreArray[indexPath.item];
        cell.imageView.tacticSingleModel = model;
    }
    
    cell.pushVCType = self.pushType;
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
@end
