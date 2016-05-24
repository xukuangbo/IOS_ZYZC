//
//  ZCDetailBottomView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/23.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailBottomView.h"

@implementation ZCDetailBottomView

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
        self.size=CGSizeMake(KSCREEN_W, 49);
        self.left=0;
        self.top=KSCREEN_H-self.height;
        self.backgroundColor=[UIColor ZYZC_TabBarGrayColor];
        [self addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, KSCREEN_W, 0.5) andColor:[UIColor lightGrayColor]]];
    }
    return self;
}

-(void)setZcType:(ZC_TYPE)zcType
{
    _zcType=zcType;
    if (zcType == AllList) {
        [self configUI01];
    }
    else if (zcType == Mylist)
    {
        [self configUI02];
    }
}

#pragma mark --- 访客版控件创建
-(void)configUI01
{
    NSArray *titleArr=@[@"评论",@"支持",@"推荐"];
    CGFloat btn_width=KSCREEN_W/3;
    for (int i=0; i<3; i++) {
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame=CGRectMake(btn_width*i, self.height/2-20, btn_width, 40);
        [sureBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        sureBtn.layer.cornerRadius=KCORNERRADIUS;
        sureBtn.layer.masksToBounds=YES;
        [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag=CommentType+i;
        [self addSubview:sureBtn];
    }
}

#pragma mark --- 个人版控件创建
-(void)configUI02
{
    NSArray *titleArr=@[@"补充说明",@"支持自己"];
    CGFloat btn_width=KSCREEN_W/2;
    for (int i=0; i<2; i++) {
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame=CGRectMake(btn_width*i, self.height/2-20, btn_width, 40);
        [sureBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag=CommentType+i;
        [self addSubview:sureBtn];
    }

}

#pragma mark --- 底部按钮点击事件
-(void)clickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case CommentType:
            //评论
            if (_commentBlock) {
                _commentBlock();
            }
            break;
        case SupportType:
            //支持
            if (_supportBlock) {
                _supportBlock();
            }
            break;
        case RecommendType:
            //推荐
            break;
        default:
            break;
    }
}






@end
