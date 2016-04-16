//
//  HTHTTPTool.m
//  ios-kuaihaitao
//
//  Created by liuliang on 16/1/28.
//  Copyright © 2016年 pqh. All rights reserved.
//

#import "ZYZCHTTPTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation ZYZCHTTPTool

#pragma mark --- get请求
+(void)getHttpDataByURL:(NSString *)url withSuccessGetBlock:(SuccessGetBlock)successGet  andFailBlock:(FailBlock)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
    {
    }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        successGet(responseObject,YES);
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        fail(error.localizedDescription);
    }];
}

#pragma mark --- post请求(加密)
+(void)postHttpDataWithEncrypt:(BOOL)needLogin andURL:(NSString *)url andParameters:(NSDictionary *)parameters andSuccessGetBlock:(SuccessGetBlock)successGet andFailBlock:(FailBlock)fail
{
    NSMutableDictionary *newParameters=[NSMutableDictionary dictionaryWithDictionary:parameters];
    if (needLogin)
    {
//        [newParameters addEntriesFromDictionary:[self loginPortNeedEncrypt]];
    }
    else
    {
//        [newParameters addEntriesFromDictionary:[self noneLoginPortNeedEncrypt]];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    [manager POST:url parameters:newParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
    }
    progress:^(NSProgress * _Nonnull uploadProgress)
    {
    }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        successGet(responseObject,YES);
        successGet(responseObject,NO);
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        fail(error.localizedDescription);
    }];
}

#pragma mark --- 需要登录权限才能调用的接口
+(NSDictionary *)loginPortNeedEncrypt
{
    NSMutableDictionary *strDic=[NSMutableDictionary dictionary];
    
    return strDic;
}

#pragma mark --- 不需要登录权限调用的接口
+(NSDictionary *)noneLoginPortNeedEncrypt
{
    NSMutableDictionary *strDic=[NSMutableDictionary dictionary];
    return strDic;
}

#pragma mark --- 将字符串转换成md5
+(NSString *)turnStrToMD5:(NSString *)str
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

#pragma mark --- 获取本地时间
+(NSString *)getTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
