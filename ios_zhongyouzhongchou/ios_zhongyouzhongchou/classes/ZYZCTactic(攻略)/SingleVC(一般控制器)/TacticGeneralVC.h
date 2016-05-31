//
//  TacticGeneralVC.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCBaseViewController.h"
@class TacticVideoModel;
@interface TacticGeneralVC : ZYZCBaseViewController

@property (nonatomic, strong) TacticVideoModel *tacticVideoModel;
/**
 *  用于网络请求的id
 */
@property (nonatomic, assign) NSInteger viewId;
/**
 *  初始化方法
 */
- (instancetype)initWithViewId:(NSInteger)viewId;
@end
