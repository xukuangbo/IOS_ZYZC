
//
//  TacticThreeMapView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticThreeMapView.h"
#import "TacticVideoModel.h"
#import "TacticImageView.h"
#import "TacticSingleFoodModel.h"
@interface TacticThreeMapView()

@property (nonatomic, strong) NSMutableArray *viewArray;

@property (nonatomic, weak) TacticImageView *firstView;
@property (nonatomic, weak) TacticImageView *secondView;
@property (nonatomic, weak) TacticImageView *thirdView;
@end
@implementation TacticThreeMapView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewArray = [NSMutableArray array];
        
        //先让自己的数组拥有3个view，是否显示要看以后
        CGFloat threeMapViewMargin = 10;
        CGFloat buttonWH = (frame.size.width - threeMapViewMargin * 4) / 3.0;
        for (int i = 0; i < 3; i++) {
            CGFloat buttonX = threeMapViewMargin + i * (threeMapViewMargin + buttonWH);
            CGFloat buttonY = 0;
            TacticImageView *button = [[TacticImageView alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWH, buttonWH)];
            button.frame = CGRectMake(buttonX, buttonY, buttonWH, buttonWH);
//            [self addSubview:button];
            [self.viewArray addObject:button];
        }
        
    }
    return self;
}


- (void)setVideos:(NSArray *)videos
{
    if (_videos != videos) {
        _videos = videos;
        //先清空原来的view
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        int maxCount = videos.count >= 3? 3:(int)videos.count;
            for (int i = 0; i < maxCount; i++) {
            
                TacticVideoModel *videoModel = (TacticVideoModel *)videos[i];
                TacticImageView *imageView = self.viewArray[i];
                [imageView sd_setImageWithURL:[NSURL URLWithString:KWebImage(videoModel.viewImg)] forState:UIControlStateNormal];
                imageView.nameLabel.text = videoModel.name;
                imageView.viewId = videoModel.viewid;
                imageView.viewType = videoModel.viewType;
                
                //只添加这几个已有的view
                [self addSubview:imageView];
//                if (i == 0) {
//                    [self.firstView sd_setImageWithURL:[NSURL URLWithString:KWebImage(videoModel.viewImg)] forState:UIControlStateNormal];
//                    self.firstView.nameLabel.text = videoModel.name;
//                    self.firstView.viewId = videoModel.viewid;
//                    self.firstView.viewType = videoModel.viewType;
//                }
//                if (i == 1) {
//                    [self.secondView sd_setImageWithURL:[NSURL URLWithString:KWebImage(videoModel.viewImg)] forState:UIControlStateNormal];
//                    self.secondView.nameLabel.text = videoModel.name;
//                    self.secondView.viewId = videoModel.viewid;
//                    self.secondView.viewType = videoModel.viewType;
//                }
//                if (i == 2) {
//                    [self.thirdView sd_setImageWithURL:[NSURL URLWithString:KWebImage(videoModel.viewImg)] forState:UIControlStateNormal];
//                    self.thirdView.nameLabel.text = videoModel.name;
//                    self.thirdView.viewId = videoModel.viewid;
//                    self.thirdView.viewType = videoModel.viewType;
//                }
                
            }
    }
}

- (void)setFoodsArray:(NSArray *)foodsArray
{
    if (_foodsArray != foodsArray) {
        _foodsArray = foodsArray;
        int maxCount = foodsArray.count >= 3? 3:(int)foodsArray.count;
        for (int i = 0; i < maxCount; i++) {
            
            TacticSingleFoodModel *foodModel = (TacticSingleFoodModel *)foodsArray[i];
            if (i == 0) {
                [self.firstView sd_setImageWithURL:[NSURL URLWithString:KWebImage(foodModel.foodImg)] forState:UIControlStateNormal];
                self.firstView.tacticSingleFoodModel = foodModel;
                self.firstView.nameLabel.text = foodModel.name;
            }
            if (i == 1) {
                [self.secondView sd_setImageWithURL:[NSURL URLWithString:KWebImage(foodModel.foodImg)] forState:UIControlStateNormal];
                self.secondView.tacticSingleFoodModel = foodModel;
                self.secondView.nameLabel.text = foodModel.name;
            }
            if (i == 2) {
                [self.thirdView sd_setImageWithURL:[NSURL URLWithString:KWebImage(foodModel.foodImg)] forState:UIControlStateNormal];
                self.thirdView.tacticSingleFoodModel = foodModel;
                self.thirdView.nameLabel.text = foodModel.name;
            }
            
        }
    }
}

@end
