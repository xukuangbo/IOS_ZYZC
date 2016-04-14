//
//  MoreFZCRaiseMoneyTableView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableView.h"
#import "MoreFZCRaiseMoneyFirstCell.h"
#import "RaiseMoneyFirstModel.h"
#import "MoreFZCRaiseMoneySecondCell.h"
@interface MoreFZCRaiseMoneyTableView : MoreFZCBaseTableView<UITableViewDataSource,UITableViewDelegate>

/**
 *  定义个数组来接受openHeight
 */
@property (nonatomic, strong) NSMutableArray *realHeightArray;

@property (nonatomic, strong) RaiseMoneyFirstModel *firstModel;
@end
