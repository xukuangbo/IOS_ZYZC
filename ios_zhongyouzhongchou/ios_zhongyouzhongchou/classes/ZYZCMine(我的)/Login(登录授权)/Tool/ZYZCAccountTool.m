//
//  ZYZCAccountTool.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 liuliang. All rights reserved.
//
// 账号的存储路径
#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
@implementation ZYZCAccountTool
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(ZYZCAccountModel *)account
{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (ZYZCAccountModel *)account
{
    // 加载模型
    ZYZCAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    
    /* 验证账号是否过期 */
    
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        
        //先判断refresh过期没（30天有效期）
        long long refresh_expires_in = 30 * 24 * 60 * 60;
        //如果过期了，得先去判断refresh过期了没
        NSDate *refreshTime = [account.created_time dateByAddingTimeInterval:refresh_expires_in];
        NSComparisonResult refresh_result = [refreshTime compare:now];
        if (refresh_result != NSOrderedDescending) {
            return nil;
        }else{
            //这里应该去用refresh_token去重新获取access_token，以后再写
#warning refresh_token 换取access_token
        }
        

        return nil;
    }
    
    return account;
}
@end
