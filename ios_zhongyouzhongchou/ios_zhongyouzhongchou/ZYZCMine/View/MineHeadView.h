//
//  MineHeadView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineUserModel;
@interface MineHeadView : UIImageView
/**
 *  头像
 */
@property (nonatomic, weak) UIButton *iconButton;
/**
 *  名字
 */
@property (nonatomic, weak) UIButton *nameLabel;


@property (nonatomic, strong) MineUserModel *userModel;
@end
