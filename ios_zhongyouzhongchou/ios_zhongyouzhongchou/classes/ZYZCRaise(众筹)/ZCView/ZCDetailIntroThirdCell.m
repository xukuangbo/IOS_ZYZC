//
//  ZCDetailIntroThirdCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define SUBDES_FORMOVIE(goal) [NSString stringWithFormat:@"趣味动画教你畅游%@",goal]

#import "ZCDetailIntroThirdCell.h"
#import "UIView+TacticMapView.h"
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
    self.titleLab.font=[UIFont boldSystemFontOfSize:17];
    [self.topLineView removeFromSuperview];
    
    UIView *view01=[UIView lineViewWithFrame:CGRectMake(2*KEDGE_DISTANCE, KEDGE_DISTANCE+5, 2, 20) andColor:[UIColor ZYZC_MainColor]];
    [self.contentView addSubview:view01];
    self.titleLab.left=view01.right ;
    
    _subDesLab=[[UILabel alloc]initWithFrame:CGRectMake(3*KEDGE_DISTANCE, self.titleLab.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE, 20)];
    _subDesLab.textColor=[UIColor ZYZC_TextGrayColor04];
    _subDesLab.text=SUBDES_FORMOVIE(@"");
    [self.contentView addSubview:_subDesLab];
    
    _movieImg =[[UIImageView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, _subDesLab.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE,(KSCREEN_W-4*KEDGE_DISTANCE)*5/8)];
    _movieImg.backgroundColor= [UIColor greenColor];
    _movieImg.layer.cornerRadius=KCORNERRADIUS;
    _movieImg.layer.masksToBounds=YES;
    [self.contentView addSubview:_movieImg];
    
    UIImageView *startImg=[[UIImageView alloc]init];
    startImg.center=CGPointMake(_movieImg.width/2, _movieImg.height/2);
    startImg.bounds=CGRectMake(0, 0, 60, 60);
    startImg.image=[UIImage imageNamed:@"btn_v_on"];
    [_movieImg addSubview:startImg];
}

@end
