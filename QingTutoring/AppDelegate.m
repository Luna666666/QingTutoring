//
//  AppDelegate.m
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/28.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+InitThirdSDK.h"
#import "AppDelegate+OpenURL.h"
#import "QingTutoringTabBarViewController.h"
#import "LoginViewController.h"
#import "IdentityInformationViewController.h"
#import "ControlCenter.h"


@interface AppDelegate ()

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    GlobalCenter.sharedInstance.isLogin = false;
    //初始化第三方sdk
    [self initThirdSDKsWithLaunchOptions:launchOptions];
    [self didFinishLaunchingWithOptionsOpenURL:launchOptions];
    self.window.rootViewController = [QingTutoringTabBarViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self jSPUSHUpdateBadge:0];
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
    else {
        if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
            NSLog(@"----- 有通知消息, 增对有通知消息,但是从图标进入程序");
            [ControlCenter sharedInstance].hasNotification = YES;
        }
    }
}

#pragma mark - public method
- (void)didReceiveRemoteNotificationFromBackground {
     [ControlCenter sharedInstance].hasNotification = YES;
}


@end

