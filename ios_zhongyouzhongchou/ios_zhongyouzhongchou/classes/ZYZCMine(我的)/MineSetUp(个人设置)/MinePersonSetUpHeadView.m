//
//  MinePersonSetUpHeadView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonSetUpHeadView.h"
@implementation MinePersonSetUpHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *mapView = [[UIView alloc] init];
        [self addSubview:mapView];
        //背后阴影
        CGFloat shadowViewWH = 80 * KCOFFICIEMNT;
        CGFloat shadowViewXY = 0;
        UIView *shadowView = [[UIView alloc] init];
        shadowView.origin = CGPointMake(shadowViewXY, shadowViewXY);
        shadowView.size = CGSizeMake(shadowViewWH, shadowViewWH);
        shadowView.layer.cornerRadius = 5;
        shadowView.layer.masksToBounds = YES;
        CGFloat arcFloat = (arc4random_uniform(150) + 50) / 256.0;
        shadowView.backgroundColor= [UIColor colorWithRed:arcFloat green: arcFloat blue:arcFloat alpha:1];
        [mapView addSubview:shadowView];
        //头像
        CGFloat iconViewXY = 5 * KCOFFICIEMNT;
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.origin = CGPointMake(iconViewXY, iconViewXY);
        iconView.size = CGSizeMake(shadowView.width - iconView.left * 2, shadowView.width - iconView.left * 2);
        iconView.layer.cornerRadius = 5;
        iconView.layer.masksToBounds = YES;
        [shadowView addSubview:iconView];
        self.iconView = iconView;
        //名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.left = 0;
        nameLabel.top = shadowView.height;
        nameLabel.size = CGSizeMake(shadowViewWH, 20 * KCOFFICIEMNT);
        [mapView addSubview:nameLabel];
        nameLabel.backgroundColor = [UIColor redColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel = nameLabel;
        //最后设置容器的大小和位置
        mapView.size = CGSizeMake(shadowViewWH, nameLabel.bottom);
        mapView.center = self.center;
    
    }
    return self;
}
@end
