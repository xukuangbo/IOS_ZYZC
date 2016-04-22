//
//  TacticSingleViewController.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCBaseViewController.h"
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]
#define SingleHeadViewHeight (200 * )
@interface TacticSingleViewController : ZYZCBaseViewController


/**
 *  用于网络请求的id
 */
@property (nonatomic, assign) NSInteger viewId;
/**
 *  初始化方法
 */
- (instancetype)initWithViewId:(NSInteger)viewId;
@end
