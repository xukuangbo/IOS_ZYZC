//
//  ZCMainTableViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCMainTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface ZCMainTableViewCell ()
@property(nonatomic,weak)IBOutlet UIView  *lineView;
@property(nonatomic,strong)  UILabel      *distanceLab;
@property(nonatomic,strong)  UILabel      *careerLab;
@property(nonatomic,strong)  UILabel      *userInfoLab;
@property(nonatomic,strong)  UIImageView  *sexImg;
@property(nonatomic,strong)  UIImageView  *vipImg;
@property(nonatomic,strong)  UILabel      *nameLab;
@property(nonatomic,strong)  UIImageView  *placeBgImg;
@property(nonatomic,strong)  UIImageView  *myProgressView;
@property(nonatomic,strong)  UILabel      *placeLab;
@property(nonatomic,strong)  UIScrollView *specialtyView;
@end

@interface ZCMainTableViewCell ()
@end
@implementation ZCMainTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self configUI];
}
-(void)configUI
{
    self.backgroundColor= [UIColor ZYZC_BgGrayColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    //设置头像弧度
    _bgIconView.layer.cornerRadius=KCORNERRADIUS;
    _bgIconView.layer.masksToBounds=YES;
    _iconImg.layer.cornerRadius=3;
    _iconImg.layer.masksToBounds=YES;
    _iconImg.layer.borderWidth=0.5;
    _iconImg.layer.borderColor=[UIColor whiteColor].CGColor;
    //设置卡片背景图
    _bgImg.image=KPULLIMG(@"tab_bg_boss0", 10, 0, 10, 0);
    //设置进度条
    _myProgressView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 5)];
    _myProgressView.image=KPULLIMG(@"jdt_up", 0, 5, 0, 5);
    [_progressBgImg addSubview:_myProgressView];
    _placeBgImg.hidden=YES;
    //出行目的的背景横条
    _placeBgImg=[[UIImageView alloc]initWithFrame:CGRectMake(-KEDGE_DISTANCE,7, 40, 29)];
    _placeBgImg.alpha=0.7;
    _placeBgImg.image=KPULLIMG(@"xjj_fuc", 0, 10, 0, 10) ;
    [_sceneryImg addSubview:_placeBgImg];
    //飞机图片
    UIImageView *planeImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, 18, 17)];
    planeImg.image=[UIImage imageNamed:@"btn_p"];
    [_sceneryImg addSubview:planeImg];
    //目的地展示标签
    _placeLab=[[UILabel alloc]initWithFrame:CGRectMake(22, 9, 0, 29)];
    _placeLab.textColor=[UIColor whiteColor];
    _placeLab.font=[UIFont boldSystemFontOfSize:20];
    [_sceneryImg addSubview:_placeLab];
    
    //姓名展示标签
    _nameLab=[[UILabel alloc]init];
    _nameLab.font=[UIFont systemFontOfSize:20];
    _nameLab.textColor=[UIColor ZYZC_TextBlackColor];
    _nameLab.text=@"杨小小小";
    [_infoView addSubview:_nameLab];
    //性别展示图
    _sexImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_sex_fem"]];
    [_infoView addSubview:_sexImg];
    //vip展示图
    _vipImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_id"]];
    [_infoView addSubview:_vipImg];
    //距离标签展示
    _distanceLab=[self createTextLab];
    _distanceLab.frame=CGRectMake(KSCREEN_W-130-80, 22, 80, 18);
    _distanceLab.textAlignment=NSTextAlignmentRight;
    [_infoView addSubview:_distanceLab];
    //职业标签
    _careerLab=[self createTextLab];
    _careerLab.frame=CGRectMake(0, CGRectGetMaxY(_distanceLab.frame)+3,_infoView.frame.size.width, 18);
    _careerLab.text=@"建筑师";
    [_infoView addSubview:_careerLab];
    
    //个人基本信息标签
    _userInfoLab=[self createTextLab];
    _userInfoLab.frame=CGRectMake(0, CGRectGetMaxY(_careerLab.frame)+3, KSCREEN_W-130, 18);
    _userInfoLab.text=@"30岁  处女座  45kg  172cm  单身";
    [_infoView addSubview:_userInfoLab];
    
    //添加展示特长视图
    _specialtyView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60,  KSCREEN_W-130, 22)];
    _specialtyView.contentSize=CGSizeMake( KSCREEN_W-130, 0);
    _specialtyView.showsHorizontalScrollIndicator=NO;
    _specialtyView.bounces=NO;
    [_infoView addSubview:_specialtyView];
}

