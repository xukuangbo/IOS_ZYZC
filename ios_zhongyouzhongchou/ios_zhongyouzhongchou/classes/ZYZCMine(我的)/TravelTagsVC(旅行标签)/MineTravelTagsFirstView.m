//
//  MineTravelTagsFirstView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define MineTravelTagsTitleFont [UIFont systemFontOfSize:15]
#define MineTravelTagsDetailTitleFont [UIFont systemFontOfSize:12]
#import "MineTravelTagsFirstView.h"
#import "MineTravelTagsCell.h"
#import "MineTravelTagsModel.h"
#import <MJFoundation.h>
@interface MineTravelTagsFirstView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation MineTravelTagsFirstView

#pragma mark - system方法
static NSString *const ID = @"MineTravelTagsCollectionViewCell";
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource =self;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[MineTravelTagsCell class] forCellWithReuseIdentifier:ID];
        
        [MJFoundation isClassFromFoundation:[MineTravelTagsFirstView class]];
        [self requestData];
        
    }
    return self;
}

//- (void)setTitleArray:(NSArray *)titleArray
//{
//    _titleArray = titleArray;
//    
////    [self reloadData];
//}


#pragma mark - setUI方法

#pragma mark - requsetData方法
- (void)requestData{
    NSString *url = Get_TravelTag_List(1);
    
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
        
        NSLog(@"%@",result);
        weakSelf.titleArray = [MineTravelTagsModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        
        [weakSelf reloadData];
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
    
}
#pragma mark - set方法

#pragma mark - button点击方法


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineTravelTagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    MineTravelTagsModel *model = _titleArray[indexPath.item];
    cell.tagsLabel.font = tagsLabelFont;
    cell.tagsLabel.text = model.value;
    if (indexPath.item == _titleArray.count - 1) {//最后一个
        _changeRealHeightBlock(self.contentSize.height);
    }
    
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize titleSize = [ZYZCTool calculateStrLengthByText:@"呵呵" andFont:tagsLabelFont andMaxWidth:MAXFLOAT];
    CGFloat width = (collectionView.width - 3 * KEDGE_DISTANCE) / 4.0;
    
    return CGSizeMake(width, titleSize.height + 10);
//    return CGSizeMake(width, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%d个cell",indexPath.item);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
@end
