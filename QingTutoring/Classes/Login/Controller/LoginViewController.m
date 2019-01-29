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

@property (weak, nonatomic) IBOutlet UILabel *fudaoTips;
@property (weak, nonatomic) IBOutlet UILabel *fudaoDetail;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *quickLogin;
@property (weak, nonatomic) IBOutlet UIButton *acquireCode;
@property (weak, nonatomic) IBOutlet UILabel *otherLoginWays;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clearWidthLaout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clearHeightLaout;
@property (weak, nonatomic) IBOutlet UILabel *underAccountLine;
@property (weak, nonatomic) IBOutlet UILabel *underPasswordLine;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self createUI];
    
}
-(void)createUI{
    self.accountTF.text = @"17625902072";
    self.verifyCodeTF.text = @"123456";
    self.fudaoTips.textColor =  [UIColor colorWithHex:@"#101010"];
    self.fudaoTips.font = [UIFont fontWithName:@"PingFang SC" size:18];
    self.fudaoDetail.textColor =  [UIColor colorWithHex:@"#101010"];
    self.fudaoDetail.font = [UIFont fontWithName:@"PingFang SC" size:12];
    [self.accountTF setValue:[UIColor colorWithHex:@"#DBDBDB"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.accountTF setValue:[UIFont fontWithName:@"PingFang SC" size:14] forKeyPath:@"_placeholderLabel.font"];
    [self.verifyCodeTF setValue:[UIColor colorWithHex:@"#DBDBDB"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.verifyCodeTF setValue:[UIFont fontWithName:@"PingFang SC" size:14] forKeyPath:@"_placeholderLabel.font"];
    self.acquireCode.backgroundColor = [UIColor colorWithHex:@"#3BAEFD"];
    self.acquireCode.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
    self.quickLogin.backgroundColor = [UIColor colorWithHex:@"#3BAEFD"];
    self.quickLogin.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
    self.otherLoginWays.textColor =  [UIColor colorWithHex:@"#101010"];
    self.otherLoginWays.font = [UIFont fontWithName:@"PingFang SC" size:13];
    self.clearWidthLaout.constant = self.clearWidthLaout.constant-5;
    self.clearHeightLaout.constant = self.clearHeightLaout.constant-5;
    self.underAccountLine.backgroundColor = [UIColor lightGrayColor];
    self.underPasswordLine.backgroundColor = [UIColor lightGrayColor];
}
- (IBAction)loginBtnClicked:(UIButton *)sender {
    QingTutoringTabBarViewController *tabBarVC = [QingTutoringTabBarViewController new];
    [App window].rootViewController = tabBarVC;
}


@end
