//
//  AppDelegate+InitThirdSDK.h
//  QingTutoring
//
//  Created by sun-zt on 2019/1/22.
//  Copyright © 2019 Shensu. All rights reserved.
// 第三方sdk的初始，在这里处理

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (InitThirdSDK)

- (void)initThirdSDKsWithLaunchOptions:(NSDictionary *)launchOptions;

- (void)JSPUSHHandleRemoteNotification:(NSDictionary *)userInfo;
- (void)jSPUSHUpdateBadge:(int)badge;

@end

NS_ASSUME_NONNULL_END
