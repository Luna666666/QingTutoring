//
//  UIColor+HexColor.h
//  Text2Group
//
//  Created by chenshun on 13-4-13.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)
+(UIColor *)colorWithHex:(NSString *)hexColor;
+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)alpha;

//带alpha通道的十六进制串
+ (UIColor *)colorWithARGBHexString: (NSString*)hex;//#AARRGGBB

@end
