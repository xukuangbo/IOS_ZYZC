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
    
    _goalsView=[[UIScrollView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, self.topLineView.bottom+KEDGE_DISTANCE, KSCREEN_W-2*KEDGE_DISTANCE, 40)];
    _goalsView.backgroundColor=[UIColor orangeColor];
    [self.contentView addSubview:_goalsView];
}

-(void)setGoals:(NSArray *)goals
{
    _goals=goals;
    
    NSArray *views=[_goalsView subviews];
    for (NSInteger i=views.count-1; i>0; i--) {
        if ([views[i] isKindOfClass:[UIButton class]]) {
            [views[i] removeFromSuperview];
        }
    }
}

/**
 *
 *  创建3个点击的按钮
 */
- (UIButton *)setButton:(NSInteger)index withTitle:(NSString *)titleName
{
    CGFloat edge    = 1.5;
    CGFloat buttonY = edge;
    CGFloat buttonW = (self.width-KEDGE_DISTANCE * 2 - edge * 4)/3;
    CGFloat buttonH = edge *2;
    CGFloat buttonX = edge+ index * (edge+buttonW);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    button.layer.cornerRadius=KCORNERRADIUS;
    button.layer.masksToBounds=YES;
    [button setTitle:titleName forState:UIControlStateNormal];
    button.tag = index;
    [button addTarget:self action:@selector(getContent:) forControlEvents:UIControlEventTouchUpInside];
    
    if (index==0) {
        _preClickBtn=button;
        [self getButtonHeightState:button];
    }
    else
    {
        [self getButtonNormalState:button];
    }
    return button;
}

#pragma mark --- button点击事件
-(void)getContent:(UIButton *)button
{
    [self getButtonHeightState:button];
    
    if (_preClickBtn!=button) {
        [self getButtonNormalState:_preClickBtn];
    }
    _preClickBtn=button;
    
}


#pragma mark --- buttonNormalState
-(void)getButtonNormalState:(UIButton *)button
{
    [button setTitleColor:[UIColor ZYZC_TextBlackColor] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor ZYZC_BgGrayColor02];
}

#pragma mark --- buttonHeightState
-(void)getButtonHeightState:(UIButton *)button
{
    [button setTitleColor:[UIColor ZYZC_MainColor] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor whiteColor];
}


@end
