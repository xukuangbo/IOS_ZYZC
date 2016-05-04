//
//  TacticThreeMapView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ThreeMapViewType)
{
    threeMapViewTypeVideo = 1,
    threeMapViewTypeSingleView,
    threeMapViewTypeFood
};
@interface TacticThreeMapView : UIView

@property (nonatomic, assign) ThreeMapViewType threeMapViewType;

@property (nonatomic, strong) NSArray *videos;

@property (nonatomic, strong) NSArray *foodsArray;

@end
