//
//  RCManager.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/31.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

typedef void (^LoginSuccess)();

@interface ZYZCRCManager : NSObject<RCIMUserInfoDataSource>

/**
 *  登陆融云
 */
-(void)loginRongCloudByToken:(NSString *)myToken;
/**
 *  获取会话列表
 */
-(void)getMyConversationListWithSupperController:(UIViewController *)viewContrroller;

/**
 *  单聊
 */
-(void)connectTarget:(NSString *)targetId andSuperViewController:(UIViewController *)viewControlle;
@end
