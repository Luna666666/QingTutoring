//
//  GlobalCenter.m
//  JinMiaoClub
//
//  Created by 陈磊 on 15/11/17.
//  Copyright © 2015年 ShenSu. All rights reserved.
//

#import "GlobalCenter.h"
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation GlobalCenter

+ (GlobalCenter *)sharedInstance
{
    static GlobalCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalCenter alloc] init];
    });
    return instance;
}

- (NSString *)getCurrentDeviceName
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod touch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod touch2";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod touch3";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod touch4";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod touch5";
    if ([platform isEqualToString:@"iPod7,1"]) return @"iPod touch6";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

- (NSString *)sha1Str:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

- (NSString *)MD5Str:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return  output;
}

- (NSString *)recordTimeString
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *recordTimeString = [NSString stringWithFormat:@"%llu", recordTime];
    return recordTimeString;
}
- (NSString *)timeStampToString:(NSString *)timeStamp {
    NSTimeInterval timeSta = [timeStamp doubleValue]/1000;
    NSTimeInterval timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDateFormatter *dfmatter = [[NSDateFormatter alloc]init];
    dfmatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [[[NSDate alloc] initWithTimeIntervalSince1970:timeSta] dateByAddingTimeInterval:timeZoneOffset];
    return [[NSString stringWithFormat:@"%@", date] substringToIndex:19];
}

//判断手机号 11位纯数字
- (BOOL)checkTelNumberSimple:(NSString *)str
{
    if (str.length != 11) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
    


//验证手机号码格式
- (BOOL)checkTelNumber:(NSString *)telNumber
{
    BOOL isMatch = NO;
    if (telNumber.length == 11) {
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
         * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         * 联通号段: 130,131,132,155,156,185,186,145,176,1709
         * 电信号段: 133,153,180,181,189,177,1700
         */
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         */
        NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        /**
         * 中国联通：China Unicom
         * 130,131,132,155,156,185,186,145,176,1709
         */
        NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        /**
         * 中国电信：China Telecom
         * 133,153,180,181,189,177,1700
         */
        NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
        if (([regextestmobile evaluateWithObject:telNumber] == YES)
            || ([regextestcm evaluateWithObject:telNumber] == YES)
            || ([regextestct evaluateWithObject:telNumber] == YES)
            || ([regextestcu evaluateWithObject:telNumber] == YES))
        {
            isMatch = YES;
        }
    }
    return isMatch;
}
//验证邮箱格式
- (BOOL)checkEmail:(NSString *)email{
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:email];
}
//MARK: 颜色转图片
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    struct CGContext *context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//判断系统版本
- (BOOL)systemVersionWithNumberString:(NSString *)numberString {
    return [[[UIDevice currentDevice] systemVersion] compare:numberString options:NSNumericSearch] != NSOrderedAscending;
}


//加密手机号码
- (NSString *)cipherTelNumber:(NSString *)telNumber
{
    NSString *lastStr = [telNumber substringFromIndex:telNumber.length - 1];//手机号码最后一位
    NSString *frontStr = [telNumber substringToIndex:telNumber.length - 5];//手机号码前六位
    NSString *backStr = [telNumber substringFromIndex:telNumber.length - 5];//手机号码后五位
    NSInteger lastNum = [lastStr integerValue]; 
    NSInteger mulNum = lastNum;
    if (lastNum < 2) {
        mulNum = 2;
    }
    NSInteger num = (mulNum * [frontStr integerValue]);
    
    NSMutableString *cipherTelStr = [NSMutableString stringWithFormat:@"%@%ld", backStr, (long)num];
    NSString *replaceString = CIPHERTELSTRING;
    for (int i = 0; i< cipherTelStr.length; i++) {
        [cipherTelStr replaceCharactersInRange:NSMakeRange(i, 1) withString:[replaceString substringWithRange:NSMakeRange([[cipherTelStr substringWithRange:NSMakeRange(i, 1)] integerValue], 1)]];
    }
    return cipherTelStr;
}


//解密手机号码
- (NSString *)decodeTelNumber:(NSString *)cipherTelStr
{
    NSString *replaceString = CIPHERTELSTRING;
    NSMutableString *lastStr = [[NSMutableString alloc] init];//手机号码最后一位
    NSMutableString *frontStr = [[NSMutableString alloc] init];//手机号码前六位
    NSMutableString *backStr = [[NSMutableString alloc] init];//手机号码后五位
    
    for (int i = 0; i < cipherTelStr.length; i++) {
        NSRange range = [replaceString rangeOfString:[cipherTelStr substringWithRange:NSMakeRange(i, 1)]];
        if (range.location != NSNotFound) {
            if (i == 4) {
                [lastStr appendString:[NSString stringWithFormat:@"%lu", (unsigned long)range.location]];
            }
            if (i < 5) {
                [backStr appendString:[NSString stringWithFormat:@"%lu", (unsigned long)range.location]];
                
            } else {
                [frontStr appendString:[NSString stringWithFormat:@"%lu", (unsigned long)range.location]];
            }
        }
    }
    
    NSInteger mulNum = [lastStr integerValue];
    if ([lastStr integerValue] < 2) {
        mulNum = 2;
    }
    
    frontStr = [NSMutableString stringWithFormat:@"%ld", [frontStr integerValue] / mulNum];
    
    return [NSMutableString stringWithFormat:@"%@%@", frontStr,backStr];
}

- (NSString *)decodeIDCardNumber:(NSString *)cipherIDCardStr
{
    if (cipherIDCardStr == nil || (cipherIDCardStr.length != 15 && cipherIDCardStr.length != 18)) {
        return @"";
    }
    NSString *replaceString = CIPHERIDCARDSTRING;
    NSString *firstStr = [cipherIDCardStr substringWithRange:NSMakeRange(0, 1)];//第一位
    NSString *lastStr = [cipherIDCardStr substringWithRange:NSMakeRange(1, 1)];//最后一位
    NSMutableString *middleStr = [[NSMutableString alloc] initWithString:[cipherIDCardStr substringWithRange:NSMakeRange(2, cipherIDCardStr.length - 2)]];//中间位
    for (int i = 0; i < middleStr.length; i++) {
        NSRange range = [replaceString rangeOfString:[middleStr substringWithRange:NSMakeRange(i, 1)]];
        if (range.location != NSNotFound) {
            [middleStr replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%lu", (unsigned long)range.location]];
        }
    }
    //    NSMutableString
    return [NSString stringWithFormat:@"%@%@%@", firstStr, middleStr,lastStr];
}

+(UIAlertController *)createAlertWithMessage:(NSString *)message
                                       title:(NSString *)title
                                 cancelTitle:(NSString *)cancelTitle
                                 actionTitle:(NSString *)actionTitle
                                cancelAction:(void (^)(UIAlertAction *))cancalBlock
                                 loginAction:(void (^)(UIAlertAction *))loginBlock
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if(cancalBlock != nil)
    {
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            cancalBlock(action);
            
        }];
        [alertController addAction:cancelAction];
    }
    
    UIAlertAction *loginAction=[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        loginBlock(action);
    }];
    [alertController addAction:loginAction];
    return alertController;
}

- (NSStringDrawingOptions)stringDrawingOptions
{
    return NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
}

//正则去除网络标签
- (NSString *)filterHTML:(NSString *)string {
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|&nbsp;*"
                                                                                    options:0
                                                                                      error:nil];
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    //去掉首尾空格和换行符
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //去掉所有空格和换行符
//    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return string;
}




@end
