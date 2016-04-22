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


#define videoViewHeight 150



@interface TacticTableViewCell : UITableViewCell

@property (nonatomic, strong) TacticModel *tacticModel;
@end
