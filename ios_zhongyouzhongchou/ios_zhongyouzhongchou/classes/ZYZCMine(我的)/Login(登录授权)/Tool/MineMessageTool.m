//
//  MineMessageTool.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineMessageTool.h"
#import "ZYZCAccountModel.h"
#import "ZYZCAccountTool.h"



#define hostUrl @"http://121.40.225.119:8080:"
#define regisUrl @"/register/saveWeixinInfo.action?"
@interface MineMessageTool ()


@property (nonatomic, weak) ZYZCAccountModel *account;
@end

@implementation MineMessageTool

///**
// *  注册
// */
//+(void)sendRegisActionMessage
//{
//    
//    NSString *registerString = [NSString stringWithFormat:@"%@%@",hostUrl,regisUrl];
//    //注册的请求
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
//    ZYZCAccountModel *account = [ZYZCAccountTool account];
//    if (account) {
//        NSDictionary *parameters = @{
//                                     @"openid":account.openid,
//                                         };
//    }
//    
////    mgr POST:registerString parameters:<#(nullable id)#> progress:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#><#^(NSProgress * _Nonnull uploadProgress)uploadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:
//    
//}


@end
