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

-(void)setCellModel:(ZCDetailProductModel *)cellModel
{
    _cellModel=cellModel;
//    if (cellModel.voice) {
        self.hasMovie=YES;
//    }
//    if (cellModel.voice) {
        self.hasVoice=YES;
//    }
    if (cellModel.desc) {
       self.hasWord =YES;
    }
    [self reloadDataByModel];
    _cellModel.introFirstCellHeight= self.bgImg.height;
}

-(void)reloadDataByModel
{
    NSString *text = _cellModel.desc;
    
    CGFloat movieImgTop=self.topLineView.bottom +KEDGE_DISTANCE;
    self.movieImg.top=movieImgTop;
    CGFloat voiceShowTop=movieImgTop+(CGFloat)self.hasMovie*(self.movieImg.height+KEDGE_DISTANCE);
    self.voiceShow.top=voiceShowTop;
    CGFloat textLabTop=voiceShowTop+(CGFloat)self.hasVoice*(self.voiceShow.height+KEDGE_DISTANCE);
    self.textLab.top=textLabTop;
    //是否有视屏
    if (!self.hasMovie) {
        [self.movieImg removeFromSuperview];
    }
    //有视屏
    else
    {
//        self.movieImg.playUrl=_cellModel.video;
        self.movieImg.playUrl=@"http://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/oulbuvldivtdyH01mEvBmkoX-xC0/20160507190655/20160507190526.mp4";
//        [self.movieImg sd_setImageWithURL:[NSURL URLWithString:_cellModel.videoImg]];
         [self.movieImg sd_setImageWithURL:[NSURL URLWithString:@"http://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/oulbuvldivtdyH01mEvBmkoX-xC0/20160507190655/20160507190526.png"]];
        
    }
    //是否有语音
    if (!self.hasVoice) {
        [self.voiceShow removeFromSuperview];
    }
    else
    {
        self.voiceShow.voiceTime=50;
//        self.voiceShow.voiceUrl=_cellModel.voice;
        self.voiceShow.voiceUrl=@"tp://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/oulbuvolvV8uHEyZwU7gAn8icJFw/20160512105904/20160512105843.caf";
        [self.voiceShow.iconImg sd_setImageWithURL:[NSURL URLWithString:_cellModel.user.faceImg] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    }
    //是否有文字
    if (!self.hasWord) {
        [self.textLab removeFromSuperview];
    }
    else
    {
        CGFloat textHeight=[ZYZCTool calculateStrByLineSpace:10.0 andString:text andFont:self.textLab.font  andMaxWidth:self.textLab.width].height;
        self.textLab.height=textHeight;
        self.textLab.attributedText=[ZYZCTool setLineDistenceInText:text];
    }
    
    //计算cell的高度
    CGFloat cellHeight=textLabTop+(CGFloat)self.hasWord*(self.textLab.height+KEDGE_DISTANCE);
    self.bgImg.height=cellHeight;
}


@end

















