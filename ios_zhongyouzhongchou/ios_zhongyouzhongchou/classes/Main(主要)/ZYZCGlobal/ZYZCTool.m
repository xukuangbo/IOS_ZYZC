//
//  ZYZCTool.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCTool.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

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
    [btn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
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

#pragma mark --- 获取时间戳
+(NSString *)getTimeStamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval time=[date timeIntervalSince1970];//(10位)
    NSString *timeStamp = [NSString stringWithFormat:@"%.f", time];
    return timeStamp;
}


#pragma mark --- 时间戳转时间
+(NSString *)turnTimeStampToDate:(NSString *)timeStamp
{
    if(timeStamp.length>10)
    {
        timeStamp=[timeStamp substringToIndex:10];
    }
    NSString*str=timeStamp;//时间戳  @"1368082020"(十位)
    
    NSTimeInterval time=[str doubleValue];
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

#pragma mark --- 获取手机ip
+ (NSString *)getDeviceIp
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

#pragma mark --- 判断文件是否已存在,存在就清楚
+(void)removeExistfile:(NSString *)filePath
{
    NSFileManager *manager=[NSFileManager defaultManager];
    BOOL exist=[manager fileExistsAtPath:filePath];
    if (exist) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [manager removeItemAtPath:filePath error:nil];
        });
    }
}

#pragma mark --- 清空documents下zcDraft中的文件
+ (void)cleanZCDraftFile
{
    NSString *zcDraftPath=[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0],KMY_ZHONGCHOU_FILE];
    
    NSFileManager *manager=[NSFileManager defaultManager];
    BOOL exist=[manager fileExistsAtPath:zcDraftPath];
    if (exist) {
        NSArray *fileArr=[manager subpathsAtPath:zcDraftPath];
        for (NSString *fileName in fileArr) {
            NSString *filePath = [zcDraftPath stringByAppendingPathComponent:fileName];
            dispatch_async(dispatch_get_global_queue(0, 0), ^
            {
                [manager removeItemAtPath:filePath error:nil];
            });
        }
    }
}
#pragma mark - 计算生日的月，日
/**
 *  根据生日计算星座
 *
 *  @param month 月份
 *  @param day   日期
 *
 *  @return 星座名称
 */
+(NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day
{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31){
        return @"错误日期格式!";
    }
    
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@座",result];
}

@end
