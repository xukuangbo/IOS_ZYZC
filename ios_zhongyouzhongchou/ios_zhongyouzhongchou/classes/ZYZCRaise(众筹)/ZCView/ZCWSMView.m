//
//  ZCWSMView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/19.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCWSMView.h"
@interface ZCWSMView ()

@property (nonatomic, strong)ZYZCCusomMovieImage *movieView;
@property (nonatomic, strong)ZYZCCustomVoiceView *voiceView;
@property (nonatomic, strong)UILabel             *textLab;

@end
@implementation ZCWSMView

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
    _movieView=[[ZYZCCusomMovieImage alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width/8*5)];
    [self addSubview:_movieView];
    
    _voiceView=[[ZYZCCustomVoiceView alloc]initWithFrame:CGRectMake(0, _movieView.bottom+KEDGE_DISTANCE, self.width, 40)];
    _voiceView.voiceTime=50;
    [self addSubview:_voiceView];
    
    _textLab=[[UILabel alloc]initWithFrame:CGRectMake(0, _voiceView.bottom+KEDGE_DISTANCE, self.width, 1)];
    _textLab.font=[UIFont systemFontOfSize:14];
    _textLab.textColor=[UIColor ZYZC_TextBlackColor];
    _textLab.numberOfLines=0;
    [self addSubview:_textLab];
    
    self.height=1;
}

-(void)reloadDataByVideoImgUrl:(NSString *)videoImgUrl andPlayUrl:(NSString *)playUrl andVoiceUrl:(NSString *)voiceUrl andFaceImg:(NSString *)faceImg andDesc:(NSString *)desc
{
    BOOL hasMovie=NO,hasVoice=NO,hasWord=NO;
    CGFloat voiceShowTop=0.0,textLabTop=0.0;
    
    if (videoImgUrl.length) {
        hasMovie=YES;
        //区分是不是本地数据
        NSRange range=[videoImgUrl rangeOfString:KMY_ZHONGCHOU_FILE];
        if (range.length) {
            _movieView.image=[UIImage imageWithContentsOfFile:videoImgUrl];
        }
        else{
            [_movieView sd_setImageWithURL:[NSURL URLWithString:videoImgUrl]];
        }
        _movieView.playUrl=playUrl;
    }
    else
    {
        [_movieView removeFromSuperview];
    }
     voiceShowTop=(CGFloat)hasMovie*(_movieView.height+KEDGE_DISTANCE);
    
    if (voiceUrl.length) {
        hasVoice=YES;
        _voiceView.faceImg=faceImg;
        _voiceView.voiceUrl=voiceUrl;
        _voiceView.top=voiceShowTop;
    }
    else
    {
        [_voiceView removeFromSuperview];
    }
    
     textLabTop=voiceShowTop+(CGFloat)hasVoice*(_voiceView.height+KEDGE_DISTANCE);
    
    if (desc.length) {
        hasWord=YES;
        CGFloat textHeight=[ZYZCTool calculateStrByLineSpace:10.0 andString:desc andFont:_textLab.font  andMaxWidth:self.textLab.width].height;
        self.textLab.height=textHeight;
        self.textLab.attributedText=[ZYZCTool setLineDistenceInText:desc];
        _textLab.top=textLabTop;
    }
    else
    {
        [_textLab removeFromSuperview];
    }
    
     self.height=textLabTop+hasWord*_textLab.height;
}

@end
