//
//  MineTravelTagsVC.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define SetUpFirstCellLabelHeight 34
#define MineTravelTagsTitleFont [UIFont systemFontOfSize:15]
#define MineTravelTagsDetailTitleFont [UIFont systemFontOfSize:12]
#import "MineTravelTagsVC.h"
#import "MineTravelTagsFirstView.h"

@interface MineTravelTagsVC ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *firstBg;
@property (nonatomic, strong) MineTravelTagsFirstView *firstCollectionView;
@property (nonatomic, strong) UIImageView *secondBg;
@property (nonatomic, strong) UICollectionView *secondCollectionView;
@end

@implementation MineTravelTagsVC
static NSString *const ID = @"MineTravelTagsCollectionViewCell";
#pragma mark - system方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
//        self.navigationController.navigationBar.translucent = YES;
        self.title = @"旅行标签";
        [self configUI];
    }
    return self;
}
#pragma mark - setUI方法
- (void)configUI
{
    
    [self setBackItem];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KNAV_STATUS_HEIGHT, KSCREEN_W, KSCREEN_H - KNAV_STATUS_HEIGHT)];
    scrollView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    //第一个表格
    [self createFirstUI];
    
//    [self createSecondBg];
    
//    [self createSaveButton];
    
//    self.scrollView.contentSize = CGSizeMake(KSCREEN_W, self.saveButton.bottom + KEDGE_DISTANCE);
    if(self.scrollView.contentSize.height <= KSCREEN_H){
        self.scrollView.contentSize = CGSizeMake(KSCREEN_W, KSCREEN_H + KEDGE_DISTANCE);
    }
    NSLog(@"%@___%@",NSStringFromCGSize(self.scrollView.contentSize),NSStringFromCGRect( self.firstBg.frame));
}

- (void)createFirstUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 300;
    NSString *title = @"请选择你的旅行习惯";
    self.firstBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.firstBg.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.firstBg];
    
    CGSize titleSize = [ZYZCTool calculateStrLengthByText:title andFont:MineTravelTagsTitleFont andMaxWidth:MAXFLOAT];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KEDGE_DISTANCE, KEDGE_DISTANCE, titleSize.width, titleSize.height)];
    titleLabel.text = title;
    titleLabel.font = MineTravelTagsTitleFont;
    titleLabel.textColor = [UIColor blackColor];
    [_firstBg addSubview:titleLabel];
    
    NSString *detailTitle = @"最多10个标签";
    CGSize detailSize = [ZYZCTool calculateStrLengthByText:detailTitle andFont:MineTravelTagsDetailTitleFont andMaxWidth:MAXFLOAT];
    UILabel *detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right + KEDGE_DISTANCE, KEDGE_DISTANCE, detailSize.width, detailSize.height)];
    detailTitleLabel.text = detailTitle;
    detailTitleLabel.font = MineTravelTagsDetailTitleFont;
    detailTitleLabel.textColor = [UIColor blackColor];
    detailTitleLabel.bottom = titleLabel.bottom;
    [_firstBg addSubview:detailTitleLabel];
    
    
    CGFloat firstCollectionViewX = KEDGE_DISTANCE;
    CGFloat firstCollectionViewY = titleLabel.bottom + KEDGE_DISTANCE;
    CGFloat firstCollectionViewW = _firstBg.width - 2 * firstCollectionViewX;
    CGFloat firstCollectionViewH = _firstBg.height - 2 * firstCollectionViewY;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _firstCollectionView = [[MineTravelTagsFirstView alloc] initWithFrame:CGRectMake(firstCollectionViewX, firstCollectionViewY, firstCollectionViewW, firstCollectionViewH) collectionViewLayout:flowLayout];
    __weak typeof(&*self) weakSelf = self;
    _firstCollectionView.changeRealHeightBlock = ^(CGFloat realHeight){
        weakSelf.firstCollectionView.height = realHeight;
        weakSelf.firstBg.height = weakSelf.firstCollectionView.bottom + KEDGE_DISTANCE;
        weakSelf.firstBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    };
    [_firstBg addSubview:_firstCollectionView];
    
}

- (void)createSecondBg
{
    
}

/**
 *  保存按钮
 */
- (void)createSaveButton
{
    //保存按钮
    CGFloat saveButtonX = KEDGE_DISTANCE;
    CGFloat saveButtonY = self.firstBg.bottom + KEDGE_DISTANCE;
    CGFloat saveButtonW = KSCREEN_W - 2 * saveButtonX;
    CGFloat saveButtonH = SetUpFirstCellLabelHeight * 2;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(saveButtonX, saveButtonY, saveButtonW, saveButtonH);
    saveButton.layer.cornerRadius = 5;
    saveButton.layer.masksToBounds = YES;
    saveButton.titleLabel.textColor = [UIColor whiteColor];
    saveButton.backgroundColor = [UIColor ZYZC_MainColor];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:saveButton];
//    self.saveButton = saveButton;
    
}
#pragma mark - requsetData方法

#pragma mark - set方法

#pragma mark - button点击方法

#pragma mark - delegate方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    
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
