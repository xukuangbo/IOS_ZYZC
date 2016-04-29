//
//  ZCDetailReturnCusView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCDetailCustomButton.h"
#import "ZCTotalPeopleView.h"

typedef void (^OpenMoreText)(SupportMoneyType supportType);

@interface ZCDetailReturnCusView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UILabel  *titleLab;   //标题
@property (nonatomic, strong) UILabel  *textLab;    //玩法解释
@property (nonatomic, strong) UIButton *moreTextBtn;//展开更多人物按钮
@property (nonatomic, strong) UILabel  *hasSupportPeopleLab;//已支持人标签
@property (nonatomic, strong) UILabel  *limitPeopleLab;//人数限制标签
@property (nonatomic, strong) UIView   *peopleIconsView;//承载人物图像
@property (nonatomic, strong) UITextField *moneyTextField;//金额输入框
@property (nonatomic, strong) UIView   *WSMView;//承载文字、语音、视屏
@property (nonatomic, assign) CGFloat  textNormalHeight;//文字为展开高度
@property (nonatomic, assign) CGFloat  textOpenHeight;//文字展开高度
@property (nonatomic, assign) NSInteger supportNumber;//支持人数
@property (nonatomic, assign) NSInteger limitNumber;//限制人数
@property (nonatomic, assign) BOOL     isOpenText;//是否展开文字
@property (nonatomic, assign) BOOL     hasMovie;
@property (nonatomic, assign) BOOL     hasVoice;
@property (nonatomic, assign) BOOL     hasWord;
@property (nonatomic, strong) ZCTotalPeopleView *totalPeopleView;//展示所有已支持人

/**
 *  初始化方法
 *
 */
- (instancetype)initSupportViewByTop:(CGFloat   )top
                            andTitle:(NSString *)title
                             andText:(NSString *)text
                      andSupportType:(SupportMoneyType )supportType;



@end
