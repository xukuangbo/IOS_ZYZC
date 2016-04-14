//
//  MoreFZCChooseSceneController.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCBaseViewController.h"
typedef void(^GetOneScenceBlock)(NSString *scence);
@interface MoreFZCChooseSceneController : ZYZCBaseViewController
@property(nonatomic,copy)GetOneScenceBlock getOneScene;
@property(nonatomic,strong)NSArray *mySceneArr;
@end
