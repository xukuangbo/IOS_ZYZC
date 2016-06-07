//
//  MineOneItemCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/7.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineOneItemCell.h"
@interface MineOneItemCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLab;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIImageView *dotView;
@property (nonatomic, strong) UIView      *lineView;
@end

@implementation MineOneItemCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    _iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,(ONE_ITEM_CELL_HEIGHT-20)/2 , 20, 20)];
    [self.contentView addSubview:_iconImageView];
    
    _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.right+KEDGE_DISTANCE, (ONE_ITEM_CELL_HEIGHT-30)/2, 200, 30)];
    _titleLab.font=[UIFont systemFontOfSize:17];
    _titleLab.textColor=[UIColor ZYZC_TextBlackColor];
    [self.contentView addSubview:_titleLab];
    
    _arrowImage=[[UIImageView alloc]initWithFrame:CGRectMake(KSCREEN_W-4*KEDGE_DISTANCE-10, (ONE_ITEM_CELL_HEIGHT-16)/2, 10, 16)];
    _arrowImage.image=[UIImage imageNamed:@"btn_rightin"];
    [self.contentView addSubview:_arrowImage];
    
    _dotView=[[UIImageView alloc]initWithFrame:CGRectMake(_arrowImage.left-KEDGE_DISTANCE, _arrowImage.top-5, 5, 5)];
    _dotView.layer.cornerRadius=2.5;
    _dotView.layer.masksToBounds=YES;
    _dotView.backgroundColor=[UIColor redColor];
    _dotView.hidden=YES;
    [self .contentView addSubview:_dotView];
    
    _lineView=[UIView lineViewWithFrame:CGRectMake(0,ONE_ITEM_CELL_HEIGHT-1 , KSCREEN_W-4*KEDGE_DISTANCE, 1) andColor:nil];
    [self.contentView addSubview:_lineView];

}

-(void)setItemModel:(MineOneItemModel *)itemModel
{
    _iconImageView.image=[UIImage imageNamed:itemModel.iconImg];
    _titleLab.text=itemModel.title;
}

-(void)setShowDot:(BOOL)showDot
{
    _showDot=showDot;
    _dotView.hidden=!showDot;
}

-(void)setHiddenLine:(BOOL)hiddenLine
{
    _hiddenLine=hiddenLine;
    _lineView.hidden=hiddenLine;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
