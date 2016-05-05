//
//  TacticFoodTextCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticFoodTextCell.h"

@implementation TacticFoodTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    /**
      创建容器
     */
    UIImageView *mapView = [[UIImageView alloc] init];
    mapView.userInteractionEnabled = YES;
    mapView.layer.cornerRadius = 5;
    mapView.layer.masksToBounds = YES;
    [self addSubview:mapView];
    self.mapView = mapView;
    //创建绿线
    CGFloat lineHeight = 15;
    [mapView addSubview:[UIView lineViewWithFrame:CGRectMake(KEDGE_DISTANCE , KEDGE_DISTANCE, 2,lineHeight) andColor:[UIColor ZYZC_MainColor]]];
    //创建标题
    CGFloat titleLabelX = KEDGE_DISTANCE * 2;
    CGFloat titleLabelY = KEDGE_DISTANCE;
    CGFloat titleLabelW = 200;
    CGFloat titleLabelH = lineHeight;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.textColor = [UIColor colorWithRed:84/256.0 green:84/256.0 blue:84/256.0 alpha:1];
    titleLabel.font = titleLabelFont;
    [mapView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    /**
     *  创建文字
     */
    UILabel *labelView = [[UILabel alloc] init];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.layer.cornerRadius = 5;
    labelView.layer.masksToBounds = YES;
    labelView.font = labelViewFont;
//    labelView.backgroundColor = [UIColor whiteColor];
    labelView.textColor = [UIColor ZYZC_TextGrayColor];
    labelView.numberOfLines = 0;
    [mapView addSubview:labelView];
    self.labelView = labelView;
}

@end
