//
//  ZCDetailIntroThirdCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define ZCDETAILINTRO_THIRDCELL_HEIGHT  35+(KSCREEN_W-4*KEDGE_DISTANCE)*5/8

#import "MoreFZCBaseTableViewCell.h"

@interface ZCDetailIntroThirdCell : MoreFZCBaseTableViewCell
@property (nonatomic, strong) UILabel *subDesLab;
@property (nonatomic, strong) UIImageView *movieImg;
@end
