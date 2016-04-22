//
//  ZCDetailIntroFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailIntroFirstCell.h"

@implementation ZCDetailIntroFirstCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _hasMovie=YES;
        _hasVoice=YES;
        _hasWord =YES;
    }
    return self;
}



-(void)configUI
{
    [super configUI];
    self.titleLab.text=@"众筹目的";
    self.titleLab.font=[UIFont boldSystemFontOfSize:17];
    
    _movieImg=[[ZYZCCusomMovieImage alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, 0, KSCREEN_W-4*KEDGE_DISTANCE, (KSCREEN_W-4*KEDGE_DISTANCE)*5/8)];
    [self.contentView addSubview:_movieImg];
    
    _voiceShow=[[ZCDetailIntroFirstCellVoiceShowView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE,0, KSCREEN_W-4*KEDGE_DISTANCE, 40)];
    [self.contentView addSubview:_voiceShow];
    
    _textLab=[[UILabel alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, 0, KSCREEN_W-4*KEDGE_DISTANCE, 0)];
    _textLab.font=[UIFont systemFontOfSize:14];
    _textLab.textColor=[UIColor ZYZC_TextBlackColor];
    _textLab.numberOfLines=0;
    [self.contentView addSubview:_textLab];
    
}

-(void)setCellModel:(ZCDetailIntroFirstCellModel *)cellModel
{
    _cellModel=cellModel;
    NSString *text=@"        打发时间的开发建设代理反馈圣诞节发生地方尖端放电繁华的风景快点恢复健康是否会电视大会精神上的咖啡开始的风景是否卢卡申科发生大量开发建设的繁花似锦粉红色看见繁花似锦匡扶汉室开发";
    
    CGFloat movieImgTop=self.topLineView.bottom +KEDGE_DISTANCE;
    _movieImg.top=movieImgTop;
    CGFloat voiceShowTop=movieImgTop+(CGFloat)_hasMovie*(_movieImg.height+KEDGE_DISTANCE);
    _voiceShow.top=voiceShowTop;
    CGFloat textLabTop=voiceShowTop+(CGFloat)_hasVoice*(_voiceShow.height+KEDGE_DISTANCE);
    _textLab.top=textLabTop;
    //是否有视屏
    if (!_hasMovie) {
        [_movieImg removeFromSuperview];
    }
    else
    {
        
        
    }
    //是否有语音
    if (!_hasVoice) {
        [_voiceShow removeFromSuperview];
    }
    else
    {
        CGFloat voiceTime=60;
        CGFloat totalLength=_voiceShow.width-_voiceShow.iconImg.right-2*KEDGE_DISTANCE-80;
        _voiceShow.voiceView.width=50+voiceTime/60*totalLength;
        _voiceShow.timeLab.left=_voiceShow.voiceView.right+KEDGE_DISTANCE;
        _voiceShow.timeLab.text=[NSString stringWithFormat:@"%.f''",voiceTime];
    }
    //是否有文字
    if (!_hasWord) {
        [_textLab removeFromSuperview];
    }
    else
    {
        CGFloat textHeight=[ZYZCTool calculateStrByLineSpace:10.0 andString:text andFont:_textLab.font  andMaxWidth:_textLab.width].height;
        _textLab.height=textHeight;
        _textLab.attributedText=[ZYZCTool setLineDistenceInText:text];
    }
    
    
    //计算cell的高度
    CGFloat cellHeight=textLabTop+(CGFloat)_hasWord*(_textLab.height+KEDGE_DISTANCE);
    self.bgImg.height=cellHeight;
    _cellModel.cellHeight=cellHeight;
}

@end

















