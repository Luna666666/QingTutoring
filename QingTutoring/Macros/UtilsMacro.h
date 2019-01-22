//
//  UtilsMacro.h
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/28.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

//屏幕的长宽
//快速定义一个weak self
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#define App (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define LWidth [UIScreen mainScreen].bounds.size.width //屏幕宽
#define LHeight [UIScreen mainScreen].bounds.size.height //高

#define ZS_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]// 设置颜色RGB
#define ZS_MAIN_COLOR ZS_COLOR(51, 153, 255, 1)//程序主色调
#define kdecLightGray           [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.00]    // 大部分灰色背景
#define ZS_BG_COLOR [UIColor groupTableViewBackgroundColor]
#define ZS_TEXT_BLACKCOLOR ZS_COLOR(40, 40, 40, 1)//一级标题字体颜色
#define ZS_TEXT_DARKCOLOR ZS_COLOR(101, 101, 101, 1)//二级标题字体颜色
#define ZS_TEXT_LIGHTCOLOR ZS_COLOR(152, 152, 152, 1)//三级标题字体颜色
#define ZS_TEXT_PLACEHOLDER ZS_COLOR(187, 187, 194, 1)//提示语的字体颜色

#define ZS_IMAGENAME(name) [UIImage imageNamed:name]//定义UIImage对象

#define ISIphoneX ([UIUtility isIPhoneX])
//导航栏高度
#define navHeight (ISIphoneX?88:64)
#define NavigateBarH (ISIphoneX?88:64)
/**tabbar高度*/
#define kTarbarHeight (ISIphoneX?83:49)
#define ScaleWidth   (SCREEN_WIDTH / 375.0)
#define ScaleHeight  (SCREEN_HEIGHT / 667.0)


#define STATUS_BAR_HEIGHT (ISIphoneX?44.f:20.f) //状态栏高度
#define NAV_BAR_HEIGHT 44.f // 导航栏高度
#define SCREEN_TOP_INSET (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)  // 屏幕上方
#define SENSOR_HOUSING_HEIGHT (ISIphoneX?44.f:0) //传感器的高度
#define HOME_INDICATOR_HEIGHT (ISIphoneX?34.f:0.f) //x以上下面home键高度
#define TAB_BAR_HEIGHT (HOME_INDICATOR_HEIGHT + 49.f) //tab 高度

#define SAFEAREA_FRINGE_HEIGHT   (IS_IPHONE_X ? 30.0 : 0)       ///< 刘海真实的高度
#define SAFEAREA_TOP_MARGIN      SCREEN_TOP_INSET               ///< 安全区域上方高度
#define SAFEAREA_BOTTOM_MARGIN   HOME_INDICATOR_HEIGHT          ///< 安全区域下方高度

#define Margin1 10
#define LRViewBorderRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\

#define StatusAndNavbarHeight (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
//状态栏高度
#define statusBarH [[UIApplication sharedApplication] statusBarFrame].size.height

#pragma mark -----颜色相关-----
#define kCOLOR_P(r, g, b, p) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:p * 1.0]
#define kCOLOR(r, g, b) kCOLOR_P(r, g, b, 1.0)
#define RGB(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//弹出框文字颜色
#define kPopTitleColor  0x999999
#define kCancelColor  0x333333
#define kSureColor  0xf14a4a

// 新UI颜色整理
#define TitleColor [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0]
#define MainColor  [UIColor colorWithRed:255 / 255.0 green:218 / 255.0 blue:68 / 255.0 alpha:1.0]
#define BackgroundColor             kCOLOR(238, 238, 238)
#define kMainColor                  kCOLOR(88,212,149)
#define kNavigateColor              kMainColor
#define kBackgroundColor            kCOLOR(245, 245, 245)
#define kLineGrayColor              kCOLOR(240,240,240)
#define kTextGrayColor              kCOLOR(102, 102, 102)
#define kTextLightBlackColor        kCOLOR(77,77,77)
#define kWhiteColor                 [UIColor whiteColor]//pageControl颜色
#define kDisabledButtonGrayColor    kCOLOR(204,204,204)
#define kOrangeColor                kCOLOR(254,92,49)
#define kTextOrangeColor            kCOLOR(255,126,0)
#define kBlackColor                 kCOLOR(51,51,51)
#define TitleColor [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0]
#define SubTitleColor [UIColor colorWithRed:156 / 255.0 green:156 / 255.0 blue:156 / 255.0 alpha:1.0]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kNavigationColor 0x429ef7
#define kBorderLine      0xe0e0dc

#pragma mark -----字体-----
// 新UI
#define kSmallFont          [UIFont systemFontOfSize:11]
#define kLittleSmallFont    [UIFont systemFontOfSize:13]
#define kNormalFont         [UIFont systemFontOfSize:14]
#define kLittleBigFont      [UIFont systemFontOfSize:15]
#define kSixTeenFont        [UIFont systemFontOfSize:16]
#define kBigFont            [UIFont systemFontOfSize:17]
#define kBiggestFont        [UIFont systemFontOfSize:18]
#define kNavTitleFont       [UIFont systemFontOfSize:17]

#define TitleFont        [UIFont systemFontOfSize:17]
#define TextFont         [UIFont systemFontOfSize:14.5]
#define DetailFont       [UIFont systemFontOfSize:11.5]
#define TipFont          [UIFont systemFontOfSize:10]

#define IconSize         30
#define NormalImageSize  20
#define SmallImageSize   15

#define UIImaged(str)  [UIImage imageNamed:str]

//NSUserDefaults Shared
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define kUserIdKey @"userId"
#define kUserId [USER_DEFAULTS objectForKey:kUserIdKey]
#define kTokenKey @"token"
#define kToken [USER_DEFAULTS objectForKey:kTokenKey]

#endif /* UtilsMacro_h */
