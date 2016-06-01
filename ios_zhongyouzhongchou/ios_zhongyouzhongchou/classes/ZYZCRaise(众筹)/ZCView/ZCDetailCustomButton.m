//
//  ZCDetailCustomButton.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/26.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailCustomButton.h"
#import "ZYZCPersonalController.h"
@implementation ZCDetailCustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.layer.cornerRadius=4;
    self.layer.masksToBounds=YES;
    [self setBackgroundImage:[UIImage imageNamed:@"icon_placeholder"] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(personZone) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark --- 访问个人空间
-(void)personZone
{
    ZYZCPersonalController *personalController=[[ZYZCPersonalController alloc]init];
    personalController.hidesBottomBarWhenPushed=YES;
    [self.viewController.navigationController pushViewController:personalController animated:YES];
}

@end
