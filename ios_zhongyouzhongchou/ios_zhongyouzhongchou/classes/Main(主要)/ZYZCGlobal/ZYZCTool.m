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

#pragma mark --- 设置文字间距
+(NSMutableAttributedString *)setLineDistenceInText:(NSString *)text
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, text.length)];
    return attributedString;
}

#pragma mark --- 计算有间距的文字的长度
+ (CGSize)calculateStrByLineSpace:(CGFloat)lineSpace andString:(NSString *)str andFont:(UIFont *)font andMaxWidth:(CGFloat )maxW
{
    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
    pStyle.lineSpacing = lineSpace;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    attrs[NSParagraphStyleAttributeName] = pStyle;
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    return labelSize;
}


#pragma mark --- 创建btn（文字在左图片在右）
+ (UIButton *)getCustomBtnByTilte:(NSString *)title andImageName:(NSString *)imageName andtitleFont:(UIFont *)titleFont
{
    CGSize rightButtonTitleSize = [self calculateStrLengthByText:title andFont:titleFont andMaxWidth:MAXFLOAT];
    CGFloat labelWidth = rightButtonTitleSize.width + 2;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    CGFloat imageWith = btn.currentImage.size.width + 2;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
    return btn;
}

#pragma mark --- 获取本地日期
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


#pragma  mark --- 保存用户id到NSUserDefaults
+(void)saveUserIdById:(NSString *)userId
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if (![[user objectForKey:KUSER_ID] isEqualToString:userId]) {
        [user setObject:userId forKey:KUSER_ID];
        [user synchronize];
    }
}

#pragma mark --- 获取用户Id
+ (NSString *)getUserId
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *userId=[user objectForKey:KUSER_ID];
//    if (!userId) {
//        userId=@"oulbuvtpzxiOe6t9hVBh2mNRgiaI";
//    }
    return userId;
}

#pragma mark --- 将jsonStr转nsarray
+ (NSArray *)turnJsonStrToArray:(NSString *)jsonStr
{
    NSError  *error=nil;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = (NSArray *)[NSJSONSerialization JSONObjectWithData:
                                jsonData options:NSJSONReadingAllowFragments
                                error:&error];
    return array;
}

#pragma mark --- 将jsonStr转dict
+ (NSDictionary *)turnJsonStrToDictionary:(NSString *)jsonStr
{
    NSError  *error=nil;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments
        error:&error];
    return dict;
}




@end
