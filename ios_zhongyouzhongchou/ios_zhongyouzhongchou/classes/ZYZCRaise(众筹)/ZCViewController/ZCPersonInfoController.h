//
//  ZCPersonInfoController.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//


#import "ZYZCBaseViewController.h"

#import "ZCOneProductCell.h"

#import "ZCDetailModel.h"

@interface ZCPersonInfoController : ZYZCBaseViewController

@property (nonatomic, copy  ) NSNumber         *productId;

@property (nonatomic, strong) ZCOneModel       *oneModel;

@property (nonatomic, strong) ZCDetailModel    *detailModel;

@property (nonatomic, strong) NSArray          *schedule;//行程安排（我的草稿）

@property (nonatomic, assign) ZC_TYPE zcType;       //标记：区分访客版和个人版

@end
