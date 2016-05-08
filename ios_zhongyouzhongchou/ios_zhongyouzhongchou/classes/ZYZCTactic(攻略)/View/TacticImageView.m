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
#import "ZYZCPlayViewController.h"
#import "TacticSingleViewController.h"
#import "TacticSingleFoodVC.h"

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
    
    NSString *string = tacticSingleModel.viewImg;
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self sd_setImageWithURL:[NSURL URLWithString:KWebImage(string)] forState:UIControlStateNormal];
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
    if (self.pushType == threeMapViewTypeVideo) {
        //说明是播放器
        ZYZCPlayViewController *playVC = [[ZYZCPlayViewController alloc] init];
        playVC.urlString = self.tacticVideoModel.videoUrl;
        
        [self.viewController presentViewController:playVC animated:YES completion:nil];
    }else if(self.pushType == threeMapViewTypeCountryView || self.pushType == threeMapViewTypeCityView) {
        //说明是国家或者城市
        TacticSingleViewController *singleVC = [[TacticSingleViewController alloc] initWithViewId:self.tacticVideoModel.viewid];
        [self.viewController.navigationController pushViewController:singleVC animated:YES];
    }else if(self.pushType == threeMapViewTypeSingleView) {
        //说明是一般景点
        TacticSingleFoodVC *foodVC = [[TacticSingleFoodVC alloc] init];
        
        foodVC.tacticVideoModel = self.tacticVideoModel;
        [self.viewController.navigationController pushViewController:foodVC animated:YES];
    }else if (self.pushType == threeMapViewTypeFood){
        //说明是食物
        TacticSingleFoodVC *foodVC = [[TacticSingleFoodVC alloc] init];
        
        foodVC.tacticSingleFoodModel = self.tacticSingleFoodModel;
        [self.viewController.navigationController pushViewController:foodVC animated:YES];
    }
 
}


@end
