//
//  ZYZCTool.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZYZCTool : NSObject
/**
 *  计算文字长度
 *
 *  @param text 文字内容
 *  @param font 字体
 *
 *  @return 文字长度
 */
+(CGSize )calculateStrLengthByText:(NSString *)text andFont:(UIFont *)font andMaxWidth:(CGFloat )maxW;
/**
 *  设置文字间距
 */
+(NSMutableAttributedString *)setLineDistenceInText:(NSString *)text;

/**
 *  计算有间距的文字的长度
 */
+ (CGSize)calculateStrByLineSpace:(CGFloat)lineSpace andString:(NSString *)str andFont:(UIFont *)font andMaxWidth:(CGFloat )maxW;

/**
 *  获取日期时间
 */
+(NSString *)getLocalDate;
/**
 *  转化为日期格式
 *
 */
+(NSString *)turnDateToCustomDate:(NSDate *)date;

/**
 *  保存用户id
 */
+(void)saveUserIdById:(NSString *)userId;

/**
 *  获取用户id
 *
 */
+(NSString *)getUserId;

@end
