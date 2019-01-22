//
//  MBProgressHUD+TitleHandle.h
//  Nplan
//
//  Created by xpp on 16/12/15.
//  Copyright © 2016年 thirdnet. All rights reserved.
//

#import "MBProgressHUD/MBProgressHUD.h"

@interface MBProgressHUD (TitleHandle)

+ (void)showHudTitle:(NSString *)hudString toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view completion:(void (^)())completion;
+ (void)showSuccess:(NSString *)success Color:(UIColor *)color ToView:(UIView *)view completion:(void (^)())completion;
+ (void)showFail:(NSString *)fail Color:(UIColor *)color ToView:(UIView *)view completion:(void (^)())completion;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;

@end
