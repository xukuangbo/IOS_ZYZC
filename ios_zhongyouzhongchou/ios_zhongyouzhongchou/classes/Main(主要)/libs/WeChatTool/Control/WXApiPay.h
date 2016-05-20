//
//  WXApiPay.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXUtil.h"
#import "ApiXml.h"

// 账号帐户资料
// 更改商户把相关参数后可测试
#define APP_ID          @"wx4f5dad0f41bb5a7d"        //APPID
//#define APP_SECRET      @""                          //appsecret,看起来好像没用
//商户号，填写商户对应参数
#define MCH_ID          @"1332885601"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"12345678901234567890123456789020"
//支付结果回调页面
#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"

@interface WXApiPay : NSObject

//预支付网关url地址
@property (nonatomic,strong) NSString* payUrl;
//debug信息
@property (nonatomic,strong) NSMutableString *debugInfo;
//返回的错误码
@property (nonatomic,assign) NSInteger lastErrCode;
//商户关键信息
@property (nonatomic,strong) NSString *appId,*mchId,*spKey;

//初始化函数
-(id)initWithAppID:(NSString*)appID
             mchID:(NSString*)mchID
             spKey:(NSString*)key;

//获取当前的debug信息
-(NSString *) getDebugInfo;

//获取预支付订单信息（核心是一个prepayID）
- (NSMutableDictionary*)getPrepayWithOrderName:(NSString*)name
                                         price:(NSString*)price
                                        device:(NSString*)device;
//调用支付接口
- (void)wxPayWithOrderName:(NSString*)name price:(NSString*)price;





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
