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
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W-2*KEDGE_DISTANCE, CELL_HEIGHT)];
    bgImg.image=KPULLIMG(@"tab_bg_boss0", 10, 0, 10, 0);
    [self.contentView addSubview:bgImg];
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
