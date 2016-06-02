//
//  TacticCountryHeadView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticCountryHeadView.h"
#import "TacticSingleViewController.h"

@implementation TacticCountryHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 0)];
        [self addSubview:mapView];
        
        CGFloat flagImageWH = 50;
        UIImageView *flagImage = [[UIImageView alloc] init];
        flagImage.size = CGSizeMake(flagImageWH, flagImageWH);
        flagImage.layer.cornerRadius = flagImageWH / 2.0;
        flagImage.layer.masksToBounds = YES;
        flagImage.left = 0;
        flagImage.top = 0;
        [mapView addSubview:flagImage];
        self.flagImage = flagImage;
        
        UILabel *flagImageName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
        flagImageName.font = [UIFont boldSystemFontOfSize:33];
        flagImageName.shadowOffset=CGSizeMake(1, 1);
        flagImageName.shadowColor=[UIColor blackColor];
        flagImageName.textAlignment = NSTextAlignmentCenter;
        flagImageName.textColor = [UIColor whiteColor];
        flagImageName.top = flagImage.bottom + KEDGE_DISTANCE;
        flagImageName.centerX = mapView.centerX;
        [mapView addSubview:flagImageName];
        self.flagImageName = flagImageName;
        
        mapView.height = flagImageName.bottom;
        mapView.center = CGPointMake(KSCREEN_W * 0.5, TacticSingleHeadViewHeight);
        //        UILabel *flagImageName = [[UILabel alloc] init];
        //        flagImageName.size = CGSizeMake(30, 30);
        //        flagImageName.left = flagImage.right + 5;
        //        flagImageName.centerY = flagImage.centerY;
        //        flagImageName.shadowOffset=CGSizeMake(1, 1);
        //        [self addSubview:flagImageName];
        //        self.flagImageName = flagImageName;
        
    }
    return self;
}

@end
