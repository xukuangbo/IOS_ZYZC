//
//  TacticTableViewCell.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define videoViewHeight 150
#define TacticTableViewCellMargin 10

#define titleFont [UIFont systemFontOfSize:15]
#define descFont [UIFont systemFontOfSize:13]
@class TacticModel;
@interface TacticTableViewCell : UITableViewCell

@property (nonatomic, strong) TacticModel *tacticModel;
@end
