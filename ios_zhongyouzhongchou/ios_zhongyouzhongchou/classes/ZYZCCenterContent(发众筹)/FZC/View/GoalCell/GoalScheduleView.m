//
//  GoalScheduleView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "GoalScheduleView.h"

@implementation GoalScheduleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI
{
    _startLab=[self createLabWithFrame:CGRectMake(0, 0, (self.width-15)/2, self.height)];
    _startLab.text=[ZYZCTool getLocalDate];
    [self addSubview:_startLab];
    _backLab=[self createLabWithFrame:CGRectMake((self.width+15)/2, 0, (self.width-15)/2, self.height)];
     _backLab.text=[ZYZCTool getLocalDate];
    [self addSubview:_backLab];
    UILabel *centerLab=[self createLabWithFrame:CGRectMake(_startLab.right, 0, 15, self.height)];
    centerLab.text=@"~";
    [self addSubview:centerLab];
}

-(UILabel *)createLabWithFrame:(CGRect)frame
{
    UILabel *lab=[[UILabel alloc]initWithFrame:frame];
    lab.font=[UIFont systemFontOfSize:20];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=[UIColor ZYZC_TextGrayColor];
    return lab;
}

@end












