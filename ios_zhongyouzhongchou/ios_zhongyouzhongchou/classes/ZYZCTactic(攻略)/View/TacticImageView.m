//
//  TacticImageView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define IOS8 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0
#import "TacticImageView.h"
#import "TacticSingleViewController.h"
#import "TacticVideoModel.h"
#import "TacticSingleFoodModel.h"
#import "TacticSingleModel.h"
#import "ZYZCPlayViewController.h"
#import "TacticSingleViewController.h"
#import "TacticSingleFoodVC.h"
#import "TacticGeneralVC.h"
#import "ZCWebViewController.h"

@interface TacticImageView ()

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UIImageView *startImg;

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
        
        //创建一个播放按钮
        UIImageView *startImg=[[UIImageView alloc]init];
        startImg.bounds=CGRectMake(0, 0, self.width/3, self.height/3);
        startImg.center=CGPointMake(self.width/2, self.height/2);
        startImg.image=[UIImage imageNamed:@"btn_v_on"];
        startImg.hidden = YES;
        [self addSubview:startImg];
        self.startImg = startImg;
        
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setTacticVideoModel:(TacticVideoModel *)tacticVideoModel
{
    
    _tacticVideoModel = tacticVideoModel;
    
    self.nameLabel.text = tacticVideoModel.name;
    self.viewType = tacticVideoModel.viewType;
    self.pushType = threeMapViewTypeVideo;
    self.startImg.hidden = NO;
    [self sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticVideoModel.min_viewImg)] forState:UIControlStateNormal];
}

- (void)setTacticSingleModel:(TacticSingleModel *)tacticSingleModel
{
    _tacticSingleModel = tacticSingleModel;
    
    self.nameLabel.text = tacticSingleModel.name;
    self.viewType = tacticSingleModel.viewType;
    if (tacticSingleModel.viewType == 1) {
        self.pushType = threeMapViewTypeCountryView;
    }else if(tacticSingleModel.viewType == 2) {
        self.pushType = threeMapViewTypeCityView;
    }else if(tacticSingleModel.viewType == 3) {
        self.pushType = threeMapViewTypeSingleView;
    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleModel.viewImg)] forState:UIControlStateNormal];
}

- (void)setTacticSingleFoodModel:(TacticSingleFoodModel *)tacticSingleFoodModel
{
    _tacticSingleFoodModel = tacticSingleFoodModel;
    self.pushType = threeMapViewTypeFood;
    self.nameLabel.text = tacticSingleFoodModel.name;
    [self sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleFoodModel.foodImg)] forState:UIControlStateNormal];
}

//这里写个跳转到单个景点
- (void)clickAction:(UIButton *)button
{
    if (self.pushType == threeMapViewTypeVideo) {
        NSRange range=[self.tacticVideoModel.videoUrl rangeOfString:@".html"];
        if (range.length) {//网页
            ZCWebViewController *webController=[[ZCWebViewController alloc]init];
            webController.requestUrl=self.tacticVideoModel.videoUrl;
            webController.myTitle=@"视频播放";
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:webController animated:YES completion:nil];
            return;
        }
        if (IOS8) {//视频
            ZYZCPlayViewController *playVC = [[ZYZCPlayViewController alloc] init];
            playVC.urlString = self.tacticVideoModel.videoUrl;
            [self.viewController presentViewController:playVC animated:YES completion:nil];
            return;
        }
        
    }else if(self.pushType == threeMapViewTypeCountryView || self.pushType == threeMapViewTypeCityView) {
        //说明是国家或者城市
        TacticSingleViewController *singleVC = [[TacticSingleViewController alloc] initWithViewId:self.tacticSingleModel.ID];
        [self.viewController.navigationController pushViewController:singleVC animated:YES];
    }else if(self.pushType == threeMapViewTypeSingleView) {
        //说明是一般景点
        TacticGeneralVC *generalVC = [[TacticGeneralVC alloc] initWithViewId:self.tacticSingleModel.ID];
        
        [self.viewController.navigationController pushViewController:generalVC animated:YES];
    }else if (self.pushType == threeMapViewTypeFood){
        //说明是食物
        TacticSingleFoodVC *foodVC = [[TacticSingleFoodVC alloc] init];
        
        foodVC.tacticSingleFoodModel = self.tacticSingleFoodModel;
        [self.viewController.navigationController pushViewController:foodVC animated:YES];
    }
 
}


@end
