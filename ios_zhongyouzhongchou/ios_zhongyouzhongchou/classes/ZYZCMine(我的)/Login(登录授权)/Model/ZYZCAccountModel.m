//
//  ZYZCAccountModel.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCAccountModel.h"

@implementation ZYZCAccountModel
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    ZYZCAccountModel *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.unionid = dict[@"unionid"];
    account.expires_in = dict[@"expires_in"];
    // 获得账号存储的时间（accessToken的产生时间）
    account.created_time = [NSDate date];
    return account;
}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.access_token forKey:@"refresh_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.unionid forKey:@"unionid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.refresh_token = [decoder decodeObjectForKey:@"refresh_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.unionid = [decoder decodeObjectForKey:@"unionid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
