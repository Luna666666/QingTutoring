//
//  QingTutoringTabBarViewController.m
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/29.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import "QingTutoringTabBarViewController.h"
#import "QingTutoringNavigationController.h"
#import "TutorialViewController.h"
#import "CurriculumViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"

@interface QingTutoringTabBarViewController ()
@end

@implementation QingTutoringTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TutorialViewController * tutorialVC = [[TutorialViewController alloc]init];
    tutorialVC.tabBarItem.title = @"辅导班";
    
    CurriculumViewController *curriculumVC  = [[CurriculumViewController alloc]init];
    curriculumVC.tabBarItem.title = @"课程";
    
    FindViewController *findVC  = [[FindViewController alloc]init];
    findVC.tabBarItem.title = @"发现";
    
    MineViewController * myVC = [[MineViewController alloc]init];
    myVC.tabBarItem.title = @"未登录";
    if (GlobalCenter.sharedInstance.isLogin == true) {
        myVC.tabBarItem.title = @"我的";
    }else{
        myVC.tabBarItem.title = @"未登录";
    }
    self.viewControllers = @[
                             [self setNavWithVC:tutorialVC imgName:@"tutoring_tab" selectImgName:@"tutoring_tab-select"],
                             [self setNavWithVC:curriculumVC imgName:@"course_tab" selectImgName:@"course_tab_select"],
                             [self setNavWithVC:findVC imgName:@"found_tab" selectImgName:@"found_tab_select"],
                             [self setNavWithVC:myVC imgName:@"my_tab" selectImgName:@"my_tab_select"],
                             ];
    UITabBar *bar = self.tabBar;
    bar.tintColor =[UIColor colorWithRed:0.082 green:0.188 blue:0.325 alpha:1.00];
    for(UITabBarItem *item in bar.items)
    {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithHex:@"#9A9FA4"]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithHex:@"#9A9FA4"]} forState:UIControlStateSelected];
        if(item.title.length < 1)
        {
            item.enabled = NO;
        }
    }
}

- (UINavigationController *)setNavWithVC:(UIViewController *)VC imgName:(NSString *)imgName selectImgName:(NSString *)selectImgName
{
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:VC];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:VC.tabBarItem.title image:[self removeRendering:imgName] selectedImage:[self removeRendering:selectImgName]];
    if ([VC.tabBarItem.title isEqualToString:@"消息"]) {
      item2.badgeValue=[NSString stringWithFormat:@"%d",12];
    }
    nav.tabBarItem=item2;
    return nav;
}

- (UIImage *)removeRendering:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)chageTheTabBar:(NSNotification *)notification {
    NSString *index = notification.object[@"index"];
    self.selectedIndex = [index integerValue];
}
@end
