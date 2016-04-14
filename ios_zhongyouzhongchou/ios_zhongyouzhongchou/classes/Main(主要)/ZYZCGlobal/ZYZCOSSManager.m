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
NSString * const _bucketName = @"zyzc-bucket01";

static ZYZCOSSManager *ossManager;

OSSClient * client;



@implementation ZYZCOSSManager


+(instancetype )defaultOSSManager
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
    create.bucketName = _bucketName;
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
    delete.bucketName = _bucketName;
    
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
    getBucket.bucketName = _bucketName;
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
- (NSString *)getfileNameWhenUploadObjectAsyncBydocDir:(NSString *)docDir andFileType:(NSString *)fileType{
    //文件类型错误，上传失败
    if (!([fileType isEqualToString:@"png"]||[fileType isEqualToString:@"caf"]||[fileType isEqualToString:@"mp4"])) {
        NSLog(@"fileType 类型错误，上传失败");
        return nil;
    }
    //文件类型正确
    //获取文件名
    NSString *fileName=[self getPutFileNameByType:fileType];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // required fields
    put.bucketName = _bucketName;
    put.objectKey  = fileName;
    put.uploadingFileURL = [NSURL fileURLWithPath:docDir];
    
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
    
    return fileName;
}

#pragma mark --- 异步下载数据
- (void)downloadObjectAsyncByFileName:(NSString *)fileName {
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    // required
    request.bucketName = _bucketName;
    request.objectKey =   fileName;
    
    //optional
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    
    NSString *tmpDir = NSTemporaryDirectory();
    NSURL *dataUrl=[NSURL fileURLWithPath:[tmpDir stringByAppendingPathComponent:[NSString stringWithFormat:@"downloadfile/%@",request.objectKey]]];
     request.downloadToFileURL = dataUrl;
    NSLog(@"dataUrl:%@",dataUrl);
    
    OSSTask * getTask = [client getObject:request];
    
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"download object success!");
            OSSGetObjectResult * getResult = task.result;
            NSLog(@"download dota length: %lu", [getResult.downloadedData length]);
            NSData *data=[NSData dataWithContentsOfURL:dataUrl];
            NSLog(@"data.length:%zd",data.length);
            
        } else {
            NSLog(@"download object failed, error: %@" ,task.error);
        }
        return nil;
    }];
}

#pragma mark --- 删除文件
- (void)deleteObjectByFileName:(NSString *)fileName {
    OSSDeleteObjectRequest * delete = [OSSDeleteObjectRequest new];
    delete.bucketName = _bucketName;
    delete.objectKey = fileName;
    
    OSSTask * deleteTask = [client deleteObject:delete];
    
    [deleteTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"delete success !");
        } else {
            NSLog(@"delete erorr, error: %@", task.error);
        }
        return nil;
    }];
}


#pragma mark --- 上传文件名（时间轴+用户id＋文件类型（png，caf，mp4）保证文件名的唯一性）
-(NSString *)getPutFileNameByType:(NSString *)type
{
    NSString *userId=[ZYZCTool getUserId];
    NSString *timestamp=[self getLocalTime];
    NSString *fileName=[NSString stringWithFormat:@"%@%@.%@",timestamp,userId,type];
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
