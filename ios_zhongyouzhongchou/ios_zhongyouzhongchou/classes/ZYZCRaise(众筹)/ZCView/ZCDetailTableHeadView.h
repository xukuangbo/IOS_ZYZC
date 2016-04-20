//
//  ZCDetailTableHeadView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZCDETAIL_SECONDSECTION_HEIGHT  53

typedef NS_ENUM(NSInteger, ZCDetailContentType)
{
    IntroType=KZCDETAIL_CONTENTTYPE,
    ArrangeType,
    ReturnType
};

typedef void(^ClickChangeContent)(ZCDetailContentType contentType);

@interface ZCDetailTableHeadView : UIView

@property (nonatomic, strong) UIButton *preClickBtn;

@property (nonatomic, copy ) ClickChangeContent clickChangeContent;

@end
