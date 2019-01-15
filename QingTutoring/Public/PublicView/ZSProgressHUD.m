//
//  ZSProgressHUD.m
//  ZSStandard
//
//  Created by zhaopeng on 2017/11/30.
//  Copyright © 2017年 zhaopeng. All rights reserved.
//

#import "ZSProgressHUD.h"

@implementation ZSProgressHUD

/**
 *  显示成功
 */
+(void)showSuccess{
    [ZSProgressHUD showSuccessWithStatus:nil];
}
+(void)showSuccessWithInfo:(NSString *)info{
    [ZSProgressHUD showSuccessWithStatus:info];
}


/**
 *  显示失败
 */
+(void)showFailWithInfo:(NSString *)info{
    if (!info.length) {
        info = @"出错了!";
    }
    [ZSProgressHUD showErrorWithStatus:info];
}

/**
 *  隐藏
 */
+(void)dismissHUD{
    
    [ZSProgressHUD dismiss];
}

/**
 * 等待中
 */
+(void)showWaiting{
    
    [ZSProgressHUD showWithStatus:nil];
}

/**
 * 等待中
 */
+(void)showWaitingWithInfo:(NSString *)info{
    [ZSProgressHUD showWithStatus:info];
}

+(void)showTxtWithInfo:(NSString *)info{
   // [ZSProgressHUD showInfoWithStatus:info];
}

@end
