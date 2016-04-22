//
//  ZCDetailIntroSecondCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define ZCDETAILINTRO_SECONDCELL_HEIGHT  350

#import "MoreFZCBaseTableViewCell.h"

@interface ZCDetailIntroSecondCell : MoreFZCBaseTableViewCell

@property (nonatomic, strong)UIScrollView *goalsView;

@property (nonatomic, strong) NSArray *goals;

@property (nonatomic, strong) UIButton *preClickBtn;

@end
