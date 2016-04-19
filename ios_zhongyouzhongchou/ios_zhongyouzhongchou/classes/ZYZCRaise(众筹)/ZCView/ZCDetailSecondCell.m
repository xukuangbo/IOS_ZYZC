//
//  ZCDetailSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/19.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailSecondCell.h"

@implementation ZCDetailSecondCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    
}

@end
