//
//  ZCPersonInfoController.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCBaseViewController.h"

#import "ZCOneProductCell.h"

@interface ZCPersonInfoController : ZYZCBaseViewController

@property (nonatomic, copy  ) NSNumber *productId;

@property (nonatomic, strong) ZCOneModel *oneModel;

@property (nonatomic, assign) ZC_TYPE zcType;       //标记：区分访客版和个人版

@property (nonatomic, assign) BOOL  paySupportMoney;//标记：跳转到支持／付款
@end
