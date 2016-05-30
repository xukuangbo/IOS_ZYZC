//
//  WXApiPay.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "WXApiPay.h"
#import <CommonCrypto/CommonDigest.h>
#import "ZYZCTool+getLocalTime.h"
@interface WXApiPay ()


@end

@implementation WXApiPay

#pragma mark --- 支付
-(void )payForWeChat
{
//    post
//    {
//    openid: string  // 微信用户openid
//    ip: string // 用户ip
//    productId: number   // 众筹项目id
//    style1: number      // 支持1元 不传为未选择
//    style2: number      // 支持任意金额的钱数 不传为未选择
//    style3: number      // 回报支持钱数   不传为未选择
//    style4: number       // 一起去支付的钱数   不传为未选择
//        
//    }
   
    NSDictionary *dic=@{@"openid":[ZYZCTool getUserId],
                        @"ip":[ZYZCTool getDeviceIp],
                        @"productId":@190,
                        @"style1":@0.1,
                        @"style2":@0.1,
                        @"style3":@0.1,
                        @"style4":@0.1,
                        @"style5":@0.1,
                        };
    
    NSString *url=@"http://121.40.225.119:8080/weixinpay/generateAppOrder.action";
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:url  andParameters:dic andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"result:%@",result);
            PayReq *request = [[PayReq alloc] init];
            /** 商家向财付通申请的商家id */
        NSDictionary *data=[ZYZCTool turnJsonStrToDictionary:result[@"data"]];
//        NSLog(@"%@",result[@"data"][@"partnerid"]);
            request.openID=data[@"appid"];
        NSLog(@"openID:%@",request.openID);
            request.partnerId = data[@"partnerid"];
        NSLog(@"partnerId:%@",request.partnerId);
            /** 预支付订单 */
            request.prepayId= data[@"prepayid"];
        NSLog(@"prepayId:%@",request.prepayId);
            /** 商家根据财付通文档填写的数据和签名 */
            request.package = data[@"package"];
        NSLog(@"package:%@",request.package);
            /** 随机串，防重发 */
            request.nonceStr= data[@"noncestr"];
            NSLog(@"nonceStr:%@",request.nonceStr);
            /** 时间戳，防重发 */
            request.timeStamp=[data[@"timestamp"] intValue];
            NSLog(@"timeStamp:%d",request.timeStamp);
            /** 商家根据微信开放平台文档对数据做的签名 */
            request.sign= data[@"sign"];
           NSLog(@"sign:%@",request.sign);
            //! @brief 发送请求到微信，等待微信返回onResp
            [WXApi sendReq: request];

    } andFailBlock:^(id failResult) {
        NSLog(@"failResult:%@",failResult);
    }];
    
}

-(void)payMoney
{
    
}

#pragma mark --- 支付结果
-(void)payResult
{
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:KORDER_PAY_NOTIFICATION object:nil];//监听一个通知
    }
}

-(void)getOrderPayResult:(NSNotification *)notify
{
    NSLog(@"notify:%@",notify);
     [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
}


-(NSString *)getNonceStr
{
    int n=arc4random_uniform(100);
    NSString *nonceStr =[self turnStrToMD5:[NSString stringWithFormat:@"%d",n]];
    return nonceStr;
}

-(NSString *)getSign
{
//    appid：	wxd930ea5d5a258f4f
//    mch_id：	10000100
//    device_info：	1000
//    body：	test
//    nonce_str：	ibuaiVcKdpRxkhJA
    
//    NSString *appid=@"wx4f5dad0f41bb5a7d";
//    NSString *mch_id=@"1332885601";
//    NSString *device_info=@"WEB";
//    NSString *body=@"test";
//    NSString *nonce_str=[self getNonceStr];

    return nil;
}

#pragma mark --- 将字符串转换成md5
-(NSString *)turnStrToMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    NSMutableString *newStr=[NSMutableString string];
    for (int i=0; i<16; i++) {
        [newStr appendString:[NSString stringWithFormat:@"%02x",result[i]]];
    }
    return newStr;
}


@end
