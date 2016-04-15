//
//  GoalFirstCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableViewCell.h"
#import "GoalPeoplePickerView.h"
#define FIRSTCELLHEIGHT 250
@interface GoalFirstCell : MoreFZCBaseTableViewCell
@property(nonatomic, strong) GoalPeoplePickerView *peoplePickerView;
/**
 *  刷新数据,人数改变
 */
-(void)reloadViews;
@end
