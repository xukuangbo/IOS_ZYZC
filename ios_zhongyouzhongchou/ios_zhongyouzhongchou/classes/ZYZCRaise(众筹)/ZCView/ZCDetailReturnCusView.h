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
@property (nonatomic, strong) UILabel  *titleLab;
@property (nonatomic, strong) UILabel  *textLab;
@property (nonatomic, strong) UIButton *moreTextBtn;
@property (nonatomic, strong) UILabel  *hasSupportPeopleLab;
@property (nonatomic, strong) UILabel  *limitPeopleLab;
@property (nonatomic, strong) UIView  *peopleIconsView;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, assign) CGFloat  textNormalHeight;
@property (nonatomic, assign) CGFloat  textOpenHeight;
@property (nonatomic, assign) NSInteger supportNumber;
@property (nonatomic, assign) NSInteger limitNumber;
@property (nonatomic, assign) BOOL     isOpenText;
@property (nonatomic, strong) ZCTotalPeopleView *totalPeopleView;

- (instancetype)initSupportViewByTop:(CGFloat   )top
                            andTitle:(NSString *)title
                             andText:(NSString *)text
                      andSupportType:(SupportMoneyType )supportType;



@end
