//
//  ZCPersonInfoController.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCBaseViewController.h"

#import "ZCOneProductCell.h"

typedef NS_ENUM(NSInteger, ZCDetailAttitudeType)
{
    CommentType=KZCDETAIL_ATTITUDETYPE,
    SupportType,
    RecommendType
};

@interface ZCPersonInfoController : ZYZCBaseViewController

@property (nonatomic, copy  ) NSNumber *productId;

@property (nonatomic, strong) ZCOneModel *oneModel;

@property (nonatomic, assign) BOOL  paySupportMoney;

@end
