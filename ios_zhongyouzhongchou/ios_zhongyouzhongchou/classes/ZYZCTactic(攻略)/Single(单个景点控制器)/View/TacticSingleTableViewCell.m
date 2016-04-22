//
//  TacticSingleTableViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleTableViewCell.h"
#import "TacticSingleModel.h"
@interface TacticSingleTableViewCell()
//描述
@property (nonatomic, weak) UIImageView *descView;
@property (nonatomic, weak) UILabel *descLabel;
//动画
@property (nonatomic, weak) UIImageView *flashView;
@property (nonatomic, weak) UIButton *flashPlayButton;
//图文
@property (nonatomic, weak) UIImageView *pictureView;
@property (nonatomic, weak) UIButton *pictureShowButton;
//小贴士
@property (nonatomic, weak) UIImageView *tipsView;
@property (nonatomic, weak) UIButton *tipsShowButton;

//必玩景点
@property (nonatomic, weak) UIImageView *mustPlayView;
@property (nonatomic, weak) UIButton *mustPlayViewButton;
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
    CGFloat textMargin = 4;
    //目的地概况
    UIImageView * descView = [UIView viewWithIndex:1 frame:CGRectMake(TacticTableViewCellMargin, TacticTableViewCellMargin, KSCREEN_W - TacticTableViewCellMargin * 2, 120) Title:@"目的地概况" desc:@"小悠带你看世界"];
    CGFloat descLabelH = descView.height - descLabelBottom - textMargin * 2;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(TacticTableViewCellMargin, descLabelBottom + textMargin, descView.width - TacticTableViewCellMargin * 2, descLabelH)];
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
    CGFloat flashViewX = TacticTableViewCellMargin;
    CGFloat flashViewY = descView.bottom + TacticTableViewCellMargin;
    CGFloat flashViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat flashViewH = oneViewHeight;
    UIImageView * flashView = [UIView viewWithIndex:1 frame:CGRectMake(flashViewX, flashViewY, flashViewW, flashViewH) Title:@"动画攻略" desc:@"趣味动画教你畅游景点"];
    [self.contentView addSubview:flashView];
    self.flashView = flashView;
    
    CGFloat flashPlayButtonX = TacticTableViewCellMargin;
    CGFloat flashPlayButtonY = descLabelBottom + textMargin;
    CGFloat flashPlayButtonW = flashView.width - TacticTableViewCellMargin * 2;
    CGFloat flashPlayButtonH = flashView.height - flashPlayButtonY - TacticTableViewCellMargin;
    UIButton *flashPlayButton = [[UIButton alloc] initWithFrame:CGRectMake(flashPlayButtonX, flashPlayButtonY, flashPlayButtonW, flashPlayButtonH)];
    flashPlayButton.backgroundColor = [UIColor redColor];
    [flashView addSubview:flashPlayButton];
    [flashPlayButton addTarget:self action:@selector(playMoviewAction:) forControlEvents:UIControlEventTouchUpInside];
    self.flashPlayButton = flashPlayButton;
    
    //图文攻略
    CGFloat pictureViewX = TacticTableViewCellMargin;
    CGFloat pictureViewY = flashView.bottom + TacticTableViewCellMargin;
    CGFloat pictureViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat pictureViewH = oneViewHeight;
    UIImageView * pictureView = [UIView viewWithIndex:1 frame:CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH) Title:@"图文攻略" desc:@"一张图玩转目的地"];
    [self.contentView addSubview:pictureView];
    self.pictureView = pictureView;
    
    CGFloat pictureShowButtonX = TacticTableViewCellMargin;
    CGFloat pictureShowButtonY = descLabelBottom + textMargin;
    CGFloat pictureShowButtonW = pictureView.width - TacticTableViewCellMargin * 2;
    CGFloat pictureShowButtonH = pictureView.height - pictureShowButtonY - TacticTableViewCellMargin;
    UIButton *pictureShowButton = [[UIButton alloc] initWithFrame:CGRectMake(pictureShowButtonX, pictureShowButtonY, pictureShowButtonW, pictureShowButtonH)];
    pictureShowButton.backgroundColor = [UIColor redColor];
    [pictureView addSubview:pictureShowButton];
    [pictureShowButton addTarget:self action:@selector(playPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    self.pictureShowButton = pictureShowButton;
    
    //众游小贴士
    CGFloat tipsViewX = TacticTableViewCellMargin;
    CGFloat tipsViewY = pictureView.bottom + TacticTableViewCellMargin;
    CGFloat tipsViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat tipsViewH = oneViewHeight;
    UIImageView * tipsView = [UIView viewWithIndex:1 frame:CGRectMake(tipsViewX, tipsViewY, tipsViewW, tipsViewH) Title:@"众游小贴士" desc:@"最实用的旅游tips"];
    [self.contentView addSubview:tipsView];
    self.tipsView = tipsView;
    
    CGFloat tipsShowButtonX = TacticTableViewCellMargin;
    CGFloat tipsShowButtonY = descLabelBottom + textMargin;
    CGFloat tipsShowButtonW = tipsView.width - TacticTableViewCellMargin * 2;
    CGFloat tipsShowButtonH = tipsView.height - tipsShowButtonY - TacticTableViewCellMargin;
    UIButton *tipsShowButton = [[UIButton alloc] initWithFrame:CGRectMake(tipsShowButtonX, tipsShowButtonY, tipsShowButtonW, tipsShowButtonH)];
    tipsShowButton.backgroundColor = [UIColor redColor];
    [tipsView addSubview:tipsShowButton];
    [tipsShowButton addTarget:self action:@selector(tipsShowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tipsShowButton = pictureShowButton;
    
    //必玩景点
//    CGFloat mustPlayViewX = TacticTableViewCellMargin;
//    CGFloat mustPlayViewY = pictureView.bottom + TacticTableViewCellMargin;
//    CGFloat mustPlayViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
//    CGFloat mustPlayViewH = 210;
//    UIImageView * mustPlayView = [UIView viewWithIndex:1 frame:CGRectMake(mustPlayViewX, mustPlayViewY, mustPlayViewW, mustPlayViewH) Title:@"众游小贴士" desc:@"最实用的旅游tips"];
//    [self.contentView addSubview:mustPlayView];
//    self.tipsView = tipsView;
//    
//    CGFloat tipsShowButtonX = TacticTableViewCellMargin;
//    CGFloat tipsShowButtonY = descLabelBottom + textMargin;
//    CGFloat tipsShowButtonW = tipsView.width - TacticTableViewCellMargin * 2;
//    CGFloat tipsShowButtonH = tipsView.height - tipsShowButtonY - TacticTableViewCellMargin;
//    UIButton *tipsShowButton = [[UIButton alloc] initWithFrame:CGRectMake(tipsShowButtonX, tipsShowButtonY, tipsShowButtonW, tipsShowButtonH)];
//    tipsShowButton.backgroundColor = [UIColor redColor];
//    [tipsView addSubview:tipsShowButton];
//    [tipsShowButton addTarget:self action:@selector(tipsShowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.tipsShowButton = pictureShowButton;
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
- (void)setSingleModel:(TacticSingleModel *)singleModel
{
    if (_singleModel != singleModel) {
        _singleModel = singleModel;
        
        self.descLabel.text = singleModel.viewText;
        
//        self.flashPlayButton 
    }
}
@end
