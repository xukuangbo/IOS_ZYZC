//
//  ZCDetailIntroFirstCellVoiceShowView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailIntroFirstCellVoiceShowView.h"

@implementation ZCDetailIntroFirstCellVoiceShowView

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
    _iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _iconImg.backgroundColor=[UIColor redColor];
    _iconImg.layer.cornerRadius=KCORNERRADIUS;
    _iconImg.layer.masksToBounds=YES;
    [self addSubview:_iconImg];
    
    _voiceView=[[UIImageView alloc]initWithFrame:CGRectMake(_iconImg.right +KEDGE_DISTANCE, self.height-38, 50, 38)];
    _voiceView.image=KPULLIMG(@"icon_voice",0,44,0,5);;
    [self addSubview:_voiceView];
    
}

@end























