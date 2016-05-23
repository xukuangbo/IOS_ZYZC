//
//  ZCTotalPeopleView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/26.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCTotalPeopleView.h"
#import "UserModel.h"
#import "ZCDetailCustomButton.h"
@interface ZCTotalPeopleView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIScrollView  *scroll;
@end

@implementation ZCTotalPeopleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H)];
    _bgView.backgroundColor=[UIColor blackColor];
    _bgView.alpha=0.3;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_bgView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(down)];
    [_bgView addGestureRecognizer:tap];
    
    self.frame=CGRectMake(0, KSCREEN_H, KSCREEN_W, KSCREEN_H*3/5);
    self.backgroundColor=[UIColor ZYZC_BgGrayColor];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 44)];
    topView.backgroundColor=[UIColor whiteColor];
    [self addSubview:topView];
    
    UIButton *downBtn =[ZYZCTool getCustomBtnByTilte:@"收起" andImageName:@"btn_up" andtitleFont:[UIFont systemFontOfSize:17]];
    downBtn.frame=CGRectMake(self.width-60, 0, 50, topView.height);
     [downBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:downBtn];
    
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bottom, self.width, self.height-topView.height-KEDGE_DISTANCE)];
    [self addSubview:_scroll];
    
    
    __weak typeof (&*self)weakSelf=self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.top=KSCREEN_H-weakSelf.height;
    }];
}

-(void)setUsers:(NSArray *)users
{
    _users=users;
    int     row=5;
    CGFloat btn_width=50*KCOFFICIEMNT;
    CGFloat btn_edg=(self.width-row*btn_width )/6;
    
    CGFloat lastBtn_bottom=0.0;
    for (NSInteger i=0; i<users.count; i++) {
        UserModel *user=users[i];
        ZCDetailCustomButton *userBtn=[[ZCDetailCustomButton alloc]initWithFrame:CGRectMake(btn_edg+(btn_edg+btn_width)*(i%row), btn_edg+(btn_edg+btn_width)*(i/row), btn_width, btn_width)];
        [userBtn sd_setImageWithURL:[NSURL URLWithString:user.faceImg] forState:UIControlStateNormal];
        userBtn.layer.cornerRadius=4;
        userBtn.layer.masksToBounds=YES;
        [_scroll addSubview:userBtn];
        if (i==users.count-1) {
            lastBtn_bottom=userBtn.bottom;
        }
    }
    if (lastBtn_bottom>_scroll.height) {
        _scroll.contentSize=CGSizeMake(0, lastBtn_bottom);
    }
}


#pragma mark --- 收起
-(void)down
{
    [_bgView removeFromSuperview];
    __weak typeof (&*self)weakSelf=self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.top=KSCREEN_H;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}



@end
