//
//  ZCDetailContentShowBaseCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ZCDETAIL_CONTENTSHOW_HEIGHT KSCREEN_H-64-49-53
@interface ZCDetailContentShowBaseCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *cellTable;
-(void)configUI;
@end
