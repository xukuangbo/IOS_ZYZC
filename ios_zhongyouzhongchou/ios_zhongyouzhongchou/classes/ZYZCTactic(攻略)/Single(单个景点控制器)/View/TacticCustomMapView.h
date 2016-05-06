//
//  TacticCustomMapView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TacticTableViewCellMargin 10
#define TacticTableViewCellTextMargin 4
#define titleFont [UIFont systemFontOfSize:15]
#define descFont [UIFont systemFontOfSize:13]
#define descLabelBottom 44

//我提供两种高度给他
//这是视频播放，图文那种
#define oneViewMapHeight ((KSCREEN_W - TacticTableViewCellMargin * 4) / 8.0 * 5 + descLabelBottom + TacticTableViewCellMargin + TacticTableViewCellTextMargin)
#define oneViewHeight ((KSCREEN_W - TacticTableViewCellMargin * 4) / 8.0 * 5)
//这是3个view视频那种
#define threeViewMapHeight ((KSCREEN_W - TacticTableViewCellMargin * 6) / 3.0 + descLabelBottom + TacticTableViewCellTextMargin + TacticTableViewCellMargin)
#define threeViewHeight ((KSCREEN_W - TacticTableViewCellMargin * 6) / 3.0)

typedef NS_ENUM(NSInteger, MoreVCType)
{
    MoreVCTypeDefult = 0,
    MoreVCTypeTypeCountryView,//国家
    MoreVCTypeTypeCityView,//城市
    MoreVCTypeTypeSingleView,//一般景点
    MoreVCTypeTypeFood,//食物
    MoreVCTypeTypeVideo//视频
};

@protocol TacticCustomMapViewDelegate <NSObject>

- (void)pushToMoreVC:(UIButton *)button;
@end

@interface TacticCustomMapView : UIImageView
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *descLabel;

@property (nonatomic, weak) UIButton *moreButton;

@property (nonatomic, weak) id<TacticCustomMapViewDelegate> delegate;
@end
