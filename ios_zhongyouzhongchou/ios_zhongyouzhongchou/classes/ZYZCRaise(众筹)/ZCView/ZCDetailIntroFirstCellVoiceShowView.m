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
        self.height=40;
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
    _voiceView.image=KPULLIMG(@"icon_voice",0,44,0,5);
    [self addSubview:_voiceView];
    _voiceView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listenVoice:)];
    [_voiceView addGestureRecognizer:tap];
    
    _timeLab=[[UILabel alloc]initWithFrame:CGRectMake(_voiceView.right+KEDGE_DISTANCE, self.height-38, self.width-_voiceView.right-KEDGE_DISTANCE, 38)];
    _timeLab.font=[UIFont systemFontOfSize:20];
    _timeLab.textColor=[UIColor ZYZC_TextGrayColor04];
    [self addSubview:_timeLab];
}

-(void)setVoiceTime:(NSInteger )voiceTime
{
    _voiceTime=voiceTime;
    CGFloat totalLength=self.width-self.iconImg.right-2*KEDGE_DISTANCE-80;
    self.voiceView.width=50+((CGFloat)voiceTime/60.0)*totalLength;
    self.timeLab.left=self.voiceView.right+KEDGE_DISTANCE;
    self.timeLab.text=[NSString stringWithFormat:@"%.zd''",voiceTime];
}

-(void)listenVoice:(UITapGestureRecognizer *)tap
{
    //播放语音
    NSLog(@"播放语音");
}

@end























