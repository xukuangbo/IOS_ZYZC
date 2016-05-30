//
//  WXApiPay.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

// 账号帐户资料
// 更改商户把相关参数后可测试
#define APP_ID          @"wx4f5dad0f41bb5a7d"          //APPID
//#define APP_SECRET      @""                          //appsecret,看起来好像没用
//商户号，填写商户对应参数
#define MCH_ID          @"1332885601"
//商户API密钥，填写相应参数
#define PARTNERID       @"1332885601"

@interface WXApiPay : NSObject


/**
 *  支付
 */
-(void)payForWeChat;

/**
 *  支付结果
 */
-(void)payResult;

-(NSString *)getNonceStr;

@end
