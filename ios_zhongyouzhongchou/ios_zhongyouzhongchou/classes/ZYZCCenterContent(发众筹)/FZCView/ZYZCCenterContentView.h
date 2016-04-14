//
//  ZYZCCenterContentView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYZCBaseViewController.h"
typedef void(^DeleteBlock)();
typedef void(^PushVCBlock)(ZYZCBaseViewController *);
@interface ZYZCCenterContentView : UIView
@property(nonatomic,copy)DeleteBlock deleteBlock;
@property(nonatomic,copy)PushVCBlock pushVCBlock;
@property(nonatomic,strong)UIButton *deleteBtn;
@end
