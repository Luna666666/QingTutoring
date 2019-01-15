//
//  AppDelegate.m
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/28.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "QingTutoringTabBarViewController.h"
#import "LoginViewController.h"
#import "ViewController.h"
#import "ControlCenter.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

@interface AppDelegate ()<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>
@property(nonatomic, strong)NSDictionary *notificationDic;
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    //初始化推送
    [self initNotigficate:launchOptions];
    //初始化分享
    [self initShareSDK];
    self.window.rootViewController = [QingTutoringTabBarViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)initShareSDK{
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformSubTypeWechatSession),
                                        @(SSDKPlatformSubTypeWechatTimeline),
                                        @(SSDKPlatformSubTypeQQFriend),
                                        @(SSDKPlatformSubTypeQZone)
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
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
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
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
- (void)initNotigficate:(NSDictionary *)launchOptions {
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
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

#pragma mark ------ 极光推送 ------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
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
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {

    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"----- ios10 后台回调 走通");
        [JPUSHService handleRemoteNotification:userInfo];
        self.notificationDic = [NSDictionary new];
        self.notificationDic = userInfo;
    }
    completionHandler();
}
//后台收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    NSLog(@"-------- ios10 以下设备走的方法");
    if (application.applicationState != UIApplicationStateActive) {
        NSLog(@"----- 有通知 ----- %@", userInfo);
        self.notificationDic = [NSDictionary new];
        self.notificationDic = userInfo;
    }else{
        NSLog(@"----  活跃状态下收到了通知了, 发送通知 -----");
        [ControlCenter sharedInstance].hasNotification = YES;
    }
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
// IOS 9 以下这句会报错，请升级xcode到最新或者删除此代码
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler{

}

- (void)applicationWillResignActive:(UIApplication *)application {

}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [JPUSHService setBadge:0];
    if (_notificationDic != nil) {
        NSLog(@"---- 点外部有推送通知, 增对点击通知栏进入程序, 此时需要跳转到通知列表------");
        UITabBarController *appRootVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *account=[user objectForKey:@"account"];
        NSString *password=[user objectForKey:@"password"];
        if (account&&password) {
//            MessageVC *messageVC=[[MessageVC alloc]init];
//            appRootVC.selectedIndex =2;
//            UINavigationController *nav = appRootVC.viewControllers[0];
//            [nav pushViewController:messageVC animated:YES];
        }else{
            self.window.rootViewController = [LoginViewController new];
        }
        self.notificationDic = nil;
    }
    else
    {
        if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
            NSLog(@"----- 有通知消息, 增对有通知消息,但是从图标进入程序");
            [ControlCenter sharedInstance].hasNotification = YES;
        }
    }

}


- (void)applicationWillTerminate:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    [self application:application handleOpenURL:url];
    return YES;
}
/*
 * @Summary:程序被第三方调用，传入参数启动
 *
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}


@end

