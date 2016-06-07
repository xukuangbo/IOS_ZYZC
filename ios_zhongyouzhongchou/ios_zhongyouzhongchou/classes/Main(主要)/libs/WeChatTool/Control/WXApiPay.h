//
//  WXApiPay.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface WXApiPay : NSObject


/**
 *  支付
 */
-(void )payForWeChat:(NSDictionary *)dict;

/**
 *  支付结果
 */
-(void)payResult;

-(NSString *)getNonceStr;

@end
