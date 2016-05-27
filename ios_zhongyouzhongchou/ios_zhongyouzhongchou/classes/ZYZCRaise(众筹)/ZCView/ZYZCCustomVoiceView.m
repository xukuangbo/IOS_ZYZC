//
//  ZYZCCustomVioceView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/19.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCCustomVoiceView.h"
#import "RecordSoundObj.h"
#import <AVFoundation/AVFoundation.h>
@interface ZYZCCustomVoiceView ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIImageView *voiceView;
@property (nonatomic, strong) UIImageView *voiceImg;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, assign) BOOL getStop;
@property (nonatomic, strong) RecordSoundObj *soundObj;
@property (nonatomic, strong) AVPlayer *avPlayer;
@end

@implementation ZYZCCustomVoiceView

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
    _iconImg.image=[UIImage imageNamed:@"icon_placeholder"];
    _iconImg.layer.cornerRadius=KCORNERRADIUS;
    _iconImg.layer.masksToBounds=YES;
    [self addSubview:_iconImg];
    
    _voiceView=[[UIImageView alloc]initWithFrame:CGRectMake(_iconImg.right +KEDGE_DISTANCE, self.height-38, 50, 38)];
    _voiceView.image=KPULLIMG(@"voiceIcon",0,10,0,5);
    [self addSubview:_voiceView];
    _voiceView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listenVoice:)];
    [_voiceView addGestureRecognizer:tap];
    
    _voiceImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 14, _voiceView.height)];
    _voiceImg.image=[UIImage imageNamed:@"horn3"];
    [_voiceView addSubview:_voiceImg];
//
    NSMutableArray *imgArr=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"horn%d",i+1]];
        [imgArr addObject:image];
    }
    _voiceImg.animationImages=imgArr;
    _voiceImg.animationDuration = 0.6;
    _voiceImg.animationRepeatCount = 0;

    //语音时长
    //    _timeLab=[[UILabel alloc]initWithFrame:CGRectMake(_voiceView.right+KEDGE_DISTANCE, self.height-38, self.width-_voiceView.right-KEDGE_DISTANCE, 38)];
    //    _timeLab.font=[UIFont systemFontOfSize:20];
    //    _timeLab.textColor=[UIColor ZYZC_TextGrayColor04];
    //    [self addSubview:_timeLab];
}


-(void)setFaceImg:(NSString *)faceImg
{
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:faceImg] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
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
    NSRange range=[_voiceUrl rangeOfString:KMY_ZHONGCHOU_FILE];
    if (range.length) {
        //播放本地音频文件
       _soundObj=[[RecordSoundObj alloc]init];
        _soundObj.soundFileName=_voiceUrl;
        __weak typeof (&*self)weakSelf=self;
        _soundObj.soundPlayEnd=^()
        {
            [weakSelf.voiceImg stopAnimating];
        };
        [_voiceImg startAnimating];
        [_soundObj playSound];
    }
    else
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        //播放网络音频文件
        _avPlayer=[[AVPlayer alloc]initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_voiceUrl]]];
        [_voiceImg startAnimating];
        [_avPlayer play];
    }
}


-(void)playEnd
{
    [_voiceImg stopAnimating];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
