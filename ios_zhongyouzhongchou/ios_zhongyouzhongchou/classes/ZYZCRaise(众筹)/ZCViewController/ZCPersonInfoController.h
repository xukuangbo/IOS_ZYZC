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
    WantToType=KZCDETAIL_ATTITUDETYPE,
    SupportType,
    ShareType
};

@interface ZCPersonInfoController : ZYZCBaseViewController

@property (nonatomic, copy  ) NSNumber *productId;

@property (nonatomic, strong) ZCOneModel *oneModel;

@end
