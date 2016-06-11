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
#import "sys/utsname.h"

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

#pragma mark - 获取手机型号
/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSInteger)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone3,1"])    return 1;
    if ([deviceString isEqualToString:@"iPhone3,2"])    return 1;
    if ([deviceString isEqualToString:@"iPhone4,1"])    return 2;
    if ([deviceString isEqualToString:@"iPhone5,1"])    return 2;
    if ([deviceString isEqualToString:@"iPhone5,2"])    return 2;
    if ([deviceString isEqualToString:@"iPhone5,3"])    return 2;
    if ([deviceString isEqualToString:@"iPhone5,4"])    return 2;
    if ([deviceString isEqualToString:@"iPhone6,1"])    return 2;
    if ([deviceString isEqualToString:@"iPhone6,2"])    return 2;
    if ([deviceString isEqualToString:@"iPhone7,1"])    return 2;
    if ([deviceString isEqualToString:@"iPhone7,2"])    return 2;
    if ([deviceString isEqualToString:@"iPhone8,1"])    return 3;
    if ([deviceString isEqualToString:@"iPhone8,2"])    return 3;
    
    return 0;
//    //iPhone
//    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
//    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
//    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
//    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
//    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
//    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
//    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
//    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
//    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
//    //iPod
//    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
//    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
//    
//    //iPad
//    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
//    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
//    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
//    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
//    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
//    
//    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
//    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
//    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
//    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
//    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
//    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
//    
//    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
//    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
//    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
//    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
//    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
//    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
//    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
//    
//    if ([deviceString isEqualToString:@"iPad4,4"]
//        ||[deviceString isEqualToString:@"iPad4,5"]
//        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
//    
//    if ([deviceString isEqualToString:@"iPad4,7"]
//        ||[deviceString isEqualToString:@"iPad4,8"]
//        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
//    return deviceString;
}
// 修正图片方向（正方向,上传服务器后避免图片方向错误）
+ (UIImage *)fixOrientation:(UIImage *)aImage {
//    NSLog(@"%@",aImage.imageOrientation);
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
