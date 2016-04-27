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

-(void)setCellModel:(ZCDetailIntroFirstCellModel *)cellModel
{
    _cellModel=cellModel;
    self.hasMovie=YES;
    self.hasVoice=YES;
    self.hasWord =YES;
    [self reloadDataByModel];
    _cellModel.cellHeight= self.bgImg.height;
}

-(void)reloadDataByModel
{
    NSString *text=@"        打发时间的开得舒服的方式氮磷钾肥的时间发建设代理反馈圣诞节发生地方尖端放电繁华的风景快点恢复健康是否会电视大会精神上的咖啡开始的风景是否卢卡申科发生大量开发建设的繁花似锦粉红色看见繁花似锦匡扶汉室开发";
    
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
    else
    {
        
        
    }
    //是否有语音
    if (!self.hasVoice) {
        [self.voiceShow removeFromSuperview];
    }
    else
    {
        self.voiceShow.voiceTime=50;
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

















