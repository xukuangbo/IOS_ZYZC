//
//  ZCDetailIntroSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailIntroSecondCell.h"
#define FIRSTBTN_TAG  3
#define LINEVIEW_TAG  110
@interface ZCDetailIntroSecondCell ()
@property (nonatomic, strong) UIScrollView *goalsView;
@property (nonatomic, strong) UIButton *preClickBtn;
@property (nonatomic, assign) CGFloat preBtnX;
@property (nonatomic, assign) BOOL firstGetGoals;
@end

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
    
    _goalsView=[[UIScrollView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, self.topLineView.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE, 30)];
    _goalsView.showsHorizontalScrollIndicator=NO;
//    _goalsView.backgroundColor=[UIColor orangeColor];
    [self.contentView addSubview:_goalsView];
    _firstGetGoals=YES;
    
    UIImageView *oneGoalImg=[[UIImageView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, _goalsView.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE,(KSCREEN_W-4*KEDGE_DISTANCE)*5/8)];
    oneGoalImg.backgroundColor= [UIColor redColor];
    [self.contentView addSubview:oneGoalImg];
    
}

-(void)setGoals:(NSArray *)goals
{
    _goals=goals;
    if (_firstGetGoals) {
        _preBtnX=0;
        //添加目的地试图到_goalsView
        for (int i=0; i<goals.count; i++) {
            UIButton *btn = [self setButton:i withTitle:goals[i]];
            [_goalsView addSubview:btn];
            _preBtnX=btn.right+16;
        }
        if (_preBtnX-16>_goalsView.width) {
            _goalsView.contentSize=CGSizeMake(_preBtnX-16, 0);
        }
        else
        {
            _goalsView.contentOffset=CGPointMake(-(_goalsView.width-_preBtnX+16)/2, 0);
        }
    }
    
    //初始化后点击第一个目的地
    if (!_preClickBtn) {
        UIButton *btn=(UIButton *)[_goalsView viewWithTag:FIRSTBTN_TAG];
        [self changeGoal:btn];
    }
    
    _firstGetGoals=NO;
}

/**
 *
 *  创建按钮
 */
- (UIButton *)setButton:(NSInteger)index withTitle:(NSString *)title
{
    UIFont *font=[UIFont  systemFontOfSize:15];
    
    CGFloat titleWidth=[ZYZCTool calculateStrLengthByText:title andFont:font andMaxWidth:KSCREEN_W].width;
    
    CGFloat buttonW = titleWidth+20;
    CGFloat buttonH = _goalsView.height;
    CGFloat buttonX = _preBtnX;
    CGFloat buttonY = 0;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = index+FIRSTBTN_TAG;
    [button addTarget:self action:@selector(changeGoal:) forControlEvents:UIControlEventTouchUpInside];
    
    //给btn添加下划线
    UIView *lineView=[UIView lineViewWithFrame:CGRectMake(0, button.height-1, button.width, 1) andColor:[UIColor ZYZC_MainColor]];
    lineView.tag=LINEVIEW_TAG;
    lineView.hidden=YES;
    [button addSubview:lineView];
    
    if (index!=0) {
        //从第二个目的地开始，添加箭头
        UIImageView *arrowImg=[[UIImageView alloc]initWithFrame:CGRectMake(-16, (button.height-5)/2, 16, 5)];
        arrowImg.image=[UIImage imageNamed:@"icn_des_jt"];
        [button addSubview:arrowImg];
    }
    
    [self getButtonNormalState:button];
    
    return button;
}

#pragma mark --- button点击事件
-(void)changeGoal:(UIButton *)button
{
    [self getButtonHeightState:button];
    
    if (_preClickBtn&&_preClickBtn!=button) {
        
        [self getButtonNormalState:_preClickBtn];
        
    }
    _preClickBtn=button;
}


#pragma mark --- buttonNormalState
-(void)getButtonNormalState:(UIButton *)button
{
    [button setTitleColor:[UIColor ZYZC_TextGrayColor04] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[button viewWithTag:LINEVIEW_TAG];
    lineView.hidden=YES;
}

#pragma mark --- buttonHeightState
-(void)getButtonHeightState:(UIButton *)button
{
    [button setTitleColor:[UIColor ZYZC_TextBlackColor] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[button viewWithTag:LINEVIEW_TAG];
    lineView.hidden=NO;
    
}


@end
