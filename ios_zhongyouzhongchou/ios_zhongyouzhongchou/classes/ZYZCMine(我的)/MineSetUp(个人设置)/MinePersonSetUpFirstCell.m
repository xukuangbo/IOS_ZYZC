//
//  MinePersonSetUpFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonSetUpFirstCell.h"

@implementation MinePersonSetUpFirstCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景白图
        CGFloat bgImageViewX = KEDGE_DISTANCE;
        CGFloat bgImageViewY = KEDGE_DISTANCE;
        CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
        CGFloat bgImageViewH = 0;
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
        [self.contentView addSubview:bgImageView];
        
        //标题
        CGFloat titleLabelX = 4;
        CGFloat titleLabelY = 4;
        CGFloat titleLabelW = KSCREEN_W - 2 * titleLabelX;
        CGFloat titleLabelH = 20;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
        titleLabel.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:titleLabel];
        
        bgImageView.backgroundColor = [UIColor yellowColor];
        bgImageView.height = titleLabelH + titleLabelY * 2;
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}


@end
