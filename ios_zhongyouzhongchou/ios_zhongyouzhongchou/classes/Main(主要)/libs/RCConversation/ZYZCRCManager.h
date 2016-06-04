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

//如果用户退出登陆，记得将haslogin置为no
@property (nonatomic, assign) BOOL hasLogin;//记录是否已经登陆过

+(instancetype )defaultRCManager;

/**
 *  获取token
 */
-(void)getRCloudToken;

/**
 *  获取会话列表
 */
-(void)getMyConversationListWithSupperController:(UIViewController *)viewContrroller;

/**
 *  单聊
 */
-(void)connectTarget:(NSString *)targetId andSuperViewController:(UIViewController *)viewControlle;
@end
