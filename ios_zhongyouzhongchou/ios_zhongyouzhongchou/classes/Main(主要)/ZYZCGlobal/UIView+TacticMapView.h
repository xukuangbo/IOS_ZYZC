//
//  UIView+TacticMapView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TacticTableViewCellMargin 10

#define titleFont [UIFont systemFontOfSize:15]
#define descFont [UIFont systemFontOfSize:13]
#define descLabelBottom 44

//我提供两种高度给他
//这是视频播放，图文那种
#define oneViewHeight ((KSCREEN_W - TacticTableViewCellMargin * 4) / 8.0 * 5 + descLabelBottom)
//这是3个view视频那种
#define threeViewHeight ((KSCREEN_W - 10 * 6) / 3.0 + descLabelBottom + TacticTableViewCellMargin + 4)

@interface UIView (TacticMapView)
+ (UIImageView *)viewWithIndex:(NSInteger)index frame:(CGRect)rect Title:(NSString *)title desc:(NSString *)desc;
@end
