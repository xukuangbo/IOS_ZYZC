//
//  ZCSupportTogetherView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCSupportTogetherView.h"

@implementation ZCSupportTogetherView

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
    
    self.limitLab.frame=CGRectMake(0, 0, 80, 20);
    self.hasSupportLab.frame=CGRectMake(self.limitLab.right+30, self.limitLab.top, 80, 20) ;
}

@end
