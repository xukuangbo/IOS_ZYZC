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
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//    }
//    return self;
//}



-(void)configUI
{
    [super configUI];
    self.titleLab.text=@"众筹目的";
    self.titleLab.font=[UIFont boldSystemFontOfSize:17];
    
    _wsmView=[[ZCWSMView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, self.topLineView.bottom+KEDGE_DISTANCE, self.bgImg.width-2*KEDGE_DISTANCE, 0)];
    [self.bgImg addSubview:_wsmView];
}

-(void)setCellModel:(ZCDetailProductModel *)cellModel
{
    _cellModel=cellModel;
    
//    cellModel.productVideo=@"http://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/oulbuvldivtdyH01mEvBmkoX-xC0/20160507190655/20160507190526.mp4";
//    
//    cellModel.productVideoImg=@"http://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/oulbuvldivtdyH01mEvBmkoX-xC0/20160507190655/20160507190526.png";
//    
//    cellModel.productVoice=@"tp://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com/oulbuvolvV8uHEyZwU7gAn8icJFw/20160512105904/20160512105843.caf";
    
    [_wsmView reloadDataByVideoImgUrl:cellModel.productVideoImg andPlayUrl:cellModel.productVideo andVoiceUrl:cellModel.productVoice andFaceImg:cellModel.user.faceImg andDesc:cellModel.desc];
    self.bgImg.height=_wsmView.bottom+KEDGE_DISTANCE;
    cellModel.introFirstCellHeight= self.bgImg.height;
}

@end

















