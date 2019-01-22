//
//  MBProgressHUD+TitleHandle.m
//  Nplan
//
//  Created by xpp on 16/12/15.
//  Copyright © 2016年 thirdnet. All rights reserved.
//

#import "MBProgressHUD+TitleHandle.h"

@implementation MBProgressHUD (TitleHandle)

+ (void)showHudTitle:(NSString *)hudString toView:(UIView *)view
{
    // 显示文字
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = NSLocalizedString(hudString, @"HUD message title");
    hud.labelFont = [UIFont systemFontOfSize:14];
    hud.opacity = 0.7;
    hud.margin = 12;
    [hud hide:YES afterDelay:1.2];
}

+ (void)showSuccess:(NSString *)success ToView:(UIView *)view completion:(void (^)())completion {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    [hud setTintColor:[UIColor whiteColor]];
    UIImage *image = [[UIImage imageNamed:@"成功"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.labelText = success;
    hud.margin = 12;
    [hud hide:YES afterDelay:1.2];
    
    if (completion) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion();
        });
    }
}
+ (void)showSuccess:(NSString *)success Color:(UIColor *)color ToView:(UIView *)view completion:(void (^)())completion{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = color;
    hud.opacity = 0.4;
    [hud setTintColor:[UIColor whiteColor]];
    UIImage *image = [[UIImage imageNamed:@"笑脸"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.labelText = success;
    [hud hide:YES afterDelay:1.2];
    
    if (completion) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion();
        });
    }
}
+ (void)showFail:(NSString *)fail Color:(UIColor *)color ToView:(UIView *)view completion:(void (^)())completion{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = color;
    hud.opacity = 0.7;
    [hud setTintColor:[UIColor whiteColor]];
    UIImage *image = [[UIImage imageNamed:@"哭脸"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.labelText = fail;
    [hud hide:YES afterDelay:1.2];
    
    if (completion) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion();
        });
    }

    
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    view.userInteractionEnabled = NO;
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

+ (void)hideHUDForView:(UIView *)view
{
    view.userInteractionEnabled = YES;
    [self hideHUDForView:view animated:YES];
}


@end
