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
        successGet(responseObject,NO);
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
        [newParameters addEntriesFromDictionary:[self loginPortNeedEncrypt]];
    }
    else
    {
        [newParameters addEntriesFromDictionary:[self noneLoginPortNeedEncrypt]];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
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
    //timestamp
    NSString *timestamp=[self getTime];
    [strDic setObject:timestamp forKey:@"timestamp"];
    //user_id
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *user_id=[user objectForKey:@"user_id"];
    [strDic setObject:user_id forKey:@"user_id"];
    //nonceStr
    NSString *nonceStr=@"abc123";
    [strDic setObject:nonceStr forKey:@"nonceStr"];
    //signature
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginHash=[defaults objectForKey:@"loginHash"];
    NSString *signature=[NSString stringWithFormat:@"%@%@%@%@",timestamp,user_id,nonceStr,[self turnStrToMD5:loginHash]];
    [strDic setObject:[self turnStrToMD5:signature] forKey:@"signature"];
    
    return strDic;
}

#pragma mark --- 不需要登录权限调用的接口
+(NSDictionary *)noneLoginPortNeedEncrypt
{
    NSMutableDictionary *strDic=[NSMutableDictionary dictionary];
    //timestamp
    NSString *timestamp=[self getTime];
    [strDic setObject:timestamp forKey:@"timestamp"];
    //nonceStr
    NSString *nonceStr=@"abc123";
    [strDic setObject:nonceStr forKey:@"nonceStr"];
    //signature
    NSString *token=@"kuaihaitao20160128";
    NSString *scret=@"3339D912BDEF6CA4EC9AEB5325EAB60B";
    NSString *signature=[NSString stringWithFormat:@"%@%@%@%@",timestamp,token,nonceStr,[self turnStrToMD5:scret]];
    [strDic setObject:[self turnStrToMD5:signature] forKey:@"signature"];
    
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
