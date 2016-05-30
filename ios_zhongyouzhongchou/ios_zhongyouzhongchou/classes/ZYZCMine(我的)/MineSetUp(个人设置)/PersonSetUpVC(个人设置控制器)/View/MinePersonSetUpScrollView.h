//
//  MinePersonSetUpScrollView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MinePersonSetUpHeadView;
@class MinePersonSetUpModel;
@interface MinePersonSetUpScrollView : UIScrollView
@property (nonatomic, weak) MinePersonSetUpHeadView *headView;

/**
 *  姓名标题
 */
@property (nonatomic, weak) UILabel *nameTitle;

/**
 *  姓名点击输入框
 */
@property (nonatomic, weak) UITextField *nameTextField;
/**
 *  性别点击输入框
 */
@property (nonatomic, weak) UIButton *sexButton;
/**
 *  生日点击选择框
 */
@property (nonatomic, weak) UIButton *birthButton;
/**
 *  星座点击选择框
 */
@property (nonatomic, weak) UITextField *constellationButton;



/**
 *  兴趣标签选择框
 */
@property (nonatomic, weak) UIButton *likeButton;


/**
 *  婚姻状况选择框
 */
@property (nonatomic, weak) UIButton *marryButton;

/**
 *  省会点击选择框
 */
@property (nonatomic, weak) UIButton *proviceButton;
/**
 *  身高点击选择框
 */
@property (nonatomic, weak) UITextField *heightButton;
/**
 *  体重点击选择框
 */
@property (nonatomic, weak) UITextField *weightButton;



/**
 *  公司输入
 */
@property (nonatomic, weak) UITextField *companyButton;
/**
 *  职位输入
 */
@property (nonatomic, weak) UITextField *jobButton;
/**
 *  学校输入
 */
@property (nonatomic, weak) UITextField *schoolButton;
/**
 *  所在地输入
 */
@property (nonatomic, weak) UITextField *locationButton;


/**
 *  邮箱输入
 */
@property (nonatomic, weak) UITextField *emailButton;


@property (nonatomic, strong) MinePersonSetUpModel *minePersonSetUpModel;
@end
