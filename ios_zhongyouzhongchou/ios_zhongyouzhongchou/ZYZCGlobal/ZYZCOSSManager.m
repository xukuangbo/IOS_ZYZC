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
    conf.timeoutIntervalForRequest = 30; // 网络请求的超时时间
    conf.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
    
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
}

#pragma mark --- 创建存储空间
- (void)createBucket {
    OSSCreateBucketRequest * create = [OSSCreateBucketRequest new];
    create.bucketName = [self getBucketName];
    create.xOssACL = @"public-read";
    create.location = @"oss-cn-hangzhou";
    
    OSSTask * createTask = [client createBucket:create];
    
    [createTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"create bucket success!");
        } else {
            NSLog(@"create bucket failed, error: %@", task.error);
        }
        return nil;
    }];
}

#pragma mark --- 删除存储空间
- (void)deleteBucket {
    OSSDeleteBucketRequest * delete = [OSSDeleteBucketRequest new];
    delete.bucketName = [self getBucketName];
    
    OSSTask * deleteTask = [client deleteBucket:delete];
    
    [deleteTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"delete bucket success!");
        } else {
            NSLog(@"delete bucket failed, error: %@", task.error);
        }
        return nil;
    }];
}

#pragma mark --- 获取存储空间中的所有对象
- (void)listObjectsInBucket {
    OSSGetBucketRequest * getBucket = [OSSGetBucketRequest new];
    getBucket.bucketName = [self getBucketName];
    getBucket.delimiter = @"";
    getBucket.prefix = @"";

    OSSTask * getBucketTask = [client getBucket:getBucket];
    
    [getBucketTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            OSSGetBucketResult * result = task.result;
            NSLog(@"get bucket success!");
            NSArray *contents=result.contents;
            NSLog(@"contents:%@",contents);
//            for (NSDictionary * objectInfo in result.contents) {
//                NSLog(@"list object: %@", objectInfo);
//            }
        } else {
            NSLog(@"get bucket failed, error: %@", task.error);
        }
        return nil;
    }];
}

#pragma mark --- 异步上传对象
- (void)uploadObjectAsyncBydocDir:(NSString *)docDir {
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // required fields
    put.bucketName = [self getBucketName];
    put.objectKey = @"file1m";
    put.uploadingFileURL = [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:@"file1m"]];
    
    // optional fields
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    put.contentType = @"";
    put.contentMd5 = @"";
    put.contentEncoding = @"";
    put.contentDisposition = @"";
    
    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
}


-(void)putObject
{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // 必填字段
    put.bucketName = @"<bucketName>";
    put.objectKey  = @"<objectKey>";
    
    put.uploadingFileURL = [NSURL fileURLWithPath:@"<filepath>"];
    // put.uploadingData = <NSData *>; // 直接上传NSData
    
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };

}

#pragma mark --- 获取存储空间名(ZYZC_userId)
-(NSString *)getBucketName
{
    NSString *bucketName=[NSString stringWithFormat:@"ZYZC_%@",[ZYZCTool getUserId]];
    return bucketName;
}

#pragma mark --- 给上传文件命名（用户id＋时间轴，保证文件名的唯一性）
-(NSString *)getPutFileName
{
    NSString *userId=[ZYZCTool getUserId];
    NSString *timestamp=[self getLocalTime];
    NSString *fileName=[NSString stringWithFormat:@"%@%@",userId,timestamp];
    return fileName;
    
}

#pragma mark --- 获取本地时间
-(NSString *)getLocalTime
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *localTime=[formater stringFromDate:[NSDate date]];
    return localTime;
}

@end
