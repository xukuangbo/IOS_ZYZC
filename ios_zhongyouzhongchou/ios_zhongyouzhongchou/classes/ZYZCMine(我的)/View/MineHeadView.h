//
//  MineHeadView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMineChangeButtonNormalColor [UIColor colorWithRed:161 / 255.0 green:152 / 255.0 blue:111 / 255.0 alpha:1.0]
@class MineUserModel;
typedef void (^HeadChangeBlock)();
@interface MineHeadView : UIImageView

/**
 *  登陆头像
 */
@property (nonatomic, weak) UIButton *loginButton;
/**
 *  头像
 */
@property (nonatomic, weak) UIButton *iconButton;
/**
 *  名字
 */
@property (nonatomic, weak) UIButton *nameLabel;
/**
 *  性别
 */
@property (nonatomic, weak) UIImageView *sexView;
/**
 *  认证用户
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  职业描述
 */
@property (nonatomic, weak) UILabel *professionLabel;

/**
 *  我的中心
 */
@property (nonatomic, weak) UIButton *myCenterButton;
/**
 *  我的中心
 */
@property (nonatomic, weak) UIButton *myFootButton;
/**
 *  个人描述
 */
@property (nonatomic, weak) UILabel *descLabel;


@property (nonatomic, strong) MineUserModel *userModel;

@property (nonatomic, copy) HeadChangeBlock headChangeBlock;
@end
