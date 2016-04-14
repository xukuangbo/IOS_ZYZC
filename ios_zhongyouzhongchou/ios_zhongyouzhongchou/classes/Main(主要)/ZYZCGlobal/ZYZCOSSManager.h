//
//  ZYZCOSSManager.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/13.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 *  异步上传文件
 *
 *  @param docDir   文件路径
 *  @param fileType 文件类型（png，caf，mp4）
 *
 *  @return         文件名
 */
- (NSString *)getfileURLWhenUploadObjectAsyncBydocDir:(NSString *)docDir andFileType:(NSString *)fileType;

/**
 *  异步下载
 */
- (void)downloadObjectAsyncByFileName:(NSString *)fileName;

/**
 *  删除文件
 */
- (void)deleteObjectByFileName:(NSString *)fileName;

@end
