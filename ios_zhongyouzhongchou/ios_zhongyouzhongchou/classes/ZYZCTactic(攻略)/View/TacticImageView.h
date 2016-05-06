//
//  TacticImageView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TacticSingleFoodModel;
@class TacticVideoModel;
@class TacticSingleModel;
//写一个代理
@protocol TacticImageViewDelegate <NSObject>

- (void)TacticImageViewPushActionWithvideoModel:(TacticVideoModel *)videoModel tacticSingleFoodModel:(TacticSingleFoodModel *)singleFoodModel tacticSingleModel:(TacticSingleModel *)tacticSingleModel;
@end

@interface TacticImageView : UIButton

@property (nonatomic, strong) TacticVideoModel *tacticVideoModel;

@property (nonatomic, strong) TacticSingleFoodModel *tacticSingleFoodModel;

@property (nonatomic, strong) TacticSingleModel *tacticSingleModel;

@property (nonatomic, assign) NSInteger viewType;

@property (nonatomic, weak) id<TacticImageViewDelegate> delegate;
@end
