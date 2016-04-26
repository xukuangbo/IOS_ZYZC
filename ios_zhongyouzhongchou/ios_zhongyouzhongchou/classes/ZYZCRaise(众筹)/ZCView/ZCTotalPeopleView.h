//
//  ZCTotalPeopleView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/26.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SupportMoneyType)
{
    SuppurtOneYuan=KSUPPORTMONEY_TYPE,
    SuppurtAnyYuan,
    SuppurtReturnMoney,
    SuppurtTogetherMoney
    
};
typedef void (^BackToView)();

@interface ZCTotalPeopleView : UIView
@property (nonatomic, assign) SupportMoneyType supportType;
@property (nonatomic, copy  ) BackToView backToView;
- (instancetype)initWithFrame:(CGRect)frame andSupportType:(SupportMoneyType )supportType;


@end
