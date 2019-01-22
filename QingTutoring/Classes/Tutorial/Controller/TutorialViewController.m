//
//  TutorialViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/15.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "TutorialViewController.h"
#import "IdentityInformationViewController.h"

@interface TutorialViewController ()
@property(nonatomic,strong)ButtonWithTitle * gradeButton;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation];
}
-(void)setNavigation{
     self.navigationItem.title = @"辅导班";
     [self showBarButton:NAV_LEFT button:self.gradeButton];
   
}
- (ButtonWithTitle*)gradeButton{
    if(!_gradeButton){
        _gradeButton = [[ButtonWithTitle alloc]initWithFrame:CGRectMake(0,0,60,30) andImageFrame:CGRectMake(52.5,12.5, 7.5, 7.5) andTitleFrame:CGRectMake(0,7.5,52.5, 15)];
        [_gradeButton setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:@"三年级" andImageName:@"home_down"];
        [_gradeButton addTarget:self action:@selector(selectGrade) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _gradeButton;
}
-(void)selectGrade{
    IdentityInformationViewController * selectGrade =[IdentityInformationViewController new];
    selectGrade.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:selectGrade animated:YES];
}
@end
