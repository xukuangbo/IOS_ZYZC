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
 *  异步上传数据
 *
 */
- (void)uploadObjectAsyncBydocDir:(NSString *)docDir;

/**
 *  异步下载
 */

- (void)downloadObjectAsync;

@end
