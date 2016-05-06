//
//  TacticMoreCollectionViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticMoreCollectionViewCell.h"
#import "TacticImageView.h"
#import "ZYZCPlayViewController.h"
#import "TacticSingleViewController.h"
#import "TacticSingleFoodVC.h"
#import "TacticVideoModel.h"
#import "TacticSingleFoodModel.h"
#import "TacticSingleModel.h"
@interface TacticMoreCollectionViewCell ()<TacticImageViewDelegate>

@end
@implementation TacticMoreCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        TacticImageView *imageView = [[TacticImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 256.0 green:arc4random_uniform(256) / 256.0 blue:arc4random_uniform(256) / 256.0 alpha:1];
        imageView.delegate = self;
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

#pragma mark - TacticImageViewDelegate
- (void)TacticImageViewPushActionWithvideoModel:(TacticVideoModel *)videoModel tacticSingleFoodModel:(TacticSingleFoodModel *)singleFoodModel tacticSingleModel:(TacticSingleModel *)tacticSingleModel;
{
    if (self.pushVCType == pushVCTypeVideo) {
        //说明是播放器
        ZYZCPlayViewController *playVC = [[ZYZCPlayViewController alloc] init];
        playVC.urlString = videoModel.videoUrl;
        [self.viewController presentViewController:playVC animated:YES completion:nil];
    }else if(self.pushVCType == pushVCTypeCountryView || self.pushVCType == pushVCTypeCityView) {
        //说明是国家或者城市
        TacticSingleViewController *singleVC = [[TacticSingleViewController alloc] initWithViewId:tacticSingleModel.ID];
        [self.viewController.navigationController pushViewController:singleVC animated:YES];
    }else if(self.pushVCType == pushVCTypeSingleView) {
        //说明是一般景点
        TacticSingleViewController *singleVC = [[TacticSingleViewController alloc] initWithViewId:tacticSingleModel.ID];
        
        [self.viewController.navigationController pushViewController:singleVC animated:YES];
    }else if (self.pushVCType == pushVCTypeFood){
        //说明是食物
        TacticSingleFoodVC *foodVC = [[TacticSingleFoodVC alloc] init];
        
        foodVC.tacticVideoModel = videoModel;
        [self.viewController.navigationController pushViewController:foodVC animated:YES];
    }
}
    

@end
