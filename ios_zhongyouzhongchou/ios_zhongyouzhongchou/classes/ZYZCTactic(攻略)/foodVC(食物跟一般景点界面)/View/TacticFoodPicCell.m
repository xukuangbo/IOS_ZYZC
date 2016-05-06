//
//  TacticFoodPicCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticFoodPicCell.h"

@implementation TacticFoodPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor redColor];
        [self configUI];
    }
    return self;
}
- (void)configUI
{
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, imageViewHeight)];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
}

@end
