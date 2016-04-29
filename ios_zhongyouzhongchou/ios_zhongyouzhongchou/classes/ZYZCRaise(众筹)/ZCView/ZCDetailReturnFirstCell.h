//
//  ZCDetailReturnFirstCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableViewCell.h"
#import "ZCDetailReturnFirstCellModel.h"
#import "ZCDetailReturnCusView.h"

@interface ZCDetailReturnFirstCell : MoreFZCBaseTableViewCell

@property (nonatomic, strong) ZCDetailReturnFirstCellModel *cellModel;

@property (nonatomic, strong) ZCDetailReturnCusView *supportOneYuanView;

@property (nonatomic, strong) ZCDetailReturnCusView *supportAnyYuanView;

@property (nonatomic, strong) ZCDetailReturnCusView *returnSupportView;

@property (nonatomic, strong) ZCDetailReturnCusView *togetherView;

@end
