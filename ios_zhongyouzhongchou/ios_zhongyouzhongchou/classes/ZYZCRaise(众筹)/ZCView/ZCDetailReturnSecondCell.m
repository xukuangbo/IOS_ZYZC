//
//  ZCDetailReturnSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailReturnSecondCell.h"
#import "ZCDetailCustomButton.h"
@interface ZCDetailReturnSecondCell ()

@property (nonatomic, strong) ZCDetailCustomButton *iconBtn;
@property (nonatomic, strong) UILabel  *nameLab;
@property (nonatomic, strong) UIImageView *sexImg;
@property (nonatomic, strong) UIImageView *vipImg;
@property (nonatomic, strong) UILabel  *timeLab;
@property (nonatomic, strong) UILabel  *contentLab;

@end
@implementation ZCDetailReturnSecondCell

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
    self.titleLab.text=@"热门评论";
    self.bgImg.height=RETURN_SEC_CELL_HEIGHT;
    
    UIImageView *moreImg=[[UIImageView alloc]initWithFrame:CGRectMake(self.bgImg.width-14-KEDGE_DISTANCE, self.topLineView.top-7-KEDGE_DISTANCE, 14, 7)];
    moreImg.image=[UIImage imageNamed:@"btn_xxd"];
    [self.bgImg addSubview:moreImg];
    
    _iconBtn=[[ZCDetailCustomButton alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE,self.topLineView.bottom+KEDGE_DISTANCE, 60, 60)];
    [self.bgImg addSubview:_iconBtn];
    
    _nameLab=[self createLabWithFrame:CGRectMake(_iconBtn.right+KEDGE_DISTANCE, _iconBtn.top, 1, 20) andFont:[UIFont systemFontOfSize:18] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    [self.bgImg addSubview:_nameLab];
    
    _sexImg=[[UIImageView alloc]initWithFrame:CGRectMake(_nameLab.right+3, _iconBtn.top, 20, 20)];
    _sexImg.image=[UIImage imageNamed:@"btn_sex_fem"];
    [self.bgImg addSubview:_sexImg];
    
    _vipImg=[[UIImageView alloc]initWithFrame:CGRectMake(_sexImg.right+3, _iconBtn.top+2, 16, 16)];
    _vipImg.image=[UIImage imageNamed:@"icon_id"];
    _vipImg.hidden=YES;
    [self.bgImg addSubview:_vipImg];
    
    _timeLab=[self createLabWithFrame:CGRectMake(self.bgImg.width-KEDGE_DISTANCE-120, _iconBtn.top, 120, 20) andFont:[UIFont systemFontOfSize:14] andTitleColor:[UIColor ZYZC_TextGrayColor]];
    _timeLab.textAlignment=NSTextAlignmentRight;
    [self.bgImg addSubview:_timeLab];
    
    _contentLab= [self createLabWithFrame:CGRectMake(_iconBtn.right+KEDGE_DISTANCE, _nameLab.bottom+KEDGE_DISTANCE, self.bgImg.width-_iconBtn.right-2*KEDGE_DISTANCE, 20) andFont:[UIFont systemFontOfSize:15] andTitleColor:[UIColor ZYZC_TextBlackColor]];
    _contentLab.numberOfLines=0;
    [self.bgImg addSubview:_contentLab];
}

-(void)setCommentModel:(ZCCommentModel *)commentModel
{
    _commentModel=commentModel;
    [_iconBtn sd_setImageWithURL:[NSURL URLWithString:commentModel.user.faceImg] forState:UIControlStateNormal];
    //计算名字的文字长度
    NSString *name=commentModel.user.userName;
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
    if ([commentModel.user.sex isEqualToString:@"1"]) {
        _sexImg.image=[UIImage imageNamed:@"btn_sex_mal"];
    }
    else if ([commentModel.user.sex isEqualToString:@"2"])
    {
        _sexImg.image=[UIImage imageNamed:@"btn_sex_fem"];
    }
    
    //改变VIP图标位置
    _vipImg.left=_sexImg.right+2;
    
    _timeLab.text=[ZYZCTool turnTimeStampToDate:commentModel.comment.timestamp];
    
    //计算content内容
    NSString *content= commentModel.comment.content;
    CGSize contentSize=[ZYZCTool calculateStrLengthByText:content andFont:_contentLab.font andMaxWidth:_contentLab.width];
    _contentLab.height=contentSize.height;
    _contentLab.text=content;
    
    CGFloat height01=_iconBtn.bottom +KEDGE_DISTANCE;
    CGFloat height02=_contentLab.bottom+KEDGE_DISTANCE;
    
    _commentModel.cellHeight=height01>height02?height01:height02;
    self.bgImg.height=_commentModel.cellHeight;
}

-(UILabel *)createLabWithFrame:(CGRect )frame andFont:(UIFont *)font andTitleColor:(UIColor *)color
{
    UILabel *lab=[[UILabel alloc]initWithFrame:frame];
    lab.font=font;
    lab.textColor=color;
    return lab;
}


@end














