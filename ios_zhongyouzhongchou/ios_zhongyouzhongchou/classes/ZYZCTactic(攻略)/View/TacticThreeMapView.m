
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
#import "ZYZCPlayViewController.h"
#import "TacticSingleViewController.h"
@interface TacticThreeMapView()<TacticImageViewDelegate>

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
            button.delegate = self;
            button.frame = CGRectMake(buttonX, buttonY, buttonWH, buttonWH);
            
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
                imageView.tacticVideoModel = videoModel;
                //只添加这几个已有的view
                [self addSubview:imageView];
                
            }
    }
}

//- (void)setFoodsArray:(NSArray *)foodsArray
//{
//    if (_foodsArray != foodsArray) {
//        _foodsArray = foodsArray;
//        int maxCount = foodsArray.count >= 3? 3:(int)foodsArray.count;
//        for (int i = 0; i < maxCount; i++) {
//            
//            TacticSingleFoodModel *foodModel = (TacticSingleFoodModel *)foodsArray[i];
//            if (i == 0) {
//                [self.firstView sd_setImageWithURL:[NSURL URLWithString:KWebImage(foodModel.foodImg)] forState:UIControlStateNormal];
//                self.firstView.tacticSingleFoodModel = foodModel;
//                self.firstView.nameLabel.text = foodModel.name;
//            }
//            if (i == 1) {
//                [self.secondView sd_setImageWithURL:[NSURL URLWithString:KWebImage(foodModel.foodImg)] forState:UIControlStateNormal];
//                self.secondView.tacticSingleFoodModel = foodModel;
//                self.secondView.nameLabel.text = foodModel.name;
//            }
//            if (i == 2) {
//                [self.thirdView sd_setImageWithURL:[NSURL URLWithString:KWebImage(foodModel.foodImg)] forState:UIControlStateNormal];
//                self.thirdView.tacticSingleFoodModel = foodModel;
//                self.thirdView.nameLabel.text = foodModel.name;
//            }
//            
//        }
//    }
//}

#pragma mark - TacticImageViewDelegate
- (void)TacticImageViewPushAction:(NSInteger)viewType
{
    if (self.threeMapViewType == threeMapViewTypeVideo) {
        //说明是要跳转到视频
        
    }
//    if (viewType == 3) {
//        NSLog(@"这是一个景点的描述！！！！！");
//
//    }else if (self.viewType == 1 || self.viewType == 2){
//        TacticSingleViewController *singleVC = [[TacticSingleViewController alloc] initWithViewId:self.viewId];
//        [self.viewController.navigationController pushViewController:singleVC animated:YES];
//    }else if (self.viewType == 0){
//        //说明他不是一个国家那种东西，而是一个景点
//
//        TacticSingleFoodController *foodVC = [[TacticSingleFoodController alloc] init];
//        foodVC.tacticSingleFoodModel = self.tacticSingleFoodModel;
//
//        [self.viewController.navigationController pushViewController:foodVC animated:YES];
//    }
}

- (void)TacticImageViewPushActionWithvideoModel:(TacticVideoModel *)videoModel tacticSingleFoodModel:(TacticSingleFoodModel *)singleFoodModel
{
    
    if (self.threeMapViewType == threeMapViewTypeVideo) {
        //推到播放控制器
        ZYZCPlayViewController *playVC = [[ZYZCPlayViewController alloc] init];
        playVC.urlString = videoModel.videoUrl;
        
        [self.viewController presentViewController:playVC animated:YES completion:nil];
    }if (self.threeMapViewType == threeMapViewTypeSingleView) {
        NSLog(@"这里是景点");
        if (videoModel.viewType == 1 || videoModel.viewType == 2) {
            //说明是国家或者城市
            TacticSingleViewController *singleVC = [[TacticSingleViewController alloc] initWithViewId:videoModel.viewid];
            [self.viewController.navigationController pushViewController:singleVC animated:YES];
        }else if (videoModel.viewType == 3){
            //说明是一班景点
           
            NSLog(@"%zd,一般景点",videoModel.viewid);
        }
        
    }
}
@end
