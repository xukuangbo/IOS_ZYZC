//
//  WXApiManager.h
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "ZYZCAccountModel.h"
@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;


- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

@end

@interface WXApiManager : NSObject<WXApiDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;

/**
 *  微信登录
 *
 *  @param viewController 推出微信的控制器
 */
- (void)loginWeChatWithViewController:(UIViewController *)viewController;

/**
 *  判断是否微信登录
 *
 *  @param viewController 推出微信的控制器
 */
-(void)judgeAppGetWeChatLoginWithViewController:(UIViewController *)viewController;

/**
 *  获取用户微信信息
 *
 *  @param account 
 */
- (void)requstPersonalData:(ZYZCAccountModel *)account;

/**
 *  微信支付
 *  @param dict 支付金额（字典形式）
 */

-(void )payForWeChat:(NSDictionary *)dict;


@end
