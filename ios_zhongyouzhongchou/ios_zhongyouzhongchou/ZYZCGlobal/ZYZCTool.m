//
//  ZYZCTool.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCTool.h"

@implementation ZYZCTool
#pragma mark --- 文字长度计算
+(CGSize)calculateStrLengthByText:(NSString *)text andFont:(UIFont *)font andMaxWidth:(CGFloat )maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
#pragma mark --- 获取本地时间
+(NSString *)getLocalDate
{
    NSDate *  sendDate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY/MM/dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:sendDate];
    
    return locationString;
}

#pragma mark --- 将日期转化为自定义格式
+(NSString *)turnDateToCustomDate:(NSDate *)date
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY/MM/dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:date];
    
    return locationString;
}

@end