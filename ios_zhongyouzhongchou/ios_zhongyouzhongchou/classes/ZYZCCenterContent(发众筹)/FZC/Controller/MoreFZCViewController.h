//
//  MoreFZCViewController.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCBaseViewController.h"
#import "MoreFZCToolBar.h"

typedef NS_ENUM(NSInteger, SaveBtnType)
{
    SkimType=KFZC_SAVE_TYPE,
    NextType,
    SaveType
};

typedef void(^GoalKeyBordHidden)();

@interface MoreFZCViewController : ZYZCBaseViewController

@property (nonatomic, weak) MoreFZCToolBar *toolBar;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) CGFloat lastScrollOffset;


/**
 *  承载4个tableview的view
 */
@property (nonatomic, weak) UIView *clearMapView;

@property (nonatomic, copy) GoalKeyBordHidden goalKeyBordHidden;

@end
