//
//  MoreFZCReturnTableView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableView.h"

@interface MoreFZCReturnTableView : MoreFZCBaseTableView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *openArray;

@property (nonatomic, strong) NSMutableArray *heightArray;
@end