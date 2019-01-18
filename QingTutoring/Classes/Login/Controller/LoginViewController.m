//
//  LoginViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/15.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "LoginViewController.h"
#import "QingTutoringTabBarViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}
- (IBAction)loginBtnClicked:(UIButton *)sender {
    QingTutoringTabBarViewController *tabBarVC = [QingTutoringTabBarViewController new];
    [App window].rootViewController = tabBarVC;
}


@end
