//
//  AppDelegate+InitThirdSDK.m
//  QingTutoring
//
//  Created by sun-zt on 2019/1/22.
//  Copyright © 2019 Shensu. All rights reserved.
//

#import "AppDelegate+InitThirdSDK.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (InnerThirdSDKs) <JPUSHRegisterDelegate, UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (InitThirdSDK)

- (void)initThirdSDKsWithLaunchOptions:(NSDictionary *)launchOptions {
    [self initJPUSHSDK:launchOptions];
    [self initShareSDK];
}

- (void)JSPUSHHandleRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)jSPUSHUpdateBadge:(int)badge {
    [JPUSHService setBadge:badge];
}

#pragma mark - JPUSH
- (void)initJPUSHSDK:(NSDictionary *)launchOptions {
    if (@available(iOS 10.0, *)) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = (UNAuthorizationOptionAlert |
                        UNAuthorizationOptionBadge |
                        UNAuthorizationOptionSound);
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    } else {
        //可以添加自定义categories
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    // Jpush 注册 如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:kJPush_App_Key
                          channel:kJPush_Channel
                 apsForProduction:NO
            advertisingIdentifier:nil];
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //清除所有通知(包含本地通知)
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - shareSDK
-(void)initShareSDK {
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformSubTypeWechatSession),
                                        @(SSDKPlatformSubTypeWechatTimeline),
                                        @(SSDKPlatformSubTypeQQFriend),
                                        @(SSDKPlatformSubTypeQZone)
                                        ]
                             onImport:^(SSDKPlatformType platformType) {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:kWechat_AppId
                                       appSecret:kWechat_AppSecret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:kQQ_AppId
                                      appKey:kQQ_AppSecret
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}


#pragma mark ------ 极光推送 ------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"----------- 极光注册成功 ---------");
    [JPUSHService registerDeviceToken:deviceToken];
}
//实现注册APNs失败接
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"----------- 极光注册失败 ---------");
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support前台收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"----- ios10 后台回调 走通");
        self.notificationDic = userInfo;
        [self JSPUSHHandleRemoteNotification:userInfo];
    }
    completionHandler();
}

#pragma mark - noti
//后台收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState != UIApplicationStateActive) {
        self.notificationDic = userInfo;
    }else{
        [self didReceiveRemoteNotificationFromBackground];
    }
    // Required, iOS 7 Support
    [self JSPUSHHandleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
// IOS 9 以下这句会报错，请升级xcode到最新或者删除此代码
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
}

@end
