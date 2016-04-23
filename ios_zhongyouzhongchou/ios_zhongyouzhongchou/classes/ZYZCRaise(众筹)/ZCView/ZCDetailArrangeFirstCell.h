//
//  ZCDetailArrangeFirstCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/23.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailIntroFirstCell.h"
#import "MoreFZCTravelOneDayDetailMdel.h"
@interface ZCDetailArrangeFirstCell : ZCDetailIntroFirstCell

@property (nonatomic, strong) MoreFZCTravelOneDayDetailMdel *oneDaydetailModel;

@property (nonatomic, assign) BOOL hasSight;//景点

@property (nonatomic, assign) BOOL hasTrans; //交通

@property (nonatomic, assign) BOOL hasLive; //住宿

@property (nonatomic, assign) BOOL hasEat; //饮食

@end
