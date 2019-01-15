//
//  ZSProgressHUD.h
//  ZSStandard
//
//  Created by zhaopeng on 2017/11/30.
//  Copyright © 2017年 zhaopeng. All rights reserved.
//

#import "SVProgressHUD.h"

@interface ZSProgressHUD : SVProgressHUD

/**
 *  显示成功
 */
+(void)showSuccess;
+(void)showSuccessWithInfo:(NSString *)info;

/**
 *  显示失败
 */
+(void)showFailWithInfo:(NSString *)info;

/**
 *  隐藏
 */
+(void)dismissHUD;

/**
 * 显示
 */
+(void)showWaiting;
+(void)showWaitingWithInfo:(NSString *)info;

/**
 *  显示纯文本
 *
 *  
 */
+(void)showTxtWithInfo:(NSString *)info;


@end
