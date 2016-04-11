//
//  MineMessageCell.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MineMessageCellHeight 80
#define MineMessageCellMargin 10
#define MineMessageCellCornerRadius 5
#define MineMessageCellNumberLabelFont 10
#define MineMessageCellNameberLabelFont 13

@protocol MineMessageCellDelegate <NSObject>
/**
 *  删除button点击事件
 */
- (void)mineMessageCellDelegate:(UIButton *)button;
@end
@class MineMessageModel;
@interface MineMessageCell : UITableViewCell


@property (nonatomic, strong) MineMessageModel *model;


@property (nonatomic, weak) id<MineMessageCellDelegate> delegate;
@end
