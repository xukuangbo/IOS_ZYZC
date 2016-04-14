//
//  ZYZCBaseViewController.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/4.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+Background.h"
@interface ZYZCBaseViewController : UIViewController


//-(UIBarButtonItem *)customItemByImgName:(NSString *)imgName andAction:(SEL)action;

-(void)setBackItem;

-(void)customNavWithLeftBtnImgName:(NSString *)leftName andRightImgName:(NSString *)rightName  andLeftAction:(SEL)leftAction andRightAction:(SEL)rightAction;

@end
