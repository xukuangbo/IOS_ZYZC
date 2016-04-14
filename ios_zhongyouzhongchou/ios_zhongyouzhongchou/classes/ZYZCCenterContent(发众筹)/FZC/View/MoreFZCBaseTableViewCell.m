//
//  MoreFZCBaseTableViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableViewCell.h"

@implementation MoreFZCBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return  self;
}

/**
 *  将视图创建在此方法中
 */
-(void)configUI
{
    //定义cell的风格
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor= [UIColor ZYZC_BgGrayColor];
    //创建背景卡片
    _bgImg=[[UIImageView alloc]init];
    _bgImg.frame=CGRectMake(KEDGE_DISTANCE, 0, KSCREEN_W-20, self.contentView.height);
    _bgImg.image=KPULLIMG(@"tab_bg_boss0", 10, 0, 10, 0);
    _bgImg.userInteractionEnabled=YES;
    [self.contentView addSubview:_bgImg];
    //创建标题
    _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, 15, KSCREEN_W-40, 20)];
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.textColor=[UIColor ZYZC_TextBlackColor];
    [_bgImg addSubview:_titleLab];
    //创建灰线条
    _topLineView=[UIView lineViewWithFrame:CGRectMake(KEDGE_DISTANCE, CGRectGetMaxY(_titleLab.frame)+10, KSCREEN_W-4*KEDGE_DISTANCE, 1) andColor:nil];
    [_bgImg addSubview:_topLineView];
}

/**
 *  创建下面带有一条灰线的Lab
 *
 */
-(UILabel *)createLabAndUnderlineWithFrame:(CGRect )frame andTitle:(NSString *)title
{
    UILabel *lab=[[UILabel alloc]initWithFrame:frame];
    lab.font=[UIFont systemFontOfSize:15];
    lab.textColor=[UIColor ZYZC_TextBlackColor];
    lab.text=title;
    
    [lab addSubview:[UIView lineViewWithFrame:CGRectMake(0, lab.height+10, KSCREEN_W-4*KEDGE_DISTANCE, 1) andColor:nil]];
    return lab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
