//
//  QingTutoringQingTutoringPublicViewController.m
//  Nplan
//
//  Created by xpp on 16/12/13.
//  Copyright © 2016年 xpp. All rights reserved.
//

#import "QingTutoringPublicViewController.h"

@interface QingTutoringPublicViewController ()
@property (nonatomic,strong)MBProgressHUD *hud;
@end

@implementation QingTutoringPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.view.backgroundColor = BackgroundColor;
}
- (void)showHudTitleString:(NSString *)hudString
{
    // 显示文字
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = NSLocalizedString(hudString, @"HUD message title");
    hud.margin = 14;
    hud.labelFont = [UIFont systemFontOfSize:14];
    hud.opacity = 0.5;
    [hud hide:YES afterDelay:1.5];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hud;
}

- (void)show{
    [self.view addSubview:self.hud];
   
}

- (void)hidden{
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.childViewControllers.count > 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    return YES;
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if (self.childViewControllers.count == 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (void)showBarButton:(WWNavigationBar)position button:(ButtonWithTitle *)button{
    if (NAV_LEFT == position) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        
    }else if (NAV_RIGHT == position){
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}
@end
