//
//  ZCDetailBottomView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/23.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZCListModel.h"

typedef NS_ENUM(NSInteger, ZCBottomButtonType)
{
    CommentType=KZC_DETAIL_BOTTOM_TYPE,
    SupportType,
    RecommendType
};

typedef void (^CommentBlock)();

typedef void (^SupportBlock)();

@interface ZCDetailBottomView : UIView

@property (nonatomic, assign) ZC_TYPE zcType;       //标记：区分访客版和个人版

@property (nonatomic, copy  ) CommentBlock commentBlock;
@property (nonatomic, copy  ) SupportBlock supportBlock;

@end
