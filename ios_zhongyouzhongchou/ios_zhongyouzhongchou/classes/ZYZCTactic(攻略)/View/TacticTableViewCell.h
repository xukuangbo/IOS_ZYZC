//
//  TacticTableViewCell.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TacticMapView.h"
@class TacticModel;


//#define videoViewHeight 150

#define videoViewHeight ((KSCREEN_W - 10 * 6) / 3.0 + 44 + 10)

@interface TacticTableViewCell : UITableViewCell

@property (nonatomic, strong) TacticModel *tacticModel;
@end
