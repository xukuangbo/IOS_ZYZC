//
//  MineMessageCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineMessageCell.h"
#import "MineMessageModel.h"
#import "UIView+GetSuperTableView.h"
@interface MineMessageCell()

@property (nonatomic, weak) UIView *mapView;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  消息数目
 */
@property (nonatomic, weak) UILabel *numberLabel;
/**
 *  名字
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  描述内容
 */
@property (nonatomic, weak) UILabel *descLabel;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  删除按钮
 */
@property (nonatomic, weak) UIButton *deletebutton;
/**
 *  位置滑动的flag
 */
@property (nonatomic, assign) NSInteger swipeflag;
@end

@implementation MineMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor ZYZC_BgGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加一个左滑的手势
        UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
         [leftSwipeGesture setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self.contentView addGestureRecognizer:leftSwipeGesture];
         //添加一个右滑的手势
        UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [rightSwipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self.contentView addGestureRecognizer:rightSwipeGesture];
        
        //这里写创建的代码,固定高度的cell，所以位置可以直接写
        CGFloat mapViewX = MineMessageCellMargin;
        CGFloat mapViewY = 5;
        CGFloat mapViewW = KSCREEN_W - MineMessageCellMargin * 2;
        CGFloat mapViewH = MineMessageCellHeight - 5 * 2;
        UIView * mapView = [[UIView alloc] initWithFrame:CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH)];
//        mapView.backgroundColor = [UIColor redColor];
        mapView.layer.cornerRadius = MineMessageCellCornerRadius;
        mapView.layer.masksToBounds = YES;
        [self.contentView addSubview:mapView];
        mapView.backgroundColor = [UIColor whiteColor];
        self.mapView = mapView;
        
        //头像
        CGFloat iconViewX = MineMessageCellMargin;
        CGFloat iconViewY = MineMessageCellMargin;
        CGFloat iconViewWH = mapView.height - MineMessageCellMargin * 2;
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH)];
//        iconView.backgroundColor = [UIColor blueColor];
        iconView.layer.cornerRadius = MineMessageCellCornerRadius;
        iconView.layer.masksToBounds = YES;
        [self.mapView addSubview:iconView];
        self.iconView = iconView;
        
        //新消息红点点
        CGFloat numberLabelWH = 16;
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.size = CGSizeMake(numberLabelWH, numberLabelWH);
        numberLabel.center = CGPointMake(iconView.right, iconView.top + numberLabelWH * 0.5);
        numberLabel.backgroundColor = [UIColor colorWithRed:228/256.0 green:84/256.0 blue:23/256.0 alpha:1];
        numberLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:MineMessageCellNumberLabelFont];
        numberLabel.layer.cornerRadius = numberLabelWH * 0.5;
        numberLabel.layer.masksToBounds = YES;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
//        numberLabel.text = @"22";
        [self.mapView addSubview:numberLabel];
        self.numberLabel = numberLabel;
        
        //名字
        CGFloat nameLabelX = iconView.right + 25;
        CGFloat nameLabelY = 23;
        CGFloat nameLabelW = 100;
        CGFloat nameLabelH = 20;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
        
//        nameLabel.backgroundColor = [UIColor blueColor];
        [self.mapView addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:MineMessageCellNameberLabelFont];
        nameLabel.text = @"名字呢";
        self.nameLabel = nameLabel;
        
        //描述内容
        CGFloat descLabelX = nameLabel.left;
        CGFloat descLabelY = nameLabel.bottom;
        CGFloat descLabelW = nameLabelW * 1.5;
        CGFloat descLabelH = 20;
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descLabelX, descLabelY, descLabelW, descLabelH)];
        descLabel.font = [UIFont systemFontOfSize:MineMessageCellNameberLabelFont];
        descLabel.textColor = [UIColor ZYZC_TextGrayColor];
//        descLabel.backgroundColor =[UIColor redColor];
        descLabel.text = @"这是一个很牛逼的应用";
        [self.mapView addSubview:descLabel];
        self.descLabel = descLabel;
        
        //时间内容
        
        CGFloat timeLabelW = 120;
        CGFloat timeLabelH = 20;
        CGFloat timeLabelX = mapViewW - MineMessageCellMargin - timeLabelW;
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, 0, timeLabelW, timeLabelH)];
        timeLabel.centerY = self.mapView.height * 0.5;
        [self.mapView addSubview:timeLabel];
        timeLabel.textAlignment = NSTextAlignmentRight;
//        timeLabel.text = @"2010101123";
        self.timeLabel = timeLabel;
        
        //需要再添加一个删除的按钮
        CGFloat deletebuttonW = 80;
        CGFloat deletebuttonH = 50;
        CGFloat deletebuttonX = KSCREEN_W;
        UIButton *deletebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        deletebutton.frame = CGRectMake(deletebuttonX, 0, deletebuttonW, deletebuttonH);
        deletebutton.centerY = MineMessageCellHeight * 0.5;
        [deletebutton setTitle:@"删除" forState:UIControlStateNormal];
        deletebutton.layer.cornerRadius = 10;
        deletebutton.layer.masksToBounds = YES;
        deletebutton.backgroundColor = [UIColor colorWithRed:228/256.0 green:84/256.0 blue:23/256.0 alpha:1];
        [deletebutton addTarget:self action:@selector(deletebuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deletebutton];
        self.deletebutton = deletebutton;
        
    }
    return self;
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        //先进行一次位置的判断,如果位置==1，返回
        if (self.swipeflag == 1) return;
        
        __weak typeof(&*self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.mapView.left -= weakSelf.deletebutton.width + MineMessageCellMargin;
            weakSelf.deletebutton.left -= weakSelf.deletebutton.width + MineMessageCellMargin;
            weakSelf.swipeflag = 1;
        }];
        
        //执行程序
    }else if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        //先进行一次位置的判断,如果位置==1，返回
        if (self.swipeflag == 0) return;
        __weak typeof(&*self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.mapView.left += weakSelf.deletebutton.width + MineMessageCellMargin;
            weakSelf.deletebutton.left += weakSelf.deletebutton.width + MineMessageCellMargin;
            weakSelf.swipeflag = 0;
        }];
    }

}

- (void)setModel:(MineMessageModel *)model
{
    if (_model != model) {
        _model = model;
        //头像
        SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconString] placeholderImage:nil options:options];
        //消息数量
        if (model.newMessageCount > 0) {
            self.numberLabel.hidden = NO;
            self.numberLabel.text = [NSString stringWithFormat:@"%zd",model.newMessageCount];
        }else{
            self.numberLabel.hidden = YES;
            self.numberLabel.text = @"";
        }
        //名字
        self.nameLabel.text = model.name;
        //描述
        self.descLabel.text = model.descString;
        //时间
        self.timeLabel.text = model.time;
        
        
    }
}

- (void)deletebuttonAction:(UIButton *)button
{
    
//    交给tableView去做
    if ([self.delegate respondsToSelector:@selector(mineMessageCellDelegate:)]) {
        [self.delegate mineMessageCellDelegate:button];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
