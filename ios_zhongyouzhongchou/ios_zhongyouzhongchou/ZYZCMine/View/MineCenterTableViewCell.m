//
//  MineCenterTableViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineCenterTableViewCell.h"
#import "UIView+GetSuperTableView.h"
#import "MineCenterTableView.h"
@implementation MineCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像图
        UIImageView *iconView = [[UIImageView alloc] init];
//        iconView.image = [UIImage imageNamed:@"icn_bag"];
        iconView.frame = CGRectMake(KEDGE_DISTANCE, 0, 18, 18);
        iconView.centerY = centerCellRowHeight * 0.5;
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        //文字图
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right + KEDGE_DISTANCE, 0, 200, 20)];
        titleLabel.centerY = centerCellRowHeight * 0.5;
//        titleLabel.text = @"我的钱包";
        titleLabel.textColor = [UIColor ZYZC_TextGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        //打卡
        UIButton *playCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        playCardBtn.size = CGSizeMake(80, 30);
//        playCardBtn.top = KEDGE_DISTANCE;
        playCardBtn.centerY = centerCellRowHeight * 0.5;
        playCardBtn.right = KSCREEN_W - KEDGE_DISTANCE * 3;
        [playCardBtn setBackgroundImage:[UIImage imageNamed:@"bg_daka"] forState:UIControlStateNormal];
        playCardBtn.hidden = YES;
        [playCardBtn setTitle:@"打卡" forState:UIControlStateNormal];
        [self.contentView addSubview:playCardBtn];
        self.playCardBtn = playCardBtn;
//        btn_rightin
        UIImageView *rightTin = [[UIImageView alloc] init];
        rightTin.size = CGSizeMake(10, 20);
        rightTin.centerY = centerCellRowHeight * 0.5;
        rightTin.right = KSCREEN_W - KEDGE_DISTANCE * 3;
        rightTin.image = [UIImage imageNamed:@"btn_rightin"];
        [self.contentView insertSubview:rightTin belowSubview:playCardBtn];
        self.rightTin = rightTin;
        
        //红色点点
        
        
    }
    return self;
}



@end
