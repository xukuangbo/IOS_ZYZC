//
//  MineTravelTagsFirstView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineTravelTagsFirstView.h"
#import "MineTravelTagsCell.h"
@interface MineTravelTagsFirstView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation MineTravelTagsFirstView
static NSString *const ID = @"MineTravelTagsCollectionViewCell";
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource =self;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[MineTravelTagsCell class] forCellWithReuseIdentifier:ID];
        self.titleArray = @[@"阿达",@"阿asd达",@"阿发阿萨德达",@"阿达",@"阿达",@"阿达",@"阿无敌达",@"阿按地区的达",@"阿安全达",@"阿粉红",@"达",@"阿三公分吧说的达",@"阿啊达",@"阿按地方噶",@"阿达",@"阿胡达",@"阿发电脑你达",@"阿达聚客通"];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineTravelTagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.tagsLabel.font = tagsLabelFont;
    cell.tagsLabel.text = _titleArray[indexPath.item];
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
    
    return CGSizeMake(width - 10, titleSize.height + 10);
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
