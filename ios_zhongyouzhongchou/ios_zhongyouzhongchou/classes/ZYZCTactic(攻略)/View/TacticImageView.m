//
//  TacticImageView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticImageView.h"
#import "TacticSingleViewController.h"
#import "TacticVideoModel.h"
#import "TacticSingleFoodModel.h"
#import "TacticSingleModel.h"

@interface TacticImageView ()

@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation TacticImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        //添加圆角
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        //给button添加一个底部的label
        CGFloat labelW = frame.size.width;
        CGFloat labelH = 20;
        CGFloat labelX = 0;
        CGFloat labelY = frame.size.height - labelH;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        nameLabel.backgroundColor = [UIColor ZYZC_MainColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.alpha = 0.8;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setTacticVideoModel:(TacticVideoModel *)tacticVideoModel
{
    
    _tacticVideoModel = tacticVideoModel;
    
    self.nameLabel.text = tacticVideoModel.name;
    self.viewType = tacticVideoModel.viewType;
    [self sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticVideoModel.videoImg)] forState:UIControlStateNormal];
    
}

- (void)setTacticSingleModel:(TacticSingleModel *)tacticSingleModel
{
    _tacticSingleModel = tacticSingleModel;
    
    self.nameLabel.text = tacticSingleModel.name;
    self.viewType = tacticSingleModel.viewType;
    [self sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleModel.viewImg)] forState:UIControlStateNormal];
}


- (void)setTacticSingleFoodModel:(TacticSingleFoodModel *)tacticSingleFoodModel
{
    _tacticSingleFoodModel = tacticSingleFoodModel;
    
    self.nameLabel.text = tacticSingleFoodModel.name;
    [self sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleFoodModel.foodImg)] forState:UIControlStateNormal];
}



//这里写个跳转到单个景点
- (void)clickAction:(UIButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(TacticImageViewPushActionWithvideoModel:tacticSingleFoodModel:tacticSingleModel:)]) {
        [self.delegate TacticImageViewPushActionWithvideoModel:self.tacticVideoModel tacticSingleFoodModel:self.tacticSingleFoodModel tacticSingleModel:self.tacticSingleModel];
    }
 
}
@end
