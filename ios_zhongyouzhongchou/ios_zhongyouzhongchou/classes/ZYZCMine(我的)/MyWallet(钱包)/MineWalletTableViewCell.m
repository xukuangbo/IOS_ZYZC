//
//  MineWalletTableViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineWalletTableViewCell.h"
#import "MineWalletModel.h"
@interface MineWalletTableViewCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *totalMoneyLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *mapView;
@end
@implementation MineWalletTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //需要5个控件
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        //容器
        CGFloat mapViewX = KEDGE_DISTANCE;
        CGFloat mapViewY = KEDGE_DISTANCE;
        CGFloat mapViewW = KSCREEN_W - 2 * mapViewX;
        CGFloat mapViewH = WalletCellRowHeight - 2 * mapViewY;
        _mapView = [[UIImageView alloc] initWithFrame:CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH)];
        _mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
        [self.contentView addSubview:_mapView];
        
        //头像
        CGFloat iconViewX = KEDGE_DISTANCE;
        CGFloat iconViewY = KEDGE_DISTANCE;
        CGFloat iconViewW = 100;
        CGFloat iconViewH = mapViewH - 2 * iconViewY;
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH)];
        _iconView.layer.cornerRadius = 5;
        _iconView.layer.masksToBounds = YES;
        [_mapView addSubview:_iconView];
        
        //金钱
        CGFloat totalMoneyLabelX = _iconView.right + KEDGE_DISTANCE;
        CGFloat totalMoneyLabelY = _iconView.top;
        CGFloat totalMoneyLabelW = 50;
        CGFloat totalMoneyLabelH = 15;
        _totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalMoneyLabelX, totalMoneyLabelY, totalMoneyLabelW, totalMoneyLabelH)];
        _totalMoneyLabel.textColor = [UIColor redColor];
        _totalMoneyLabel.font = [UIFont systemFontOfSize:13];
        [_mapView addSubview:_totalMoneyLabel];
        
        //姓名
        CGFloat nameLabelX = totalMoneyLabelX;
        CGFloat nameLabelY = _totalMoneyLabel.bottom + 5;
        CGFloat nameLabelW = 50;
        CGFloat nameLabelH = 15;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [_mapView addSubview:_nameLabel];
        
        //时间
        CGFloat timeLabelW = 100;
        CGFloat timeLabelH = 20;
        CGFloat timeLabelX = mapViewW - timeLabelW - KEDGE_DISTANCE;
        CGFloat timeLabelY = mapViewH * 0.5 - timeLabelH * 0.5;
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_mapView addSubview:_timeLabel];
        
        //说明
        CGFloat descLabelW = 200;
        CGFloat descLabelH = 15;
        CGFloat descLabelX = totalMoneyLabelX;
        CGFloat descLabelY = mapViewH - KEDGE_DISTANCE - descLabelH;
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descLabelX, descLabelY, descLabelW, descLabelH)];
        _descLabel.textColor = [UIColor ZYZC_TextGrayColor];
        [_mapView addSubview:_descLabel];
    }
    return self;
}

- (void)setMineWalletModel:(MineWalletModel *)mineWalletModel
{
    _mineWalletModel = mineWalletModel;
    
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    
    if (mineWalletModel.projectImg.length > 0) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:mineWalletModel.projectImg] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
    }
    if (mineWalletModel.name.length > 0) {
        _nameLabel.text = mineWalletModel.name;
        _nameLabel.size = [ZYZCTool calculateStrLengthByText:_nameLabel.text andFont:_nameLabel.font andMaxWidth:MAXFLOAT];
    }
    if (mineWalletModel.totalMoney.length > 0) {
        _totalMoneyLabel.text = [NSString stringWithFormat:@"￥ %@元",mineWalletModel.totalMoney];
        _totalMoneyLabel.size = [ZYZCTool calculateStrLengthByText:_totalMoneyLabel.text andFont:_totalMoneyLabel.font andMaxWidth:MAXFLOAT];
    }
    if (mineWalletModel.drawMoneyTime.length > 0) {
        _timeLabel.text = mineWalletModel.drawMoneyTime;
        
    }
    if (mineWalletModel.projectName.length > 0) {
        _descLabel.text = [NSString stringWithFormat:@"\"%@\"提现",mineWalletModel.projectName];
        _descLabel.size = [ZYZCTool calculateStrLengthByText:_descLabel.text andFont:_descLabel.font andMaxWidth:MAXFLOAT];
    }
    
}
@end
