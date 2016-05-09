//
//  ZCOneProductCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCOneProductCell.h"

@interface ZCOneProductCell ()

@end

@implementation ZCOneProductCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor= [UIColor ZYZC_BgGrayColor];
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, 0, KSCREEN_W-2*KEDGE_DISTANCE, CELL_HEIGHT)];
    bgImg.image=KPULLIMG(@"tab_bg_boss0", 10, 0, 10, 0);
    [self.contentView addSubview:bgImg];
    
    //添加标题
    _titleLab=[self createLabWithFrame:CGRectMake(KEDGE_DISTANCE, KEDGE_DISTANCE, bgImg.width-100-KEDGE_DISTANCE, 30) andFont:[UIFont systemFontOfSize:23] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _titleLab.text=@"走近神秘的高棉";
    [bgImg addSubview:_titleLab];
    
    //添加推荐
    _recommendLab=[self createLabWithFrame:CGRectMake(bgImg.width-100-KEDGE_DISTANCE, KEDGE_DISTANCE, 100, 20) andFont:[UIFont systemFontOfSize:15] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _recommendLab.textAlignment=NSTextAlignmentRight;
    _recommendLab.text=@"600人推荐";
    [bgImg addSubview:_recommendLab];
    
    //添加风景图
    _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, _titleLab.bottom+KEDGE_DISTANCE, bgImg.width, 150*KCOFFICIEMNT)];
    _headImage.image=[UIImage imageNamed:@"image_placeholder"];
    [bgImg addSubview:_headImage];
    
    //添加旅行目的地
        //添加底部视图
        _destLayerImg=[[UIImageView alloc]initWithFrame:CGRectMake(-KEDGE_DISTANCE, _headImage.top+7, 50, 30)];
        _destLayerImg.image=KPULLIMG(@"xjj_fuc", 0, 10, 0, 10);
        [bgImg  addSubview:_destLayerImg];
        //添加✈️
        UIImageView *planeImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,_headImage.top+15, 18, 17)];
        planeImg.image=[UIImage imageNamed:@"btn_p"];
        [bgImg addSubview:planeImg];
        //添加目的地
        _destLab=[self createLabWithFrame:CGRectMake(12, _headImage.top+9, 0, 29) andFont:[UIFont boldSystemFontOfSize:20] andTitleColor:[UIColor whiteColor]];
        [bgImg addSubview:_destLab];
    
    
    //添加头像
    UIView *iconBgView=[[UIView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, _headImage.bottom-KEDGE_DISTANCE, 82, 82)];
    iconBgView.layer.cornerRadius=KEDGE_DISTANCE;
    iconBgView.layer.masksToBounds=YES;
    [bgImg addSubview:iconBgView];
    
    _iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(4, 4, 74, 74)];
    _iconImage.layer.cornerRadius=3;
    _iconImage.layer.masksToBounds=YES;
    _iconImage.backgroundColor=[UIColor yellowColor];
    [iconBgView addSubview:_iconImage];
    
    //添加姓名
    _nameLab=[self createLabWithFrame:CGRectMake(iconBgView.right+ KEDGE_DISTANCE-4, _headImage.bottom+KEDGE_DISTANCE, 50, 20)  andFont:[UIFont systemFontOfSize:20] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _nameLab.text=@"杨大";
    [bgImg addSubview:_nameLab];
    
    //添加性别
    _sexImg=[[UIImageView alloc]initWithFrame:CGRectMake(_nameLab.right+3, _nameLab.top, 20, 20)];
    _sexImg.image=[UIImage imageNamed:@"btn_sex_fem"];
    [bgImg addSubview:_sexImg];
    
    //添加vip
    _vipImg=[[UIImageView alloc]initWithFrame:CGRectMake(_sexImg.right+3, _nameLab.top+2, 18, 18)];
    _vipImg.image=[UIImage imageNamed:@"icon_id"];
    [bgImg addSubview:_vipImg];
    
    //添加距离
    _destenceLab=[self createLabWithFrame:CGRectMake(bgImg.width-80-KEDGE_DISTANCE, _nameLab.top, 80, 20) andFont:[UIFont systemFontOfSize:14] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _destenceLab.textAlignment=NSTextAlignmentRight;
    [bgImg addSubview:_destenceLab];
    
    //添加职业
    _jobLab=[self createLabWithFrame:CGRectMake(_nameLab.left, _nameLab.bottom, bgImg.width-_nameLab.left-KEDGE_DISTANCE, 15) andFont:[UIFont systemFontOfSize:14] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _jobLab.text=@"建筑师";
    [bgImg addSubview:_jobLab];
    
    //添加个人基础信息
    _infoLab=[self createLabWithFrame:CGRectMake(_nameLab.left, _jobLab.bottom, bgImg.width-_nameLab.left-KEDGE_DISTANCE, 15) andFont:[UIFont systemFontOfSize:14] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _infoLab.text=@"30岁  处女座  45kg  172cm  单身";
    [bgImg addSubview:_infoLab];
    
    //添加预筹资金
    _moneyLab=[self createLabWithFrame:CGRectMake(KEDGE_DISTANCE, iconBgView.bottom+KEDGE_DISTANCE-4, bgImg.width/2-KEDGE_DISTANCE, 15) andFont:[UIFont systemFontOfSize:15] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _moneyLab.text=@"预筹¥5000";
    [bgImg addSubview:_moneyLab];
    
    //添加出发时间
    _startLab=[self createLabWithFrame:CGRectMake(_moneyLab.right, _moneyLab.top, bgImg.width/2-KEDGE_DISTANCE, 15) andFont:[UIFont systemFontOfSize:15] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _startLab.text=@"2016/03出发";
    [bgImg addSubview:_startLab];
    
    //添加进度条
//    _emptyProgress=[UIImageView alloc]initWithFrame:<#(CGRect)#>
    
    
    
    
    
     NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZCInfoView" owner:nil options:nil];
    _zcInfoView=[nibView objectAtIndex:0];
    
    
}


-(UILabel *)createLabWithFrame:(CGRect )frame andFont:(UIFont *)font andTitleColor:(UIColor *)color
{
    UILabel *lab=[[UILabel alloc]initWithFrame:frame];
    lab.font=font;
    lab.textColor=color;
    return lab;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
