//
//  UIUtility.m
//  Pods
//
//  Created by momo783 on 2016/10/9.
//
//

#import "UIUtility.h"
#import "UIDevice-Hardware.h"

static float _systemVersionFloat;

@implementation UIUtility

+ (float)systemVersion
{
    if (!_systemVersionFloat) {
        _systemVersionFloat = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    
    return _systemVersionFloat;
}

// > 某个版本，没有=
+ (BOOL)isMoreThanVersion:(float)aVersion
{
    float version = [UIUtility systemVersion];
    if (version > aVersion) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isLessThanVersion:(float)aVersion
{
    float version = [UIUtility systemVersion];
    if (version < aVersion) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isNotLessThanVersion:(float)aVersion
{
    float version = [UIUtility systemVersion];
    if (version >= aVersion) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -
+ (UIViewController *)getUsablePresentedViewController:(UIViewController *)aVC
{
    UIViewController *viewController = aVC.presentedViewController;
    
    if (!viewController){
        viewController = aVC;
    }else {
        UIViewController *tempVC =  viewController.presentedViewController;
        
        if (!tempVC){
            return viewController;
        }else {
            viewController = [self getUsablePresentedViewController:viewController];
        }
    }
    
    return viewController;
}

+ (BOOL)isIPhoneX
{
    static BOOL x = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIDevicePlatform type = (UIDevicePlatform)[[UIDevice currentDevice] platformType];
        if (type == UIDeviceXiPhone || type == UIDeviceXSiPhone || type == UIDeviceXSMaxiPhone || type == UIDeviceXRiPhone) {
            x = YES;
        } else if (type == UIDeviceiPhoneSimulatoriPhone && (CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(375.f, 812.f)) || CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(414.f, 896.f)))) {
            x = YES;
        }
    });
    return x;
}

@end
