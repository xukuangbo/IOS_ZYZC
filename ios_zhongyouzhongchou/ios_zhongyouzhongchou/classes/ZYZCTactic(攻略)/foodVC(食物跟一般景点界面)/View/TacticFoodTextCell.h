//
//  TacticFoodTextCell.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define labelViewFont [UIFont systemFontOfSize:16]
#define titleLabelFont [UIFont systemFontOfSize:18]
#import <UIKit/UIKit.h>

@interface TacticFoodTextCell : UITableViewCell

@property (nonatomic, weak) UIImageView *mapView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *labelView;
@end