-(void)setOneModel:(ZCOneModel *)oneModel
{
    _oneModel=oneModel;
    _lineView.hidden=YES;
    [_sceneryImg sd_setImageWithURL:[NSURL URLWithString:oneModel.product.headImage]  placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    _sceneryImg.contentMode=UIViewContentModeScaleToFill;
    //计算目的地的文字长度
    NSMutableString *place=[NSMutableString string];
    NSArray *dest=[ZYZCTool turnJsonStrToArray:oneModel.product.productDest];
    NSInteger destNumber=dest.count;
    for (NSInteger i=0; i<destNumber;i++) {
        if (i==0) {
            [place appendString:dest[i]];
        }
        else
        {
            [place appendString:[NSString stringWithFormat:@"—%@",dest[i]]];
        }
    }
    CGFloat placeStrWidth=[ZYZCTool calculateStrLengthByText:place andFont:_placeLab.font andMaxWidth:KSCREEN_W].width;
    //改变目的地展示标签的长度
    _placeLab.width=placeStrWidth;
    _placeLab.text=place;
    //改变目的地背景条长度
    _placeBgImg.width=placeStrWidth+40;
    
    //计算名字的文字长度
    NSString *name=oneModel.user.userName;
    CGFloat nameStrWidth=[ZYZCTool calculateStrLengthByText:name andFont:_nameLab.font andMaxWidth:KSCREEN_W].width;
    CGFloat width=KSCREEN_W-250;
    CGFloat edgToName=nameStrWidth;
    if (nameStrWidth>=width) {
        nameStrWidth=width;
        edgToName=width-12;
    }
    _nameLab.text=name;
    //改变名字标签的frame
    _nameLab.frame=CGRectMake(0, 22, nameStrWidth, 20);
    //改变性别展示图的frame
    _sexImg.frame=CGRectMake(edgToName, 22, 20, 20);
    if ([oneModel.user.sex isEqualToString:@"1"]) {
        _sexImg.image=[UIImage imageNamed:@"btn_sex_mal"];
    }
    else if ([oneModel.user.sex isEqualToString:@"2"])
    {
       _sexImg.image=[UIImage imageNamed:@"btn_sex_fem"];
    }
    //改变VIP展示图的frame
    _vipImg.frame=CGRectMake(edgToName+22, 23, 18, 18);
    _vipImg.hidden=YES;
    //距离标签
    _distanceLab.text=@"距离1.2km";
    _distanceLab.hidden=YES;
    //职位标签
    _careerLab.text=@"建筑师";
    //个人基本信息
    _userInfoLab.text=@"30岁  处女座  45kg  172cm  单身";
    //进度条
    _myProgressView.width=(KSCREEN_W-40)*0.5;
}

-(void)setDetailInfoModel:(ZCDetailInfoModel *)detailInfoModel
{
    _detailInfoModel=detailInfoModel;
    _titleLab.hidden=YES;
    _lineView.hidden=NO;
    _sceneryImg.hidden=YES;
    _placeBgImg.hidden=YES;
    
    
    NSArray *views=[_lineView subviews];
    for (NSInteger i=views.count-1; i>=0; i--) {
        [views[i] removeFromSuperview];
    }
    UIImageView *planeImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, -20, 18, 17)];
    planeImg.image=[UIImage imageNamed:@"btn_p_green"];
    [_lineView addSubview:planeImg];
    
    UILabel *destinationLab=[[UILabel alloc]initWithFrame:CGRectMake(planeImg.right+5, -22, KSCREEN_W-planeImg.width-_recommendLab.width-2*KEDGE_DISTANCE, 20)];
    destinationLab.text=@"清迈－普吉岛";
    destinationLab.textColor=[UIColor ZYZC_TextBlackColor];
    destinationLab.font=[UIFont systemFontOfSize:17];
    [_lineView addSubview:destinationLab];
    
    //计算名字的文字长度
    NSString *name=@"杨小小";
    CGFloat nameStrWidth=[ZYZCTool calculateStrLengthByText:name andFont:_nameLab.font andMaxWidth:KSCREEN_W].width;
    CGFloat width=KSCREEN_W-160;
    CGFloat edgToName=nameStrWidth;
    if (nameStrWidth>=width) {
        nameStrWidth=width;
        edgToName=width-12;
    }
    _nameLab.text=name;
    //改变名字标签的frame
    _nameLab.frame=CGRectMake(0, 0, nameStrWidth, 20);
    //改变性别展示图的frame
    _sexImg.frame=CGRectMake(edgToName, 0, 20, 20);
    //改变VIP展示图的frame
    _vipImg.frame=CGRectMake(edgToName+22, 1, 18, 18);
    //距离标签

    _distanceLab.hidden=YES;
    _careerLab.top=CGRectGetMaxY(_nameLab.frame)+3;
    _userInfoLab.top=CGRectGetMaxY(_careerLab.frame)+3;
    
    //添加特长
    NSArray *specialties=@[@"旅游",@"唱歌",@"跳舞",@"自驾",@"文艺"];
    NSArray *subViews=[_specialtyView subviews];
    for (UIView *obj in subViews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            [obj removeFromSuperview];
        }
    }
    CGFloat edg=3;
    for (int i=0; i<specialties.count; i++) {
        UILabel *lab=[self createTextLab];
        lab.font=[UIFont systemFontOfSize:13];
        lab.textAlignment=NSTextAlignmentCenter;
        CGFloat width=[ZYZCTool calculateStrLengthByText:name andFont:lab.font andMaxWidth:KSCREEN_W].width;
        lab.frame=CGRectMake((edg+width-5)*i, 4, width-5, 16) ;
        lab.layer.borderWidth=1;
        lab.layer.borderColor=[UIColor ZYZC_MainColor].CGColor;
        lab.text=specialties[i];
        [_specialtyView addSubview:lab];
    }
    //进度条
    _myProgressView.width=(KSCREEN_W-40)*0.5;
}

-(UILabel *)createTextLab
{
    UILabel *lab=[[UILabel alloc]init];
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=[UIColor ZYZC_TextGrayColor];
    return lab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
