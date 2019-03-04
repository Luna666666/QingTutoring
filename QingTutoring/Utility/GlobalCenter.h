//
//  GlobalCenter.h
//  JinMiaoClub
//
//  Created by 陈磊 on 15/11/17.
//  Copyright © 2015年 ShenSu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define APPIDs @"appid"
#define APPKEY @"appkey"
#define SIG @"SIG"
#define RT @"RT"
#define TOKEN @"TOKEN"
#define CELLPHONE @"cellphone"
#define PASSWORD @"password"
#define RANDOMCODE @"randomCode"
#define USERID @"UserID"
#define NEWVALUE @"newValue"
#define JWT @"jwt"
#define STARTPAGE @"startPage"
#define SEARCHCONTENT @"scontent"
#define SOURCEPARAM @"source"
#define TYPE_IOS @"2"

#define ISLOGIN @"isLogin"

#define CIPHERTELSTRING @"BDkpAvECZg"//手机号加密字符串
#define CIPHERIDCARDSTRING @"ADkpBv5CZg"//身份证号加密字符串



#define vs @"I-V0.0"
#define vp @"k2dfbd1bbbb6f454eb9duIs"


//自定义Log
#ifdef DEBUG

#define SSLog(fmt, ...) NSLog((@"\n%@," "line: %d\n" fmt), [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__)
#else
#define SSLog(...)
#endif

#define kServerName @"http://www.jscdc.cn/phctspApp" //接口地址
#define PIC_basePath @"http://www.jscdc.cn/phctspWeb/frame/showPic.jsp?path=" //图片根路径
///全局方法中心
@interface GlobalCenter : NSObject

@property(nonatomic, assign)BOOL isLogin;

@property (nonatomic, assign) BOOL haveMessage;


/**
 *  GlobalCenter单例
 *
 *  @return GlobalCenter
 */
+ (GlobalCenter *)sharedInstance;

/**
 *  获取设备名称
 *
 *  @return 设备名称字符串
 */
- (NSString *)getCurrentDeviceName;

/**
 *  sha1加密
 *
 *  @param str 字符串
 *
 *  @return sha1字符串
 */
- (NSString *)sha1Str:(NSString *)str;

/**
 *  MD5加密
 *
 *  @param str 字符串
 *
 *  @return sha1字符串
 */
- (NSString *)MD5Str:(NSString *)str;

//获取当前时间时间戳
- (NSString *)recordTimeString;
/**
 *  时间戳转化为时间
 *
 *  @param timeStamp 时间戳
 */
- (NSString *)timeStampToString:(NSString *)timeStamp;


- (BOOL)checkTelNumberSimple:(NSString *)str;
    
/**
 *  验证手机号码格式
 *
 *  @param telNumber 手机号码字符串
 */
- (BOOL)checkTelNumber:(NSString*)telNumber;
- (BOOL)checkEmail:(NSString *)email;

- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 *  系统版本
 *
 */
- (BOOL)systemVersionWithNumberString:(NSString *)numberString;

///加密手机号码
- (NSString *)cipherTelNumber:(NSString *)telNumber;

///解密手机号码
- (NSString *)decodeTelNumber:(NSString *)cipherTelStr;

///解密身份证号码
- (NSString *)decodeIDCardNumber:(NSString *)cipherIDCardStr;

+(UIAlertController *)createAlertWithMessage:(NSString *)message
                                       title:(NSString *)title
                                 cancelTitle:(NSString *)cancelTitle
                                 actionTitle:(NSString *)actionTitle
                                cancelAction:(void (^)(UIAlertAction *))cancalBlock
                                 loginAction:(void (^)(UIAlertAction *))loginBlock;

- (NSStringDrawingOptions)stringDrawingOptions;

///正则去除网络标签
- (NSString *)filterHTML:(NSString *)string;



@end
