//
//  ZCDetailArrangeFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/23.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailArrangeFirstCell.h"

@interface ZCDetailArrangeFirstCell ()
@property (nonatomic ,assign ) BOOL isFirstConfigSightView;
@end

@implementation ZCDetailArrangeFirstCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI
{
    [super configUI];
    _isFirstConfigSightView=YES;
    
}

-(void)setOneDaydetailModel:(MoreFZCTravelOneDayDetailMdel *)oneDaydetailModel
{
    _oneDaydetailModel=oneDaydetailModel;
    self.hasMovie=YES;
    self.hasVoice=YES;
    self.hasWord =YES;
    self.hasSight=YES;
    self.hasTrans=YES;
    self.hasLive =YES;
    self.hasEat  =YES;
    [self reloadDataByModel];
    self.oneDaydetailModel.cellHeight=self.bgImg.height;
    
    if (_isFirstConfigSightView && self.hasSight) {
        NSString *text=@"圣诞节啊空间啊快放假放假啊啊季后赛大哥大姐哈哥啊撒上了扩大华师大大家哈空间大";
        UIView *sightView=[self configSightViewByViewTop:self.bgImg.height andText:text andImages:nil];
        [self.contentView addSubview:sightView];
    }
    _isFirstConfigSightView=NO;
}

-(UIView *)configSightViewByViewTop:(CGFloat)top andText:(NSString *)text andImages:(NSArray *)images
{
    UIView *sightView=[[UIView alloc]init];
    
    return sightView;
}

@end
