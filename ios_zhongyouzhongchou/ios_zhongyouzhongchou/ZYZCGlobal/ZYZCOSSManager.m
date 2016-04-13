//
//  ZYZCOSSManager.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/13.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCOSSManager.h"
#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>


NSString * const AccessKey = @"ZEoTY0iktlhynuSO";
NSString * const SecretKey = @"GQkbvA5jPY3gCFKjXQg3Pvw6DZQulM";
NSString * const endPoint  = @"http://oss-cn-hangzhou.aliyuncs.com";
NSString * const multipartUploadKey = @"multipartUploadObject";

static ZYZCOSSManager *ossManager;

OSSClient * client;

@implementation ZYZCOSSManager
+(instancetype )deafultOSSManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!ossManager) {
            ossManager=[[ZYZCOSSManager alloc]init];
        }
    });
    
    return ossManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [OSSLog enableLog];
        [self initOSS];
    }
    return self;
}
#pragma mark --- 初始化OSS
-(void)initOSS
{
    // 明文设置secret的方式建议只在测试时使用，更多鉴权模式请参考后面的`访问控制`章节
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey
                                secretKey:SecretKey];
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2; // 网络请求遇到异常失败后的重试次数
    conf.timeoutIntervalForRequest = 20; // 网络请求的超时时间
    conf.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
    
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
}

#pragma mark --- 获取本地时间
-(NSString *)getLocalTime
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *localTime=[formater stringFromDate:[NSDate date]];
    return localTime;
}

#pragma mark --- 上传图片数据
-(void)putImageObject
{
    
}

#pragma mark --- 上传语音数据
-(void)putVoiceObject
{
    
}

#pragma mark --- 上传视屏数据
-(void)putMovieObject
{
    
}



@end
