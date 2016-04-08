//
//  MineViewController.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

//#import <UIKit/UIKit.h>
//
//@interface MineViewController : UIViewController
//
//@end
#import "ZYZCBaseViewController.h"

#define MineTopViewH 200
@class MineHeadView;
@interface MineViewController : ZYZCBaseViewController
/**
 *  头视图
 */
@property (nonatomic, weak) MineHeadView *topView;
@end