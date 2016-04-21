//
//  ZCDetailContentShowBaseCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZCDETAIL_ARRANGESHOW_HEIGHT   800
#define ZCDETAIL_RETURNSHOW_HEIGHT    1000
@interface ZCDetailContentShowBaseCell : UITableViewCell
@property (nonatomic, strong) UITableView *cellTable;
-(void)configUI;
@end
