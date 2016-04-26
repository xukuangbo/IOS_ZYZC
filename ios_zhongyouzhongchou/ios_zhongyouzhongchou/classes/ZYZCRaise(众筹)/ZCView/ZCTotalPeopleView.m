//
//  ZCTotalPeopleView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/26.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCTotalPeopleView.h"

@implementation ZCTotalPeopleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andSupportType:(SupportMoneyType )supportType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.height=KSCREEN_H*3/5;
        _supportType=supportType;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 44)];
    topView.backgroundColor=[UIColor whiteColor];
    [self addSubview:topView];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(self.width-60, 0, 60, topView.height);
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets=UIEdgeInsetsMake(0, backBtn.width-35, 0, 0);
    [backBtn addTarget:self action:@selector(goBackToView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
}

-(void)goBackToView
{
    if(self.backToView)
    {
        self.backToView();
    }
}



@end
