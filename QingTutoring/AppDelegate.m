//
//  AppDelegate.m
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/28.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import "AppDelegate.h"
#import "QingTutoringTabBarViewController.h"
#import "LoginViewController.h"
#import "IdentityInformationViewController.h"
#import "ControlCenter.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    GlobalCenter.sharedInstance.isLogin = true;
    //初始化推送
    [self initNotigficate:launchOptions];
    //初始化科大讯飞
    [self initiflyMSC];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *account=[user objectForKey:@"account"];
    NSString *password=[user objectForKey:@"password"];
    if (account&&password) {
        self.window.rootViewController = [QingTutoringTabBarViewController new];
    }else{
        self.window.rootViewController = [LoginViewController new];
    }
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification ==nil) {
        //1.可能为直接点击 icon 被启动或其他进入应用
        NSLog(@"通过其他方式进入app");
    }else{
        NSLog(@"通过点击通知进入应用");
        //2.用户点击apn 通知导致 app 被启动运行
        int badge =[remoteNotification[@"aps"][@"badge"] intValue];
        badge--;
        [JPUSHService setBadge:badge];
        [UIApplication sharedApplication].applicationIconBadgeNumber =badge;
        }
    [self.window makeKeyAndVisible];
    return YES;
}
//初始化科大讯飞sdk
-(void)initiflyMSC{
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"5c773600"];
    [IFlySpeechUtility createUtility:initString];
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

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    //用户已经允许接收以下类型的推送
    //UIUserNotificationType allowedTypes = [notificationSettings types];
}

//按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    completionHandler();
}

#endif
#pragma mark ------ 极光推送 ------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"----------- 极光注册成功 ---------");
    //Jpush
    [JPUSHService registerDeviceToken:deviceToken];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [JPUSHService setTags:nil alias:@"141fe1da9ea1c71a796" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//            NSLog(@"alias id %@",iAlias);
//        }];
//    });
}
//实现注册APNs失败接
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *str = [NSString stringWithFormat: @"Error: %@",error];
    NSLog(@"jpush:%@",str);
    //Optional
    NSLog(@"----------- 极光注册失败 ---------");
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support前台收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
         NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
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
        self.notificationDic = [NSDictionary new];
        self.notificationDic = userInfo;
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
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
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
     [JPUSHService resetBadge];
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

