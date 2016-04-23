//
//  TacticSingleTableViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleTableViewCell.h"
#import "TacticSingleModel.h"
#import "TacticSingleModelFrame.h"
#import "TacticCustomMapView.h"
#import "TacticThreeMapView.h"
@interface TacticSingleTableViewCell()
//描述
@property (nonatomic, weak) TacticCustomMapView *descView;
@property (nonatomic, weak) UILabel *descLabel;
//动画
@property (nonatomic, weak) TacticCustomMapView *flashView;
@property (nonatomic, weak) UIButton *flashPlayButton;
//图文
@property (nonatomic, weak) TacticCustomMapView *pictureView;
@property (nonatomic, weak) UIButton *pictureShowButton;
//小贴士
@property (nonatomic, weak) TacticCustomMapView *tipsView;
@property (nonatomic, weak) UIButton *tipsShowButton;

//必玩景点
@property (nonatomic, weak) TacticCustomMapView *mustPlayView;
@property (nonatomic, weak) TacticThreeMapView *mustPlayViewButton;
@end
@implementation TacticSingleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor ZYZC_BgGrayColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**
         *  创建概况描述
         */
        [self createContentView];
        
    }
    return self;
}
/**
 *  创建概况描述
 */
- (void)createContentView
{
//    CGFloat textMargin = 4;
    //目的地概况
//    UIImageView * descView = [UIView viewWithIndex:1 frame:CGRectMake(TacticTableViewCellMargin, TacticTableViewCellMargin,) Title:@"目的地概况" desc:@"小悠带你看世界"];
    TacticCustomMapView *descView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(0, 0,  KSCREEN_W - TacticTableViewCellMargin * 2, 120)];
    descView.titleLabel.text = @"目的地概况";
    CGFloat descLabelH = descView.height - descLabelBottom - TacticTableViewCellTextMargin * 2;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(TacticTableViewCellMargin, descLabelBottom + TacticTableViewCellTextMargin, descView.width - TacticTableViewCellMargin * 2, descLabelH)];
    descLabel.backgroundColor = [UIColor ZYZC_BgGrayColor];
    descLabel.textColor = [UIColor ZYZC_TextGrayColor];
    descLabel.layer.cornerRadius = 5;
    descLabel.layer.masksToBounds = YES;
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.numberOfLines = 3;
    [self.contentView addSubview:descView];
    [descView addSubview:descLabel];
    self.descLabel = descLabel;
    self.descView = descView;
    //动画攻略
    CGFloat flashViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat flashViewH = oneViewMapHeight;
    TacticCustomMapView *flashView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(0, 0,flashViewW, flashViewH)];
    flashView.titleLabel.text = @"动画攻略";
    [self.contentView addSubview:flashView];
    self.flashView = flashView;
    
    CGFloat flashPlayButtonX = TacticTableViewCellMargin;
    CGFloat flashPlayButtonY = descLabelBottom + TacticTableViewCellTextMargin;
    CGFloat flashPlayButtonW = flashView.width - TacticTableViewCellMargin * 2;
    CGFloat flashPlayButtonH = oneViewHeight;
    UIButton *flashPlayButton = [[UIButton alloc] initWithFrame:CGRectMake(flashPlayButtonX, flashPlayButtonY, flashPlayButtonW, flashPlayButtonH)];
    flashPlayButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    flashPlayButton.backgroundColor = [UIColor redColor];
    [flashView addSubview:flashPlayButton];
    [flashPlayButton addTarget:self action:@selector(playMoviewAction:) forControlEvents:UIControlEventTouchUpInside];
    self.flashPlayButton = flashPlayButton;
    
    //图文攻略
    CGFloat pictureViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat pictureViewH = oneViewMapHeight;
    TacticCustomMapView *pictureView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(0, 0,pictureViewW, pictureViewH)];
    pictureView.titleLabel.text = @"一张图看懂";
    [self.contentView addSubview:pictureView];
    self.pictureView = pictureView;
    
    CGFloat pictureShowButtonX = TacticTableViewCellMargin;
    CGFloat pictureShowButtonY = descLabelBottom + TacticTableViewCellTextMargin;
    CGFloat pictureShowButtonW = pictureView.width - TacticTableViewCellMargin * 2;
    CGFloat pictureShowButtonH = oneViewHeight;
    UIButton *pictureShowButton = [[UIButton alloc] initWithFrame:CGRectMake(pictureShowButtonX, pictureShowButtonY, pictureShowButtonW, pictureShowButtonH)];
    pictureShowButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    pictureShowButton.backgroundColor = [UIColor redColor];
    [pictureView addSubview:pictureShowButton];
    [pictureShowButton addTarget:self action:@selector(playPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    self.pictureShowButton = pictureShowButton;
    
    //众游小贴士
    CGFloat tipsViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat tipsViewH = oneViewMapHeight;
    TacticCustomMapView *tipsView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(0, 0,tipsViewW, tipsViewH)];
    tipsView.titleLabel.text = @"众游小贴士";
    [self.contentView addSubview:tipsView];
    self.tipsView = tipsView;
    
    CGFloat tipsShowButtonX = TacticTableViewCellMargin;
    CGFloat tipsShowButtonY = descLabelBottom + TacticTableViewCellTextMargin;
    CGFloat tipsShowButtonW = tipsView.width - TacticTableViewCellMargin * 2;
    CGFloat tipsShowButtonH = oneViewHeight;
    UIButton *tipsShowButton = [[UIButton alloc] initWithFrame:CGRectMake(tipsShowButtonX, tipsShowButtonY, tipsShowButtonW, tipsShowButtonH)];
    tipsShowButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    tipsShowButton.backgroundColor = [UIColor redColor];
    [tipsView addSubview:tipsShowButton];
    [tipsShowButton addTarget:self action:@selector(tipsShowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tipsShowButton = pictureShowButton;
    
    //必玩景点
//    CGFloat mustPlayViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
//    CGFloat mustPlayViewH = threeViewMapHeight;
//    TacticCustomMapView *mustPlayView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(0, 0,mustPlayViewW, mustPlayViewH)];
//    mustPlayView.titleLabel.text = @"必玩景点";
//    [self.contentView addSubview:mustPlayView];
//    self.mustPlayView = mustPlayView;
//    
//    CGFloat mustPlayViewButtonX = TacticTableViewCellMargin;
//    CGFloat mustPlayViewButtonY = descLabelBottom + TacticTableViewCellTextMargin;
//    CGFloat mustPlayViewButtonW = tipsView.width - TacticTableViewCellMargin * 2;
//    CGFloat mustPlayViewButtonH = (KSCREEN_W - 10 * 6) / 3.0;
//    TacticThreeMapView *mustPlayViewButton = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(mustPlayViewButtonX, mustPlayViewButtonY, mustPlayViewButtonW, mustPlayViewButtonH)];
//    [mustPlayView addSubview:mustPlayViewButton];
//    self.mustPlayViewButton = mustPlayViewButton;
}
#pragma mark - 点击跳转事件
/**
 *  小动画播放
 */
- (void)playMoviewAction:(UIButton *)button
{
    NSLog(@"播放小视频啦！~~~~~~");
}
/**
 *  图文播放
 */
- (void)playPictureAction:(UIButton *)button
{
    NSLog(@"打开图文啦！~~~~~~");
}
/**
 *  小贴士播放
 */
- (void)tipsShowButtonAction:(UIButton *)button
{
    NSLog(@"打开小贴士啦！~~~~~~");
}
#pragma mark - 模型赋值
- (void)setTacticSingleModelFrame:(TacticSingleModelFrame *)tacticSingleModelFrame
{
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    
    _tacticSingleModelFrame = tacticSingleModelFrame;
    TacticSingleModel *tacticSingleModel = tacticSingleModelFrame.tacticSingleModel;
    
    self.descView.frame = tacticSingleModelFrame.descViewF;
    self.descLabel.text = tacticSingleModel.viewText;
    
    
    self.flashView.frame = tacticSingleModelFrame.flashViewF;
    self.flashView.descLabel.text = [NSString stringWithFormat:@"%@最棒的旅行目的地",tacticSingleModel.name];
    self.flashPlayButton.frame = tacticSingleModelFrame.flashPlayButtonF;
    [self.flashPlayButton sd_setImageWithURL:[NSURL URLWithString:KWebImage(self.tacticSingleModelFrame.tacticSingleModel.videoImage)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
    NSLog(@"%@",KWebImage(self.tacticSingleModelFrame.tacticSingleModel.videoImage));
    self.pictureView.frame = tacticSingleModelFrame.pictureViewF;
    
    
    self.tipsView.frame = tacticSingleModelFrame.tipsViewF;
}
@end
