//
//  ZYZCOSSManager.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/13.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessUploadBlock)();
typedef void(^FailUploadBlock)();
@interface ZYZCOSSManager : NSObject
+(instancetype )defaultOSSManager;
/**
 *  创建存储空间
 */
- (void)createBucket;
/**
 *  删除存储空间
 */
- (void)deleteBucket;

/**
 *  同步上传文件
 *
 */
- (BOOL )uploadObjectSyncByFileName:(NSString *)fileName andFilePath:(NSString *)filePath;
/**
 *  异步上传文件
 *
 */
- (void )uploadObjectAsyncByFileName:(NSString *)fileName andFilePath:(NSString *)filePath withSuccessUpload:(SuccessUploadBlock )successUpload andFailUpload:(FailUploadBlock )failUpload;

/**
 *  异步下载
 */
- (void)downloadObjectAsyncByFileName:(NSString *)fileName;

/**
 *  删除文件
 */
- (void)deleteObjectByFileName:(NSString *)fileName;

/**
 *  删除某文件下的所有子文件
 */
-(void)deleteObjectsByPrefix:(NSString *)prefix;

@end
