//
//  ZYZCAccountModel.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJCoding.h"

@interface ZYZCAccountModel : NSObject<MJCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**
 *  用来刷新access_token的refresh_token
 */
@property (nonatomic, copy) NSString *refresh_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *unionid;

/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

//注册用的信息
/**
 *  openid
 */
@property (nonatomic, copy) NSString *openid;
/** 用户的昵称 */
@property (nonatomic, copy) NSString *nickname;
/**
 *  性别
 */
@property (nonatomic, assign) NSNumber *sex;
/**
 *  语言
 */
@property (nonatomic, copy) NSString *language;
/**
 *  城市
 */
@property (nonatomic, copy) NSString *city;
/**
 *  省
 */
@property (nonatomic, copy) NSString *province;
/**
 *  国家
 */
@property (nonatomic, copy) NSString *country;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *headimgurl;
/**
 *  userId
 */
@property (nonatomic, copy) NSNumber *userId;



+ (instancetype)accountWithDict:(NSDictionary *)dict;

/**
 *  把微信的部分注册信息存储起来
 */
+ (instancetype)accountWithPersonalMessage:(NSDictionary *)dict;
@end
