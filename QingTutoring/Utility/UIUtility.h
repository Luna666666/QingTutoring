//
//  UIUtility.h
//  Pods
//
//  Created by momo783 on 2016/10/9.
//
//

#import <Foundation/Foundation.h>

#define kBadgeViewTag           77

@interface UIUtility : NSObject

+ (float)systemVersion;

// > 某个版本，没有=
+ (BOOL)isMoreThanVersion:(float)aVersion;
+ (BOOL)isLessThanVersion:(float)aVersion;
+ (BOOL)isNotLessThanVersion:(float)aVersion;

+ (UIViewController *)getUsablePresentedViewController:(UIViewController *)aVC;

+ (BOOL)isIPhoneX;

@end
