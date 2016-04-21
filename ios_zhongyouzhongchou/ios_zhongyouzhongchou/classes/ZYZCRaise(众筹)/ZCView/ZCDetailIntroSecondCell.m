//
//  ZCDetailIntroSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailIntroSecondCell.h"

@implementation ZCDetailIntroSecondCell

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
    self.bgImg.height=ZCDETAILINTRO_SECONDCELL_HEIGHT;
    self.titleLab.text=@"目的地介绍";
    self.titleLab.font=[UIFont boldSystemFontOfSize:15];
}

@end
