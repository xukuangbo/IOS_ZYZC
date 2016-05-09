//
//  TacticImageView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TacticThreeMapView.h"
@class TacticSingleFoodModel;
@class TacticVideoModel;
@class TacticSingleModel;
//写一个代理
@interface TacticImageView : UIButton

@property (nonatomic, strong) TacticVideoModel *tacticVideoModel;

@property (nonatomic, strong) TacticSingleFoodModel *tacticSingleFoodModel;

@property (nonatomic, strong) TacticSingleModel *tacticSingleModel;

@property (nonatomic,assign) ThreeMapViewType pushType;

@property (nonatomic, assign) NSInteger viewType;

@end
