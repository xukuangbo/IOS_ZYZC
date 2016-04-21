//
//  ZCDetailIntroThirdCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailIntroThirdCell.h"

@implementation ZCDetailIntroThirdCell

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
    self.bgImg.height=ZCDETAILINTRO_THIRDCELL_HEIGHT;
    self.titleLab.text=@"动画攻略";
}

@end
