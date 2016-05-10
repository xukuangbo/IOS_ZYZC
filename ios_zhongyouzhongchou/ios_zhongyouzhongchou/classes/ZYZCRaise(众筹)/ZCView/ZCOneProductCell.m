//
//  ZCOneProductCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCOneProductCell.h"
#import "NSDate+RMCalendarLogic.h"
#define KRAISE_MONEY(money)  [NSString stringWithFormat:@"预筹¥%.f",money]
#define KSTART_TIME(time)     [NSString stringWithFormat:@"%@出发",time]

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
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, 0, KSCREEN_W-2*KEDGE_DISTANCE, PRODUCT_CELL_HEIGHT)];
    bgImg.image=KPULLIMG(@"tab_bg_boss0", 10, 0, 10, 0);
    [self.contentView addSubview:bgImg];
    
    //添加标题
    _titleLab=[self createLabWithFrame:CGRectMake(KEDGE_DISTANCE, KEDGE_DISTANCE, bgImg.width-100-KEDGE_DISTANCE, 25) andFont:[UIFont systemFontOfSize:20] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _titleLab.text=@"走近神秘的高棉";
    [bgImg addSubview:_titleLab];
    
    //添加推荐
    _recommendLab=[self createLabWithFrame:CGRectMake(bgImg.width-100-KEDGE_DISTANCE, KEDGE_DISTANCE+5, 100, 20) andFont:[UIFont systemFontOfSize:14] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _recommendLab.textAlignment=NSTextAlignmentRight;
    _recommendLab.text=@"600人推荐";
    [bgImg addSubview:_recommendLab];
    
    //添加风景图
    _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, _titleLab.bottom+5, bgImg.width, 135*KCOFFICIEMNT)];
    _headImage.image=[UIImage imageNamed:@"image_placeholder"];
    _headImage.contentMode=UIViewContentModeScaleAspectFill;
    _headImage.layer.masksToBounds=YES;
    [bgImg addSubview:_headImage];
    
    //添加旅行目的地
        //添加底部视图
        _destLayerImg=[[UIImageView alloc]initWithFrame:CGRectMake(-KEDGE_DISTANCE, _headImage.top+7, 50, 30)];
        _destLayerImg.image=KPULLIMG(@"xjj_fuc", 0, 10, 0, 10);
    _destLayerImg.alpha=0.7;
        [bgImg  addSubview:_destLayerImg];
        //添加✈️
        UIImageView *planeImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,_headImage.top+15, 18, 17)];
        planeImg.image=[UIImage imageNamed:@"btn_p"];
        [bgImg addSubview:planeImg];
        //添加目的地
        _destLab=[self createLabWithFrame:CGRectMake(20, _headImage.top+9, 0, 29) andFont:[UIFont boldSystemFontOfSize:20] andTitleColor:[UIColor whiteColor]];
        [bgImg addSubview:_destLab];
    
    
    //添加头像
    UIView *iconBgView=[[UIView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, _headImage.bottom-KEDGE_DISTANCE, 82, 82)];
    iconBgView.layer.cornerRadius=KCORNERRADIUS;
    iconBgView.layer.masksToBounds=YES;
    iconBgView.backgroundColor=[UIColor colorWithRed:170/255 green:170/255 blue:170/255 alpha:0.2];
    
    [bgImg addSubview:iconBgView];
    
    _iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(4, 4, 74, 74)];
    _iconImage.layer.cornerRadius=3;
    _iconImage.layer.masksToBounds=YES;
    _iconImage.backgroundColor=[UIColor yellowColor];
    [iconBgView addSubview:_iconImage];
    
    //添加姓名
    _nameLab=[self createLabWithFrame:CGRectMake(iconBgView.right+ KEDGE_DISTANCE-4, _headImage.bottom+KEDGE_DISTANCE, 50, 20)  andFont:[UIFont systemFontOfSize:17] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _nameLab.text=@"杨大";
    [bgImg addSubview:_nameLab];
    
    //添加性别
    _sexImg=[[UIImageView alloc]initWithFrame:CGRectMake(_nameLab.right+3, _nameLab.top, 20, 20)];
    _sexImg.image=[UIImage imageNamed:@"btn_sex_fem"];
    [bgImg addSubview:_sexImg];
    
    //添加vip
    _vipImg=[[UIImageView alloc]initWithFrame:CGRectMake(_sexImg.right+3, _nameLab.top+2, 16, 16)];
    _vipImg.image=[UIImage imageNamed:@"icon_id"];
    [bgImg addSubview:_vipImg];
    
    //添加距离
    _destenceLab=[self createLabWithFrame:CGRectMake(bgImg.width-80-KEDGE_DISTANCE, _nameLab.top, 80, 20) andFont:[UIFont systemFontOfSize:13] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _destenceLab.textAlignment=NSTextAlignmentRight;
    _destenceLab.text=@"距离1.2km";
    [bgImg addSubview:_destenceLab];
    
    //添加职业
    _jobLab=[self createLabWithFrame:CGRectMake(_nameLab.left, _nameLab.bottom+3, bgImg.width-_nameLab.left-KEDGE_DISTANCE, 15) andFont:[UIFont systemFontOfSize:13] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _jobLab.text=@"建筑师";
    [bgImg addSubview:_jobLab];
    
    //添加个人基础信息
    _infoLab=[self createLabWithFrame:CGRectMake(_nameLab.left, _jobLab.bottom+3, bgImg.width-_nameLab.left-KEDGE_DISTANCE, 15) andFont:[UIFont systemFontOfSize:13] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _infoLab.text=@"30岁  处女座  45kg  172cm  单身";
    [bgImg addSubview:_infoLab];
    
    //添加预筹资金
    _moneyLab=[self createLabWithFrame:CGRectMake(KEDGE_DISTANCE, iconBgView.bottom+KEDGE_DISTANCE-4, bgImg.width/2-KEDGE_DISTANCE, 15) andFont:[UIFont boldSystemFontOfSize:14] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _moneyLab.text=@"预筹¥5000";
    [bgImg addSubview:_moneyLab];
    
    //添加出发时间
    _startLab=[self createLabWithFrame:CGRectMake(_moneyLab.right, _moneyLab.top, bgImg.width/2-KEDGE_DISTANCE, 15) andFont:[UIFont boldSystemFontOfSize:14] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _startLab.textAlignment=NSTextAlignmentRight;
    _startLab.text=@"2016/03出发";
    [bgImg addSubview:_startLab];
    
    //添加进度条
    _emptyProgress=[[UIImageView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, _moneyLab.bottom+5, bgImg.width-2*KEDGE_DISTANCE, 5)];
    _emptyProgress.image=[UIImage imageNamed:@"bg_jdt"];
    [bgImg addSubview:_emptyProgress];
    
    _fillProgress=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 5)];
    _fillProgress.image=KPULLIMG(@"jdt_up", 0, 5, 0, 5);
    [_emptyProgress addSubview:_fillProgress];
    
    //添加众筹进度相关数据
     NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZCInfoView" owner:nil options:nil];
    _zcInfoView=[nibView objectAtIndex:0];
    _zcInfoView.frame=CGRectMake(1, _emptyProgress.bottom+5, bgImg.width-2, 40);
    [bgImg addSubview:_zcInfoView];
}

#pragma mark --- 众筹列表单数据
-(void)setOneModel:(ZCOneModel *)oneModel
{
     _oneModel = oneModel;
    _vipImg.hidden=YES;
    _destenceLab.hidden=YES;
    //标题
    _titleLab.text=oneModel.product.productName;
    //风景图
    [_headImage sd_setImageWithURL:[NSURL URLWithString:oneModel.product.headImage]  placeholderImage:[UIImage imageNamed:@"abc"]];
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
    CGFloat placeStrWidth=[ZYZCTool calculateStrLengthByText:place andFont:_destLab.font andMaxWidth:KSCREEN_W].width;
    //改变目的地展示标签的长度
    _destLab.width=placeStrWidth;
    _destLab.text=place;
    //改变目的地背景条长度
    _destLayerImg.width=placeStrWidth+40;
    
    //用户图像
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:oneModel.user.faceImg] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    
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
    //改变名字标签长
    _nameLab.width=nameStrWidth;
    //改变性别图标位置
    _sexImg.left=_nameLab.right;
    //获取性别图标
    if ([oneModel.user.sex isEqualToString:@"1"]) {
        _sexImg.image=[UIImage imageNamed:@"btn_sex_mal"];
    }
    else if ([oneModel.user.sex isEqualToString:@"2"])
    {
        _sexImg.image=[UIImage imageNamed:@"btn_sex_fem"];
    }
    
    //改变VIP图标位置
    _vipImg.left=_sexImg.right+3;
    
    //职位
    _jobLab.text=oneModel.user.title;
    
    //个人信息
    NSMutableString *userInfo=[NSMutableString string];
        //添加年龄
        NSDate *nowDate=[NSDate date];
        int age=0;
        if (oneModel.user.birthday.length) {
            NSDate *brithDay=[NSDate dateFromString:[self changStrToDateStr:oneModel.user.birthday]];
            int days=[NSDate getDayNumbertoDay:nowDate beforDay:brithDay]+1;
            age=days/365;
            [userInfo appendString:[NSString stringWithFormat:@"%d",age]];
        }
        //添加星座
        if (oneModel.user.constellation.length) {
            if (userInfo.length) {
                [userInfo appendString:[NSString stringWithFormat:@"  %@",oneModel.user.constellation]];
            }
            else
            {
                [userInfo appendString:[NSString stringWithFormat:@"%@",oneModel.user.constellation]];
            }
        }
        //添加体重
        if (oneModel.user.weight) {
            if (userInfo.length) {
                [userInfo appendString:[NSString stringWithFormat:@"  %@",oneModel.user.weight]];
            }
            else
            {
                [userInfo appendString:[NSString stringWithFormat:@"%@",oneModel.user.weight]];
            }
        }
        //添加身高
        if (oneModel.user.height) {
            if (userInfo.length) {
                [userInfo appendString:[NSString stringWithFormat:@"  %@",oneModel.user.height]];
            }
            else
            {
                [userInfo appendString:[NSString stringWithFormat:@"%@",oneModel.user.height]];
            }
        }
        //添加婚姻状态
        if (oneModel.user.maritalStatus) {
            NSArray *maritals=@[@"单身",@"已婚",@"离异"];
            int state=[oneModel.user.maritalStatus intValue];
            if (userInfo.length) {
                [userInfo appendString:[NSString stringWithFormat:@"  %@",maritals[state]]];
            }
            else
            {
                [userInfo appendString:[NSString stringWithFormat:@"%@",maritals[state]]];
            }
        }
    _infoLab.text=userInfo;
    
    //预筹资金
    CGFloat raiseMoney=[oneModel.product.productPrice floatValue]/100.0;
    _moneyLab.attributedText=[self changeTextFontAndColorByString:KRAISE_MONEY(raiseMoney) andChangeRange:NSMakeRange(0, 2)];
    
    //出发日期
    NSString *startStr=KSTART_TIME(oneModel.product.travelstartTime);
    _startLab.attributedText=[self changeTextFontAndColorByString:startStr andChangeRange:NSMakeRange(startStr.length-2, 2)];
    
    //已筹资金
    _zcInfoView.moneyLab.text=[NSString stringWithFormat:@"¥%@",oneModel.spellbuyproduct.spellRealBuyPrice];
    //众筹进度
    CGFloat rate=[oneModel.spellbuyproduct.spellRealBuyPrice floatValue]/raiseMoney;
     _zcInfoView.rateLab.text=[NSString stringWithFormat:@"%.f％",rate];
    //进度条更新
    _fillProgress.width=_emptyProgress.width*rate;
    //剩余天数
    NSString *productEndStr=[self changStrToDateStr:oneModel.product.productEndTime];
    NSDate *productEndDate=[NSDate dateFromString:productEndStr];
    int leftDays=[NSDate getDayNumbertoDay:nowDate beforDay:productEndDate]+1;
    _zcInfoView.leftDayLab.text=[NSString stringWithFormat:@"%d",leftDays];
    
}

#pragma mark --- 创建lab
-(UILabel *)createLabWithFrame:(CGRect )frame andFont:(UIFont *)font andTitleColor:(UIColor *)color
{
    UILabel *lab=[[UILabel alloc]initWithFrame:frame];
    lab.font=font;
    lab.textColor=color;
    return lab;
}

#pragma mark --- 将2016-1-1格式转成2016-01－01
-(NSString *)changStrToDateStr:(NSString *)string
{
    NSMutableArray *subArr=[NSMutableArray arrayWithArray:[string componentsSeparatedByString:@"-"]];
    for (int i=0;i<subArr.count;i++) {
        NSString *str=subArr[i];
        if (str.length<2) {
            NSString *newStr=[NSString stringWithFormat:@"0%@",str];
            [subArr replaceObjectAtIndex:i withObject:newStr];
        }
    }
    return [subArr componentsJoinedByString:@"-"];
}


#pragma mark --- 字符串的字体更改
-(NSMutableAttributedString *)changeTextFontAndColorByString:(NSString *)str andChangeRange:(NSRange )range
{
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:str];
    if (str.length) {
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor ZYZC_TextGrayColor] range:range];
    }
    return  attrStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
