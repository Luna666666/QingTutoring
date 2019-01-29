//
//  MineViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/15.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "IdentityInformationViewController.h"
#import "LoginViewController.h"
#define kMineTableViewCellId @"kMineTableViewCellId"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *mineTableView;
@property (nonatomic, strong)UIView *headView;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    self.view.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    [self createTableView];
}
-(void)createTableView{
    self.mineTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    self.mineTableView.showsVerticalScrollIndicator = NO;
    self.mineTableView.showsHorizontalScrollIndicator = NO;
    self.mineTableView.backgroundColor=[UIColor colorWithHex:@"#F5F5F5"];
    self.mineTableView.delegate   = self;
    self.mineTableView.dataSource = self;
    [self.mineTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mineTableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:kMineTableViewCellId];
    self.mineTableView.tableFooterView = [[UIView alloc]init];
    self.mineTableView.showsVerticalScrollIndicator = false;
    self.mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mineTableView.tableHeaderView=self.headView;
    [self.view addSubview:self.mineTableView];
}
#pragma mark -UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *minePageTableViewCell = [tableView dequeueReusableCellWithIdentifier:kMineTableViewCellId];
    if (!minePageTableViewCell) {
        minePageTableViewCell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMineTableViewCellId];
    }
    minePageTableViewCell.itemIcon.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    minePageTableViewCell.itemTitle.text =[NSString stringWithFormat:@"%@",self.titleArray[indexPath.row]];
    return minePageTableViewCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"jjjj");
}
-(NSMutableArray*)titleArray{
    if (!_titleArray) {
        _titleArray=[NSMutableArray arrayWithArray:@[@"消息通知",@"我的收藏",@"我的订单",@"我的课程",@"我的优惠券",@"设置"]];
    }
    return _titleArray;
}
-(NSMutableArray*)imageArray{
    if (!_imageArray) {
        _imageArray=[NSMutableArray arrayWithArray:@[@"mine_notify",@"mine_favorite",@"mine_order",@"mine_subject",@"mine_coupon",@"mine_setting"]];
    }
    return _imageArray;
}
-(UIView *)headView{
    if (!_headView) {
        _headView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,170)];
        _headView.backgroundColor=[UIColor whiteColor];
        _headView.userInteractionEnabled=YES;
        if (GlobalCenter.sharedInstance.isLogin == false){
            //未登录
            UIButton *signIn=[[UIButton alloc]initWithFrame:CGRectMake(22,42,70,20)];
            signIn.backgroundColor = [UIColor colorWithHex:@"#FF9800"];
            [signIn setTitle:@"签到" forState:UIControlStateNormal];
            [signIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            signIn.titleLabel.font = [UIFont systemFontOfSize:12];
            signIn.clipsToBounds=YES;
            signIn.layer.cornerRadius=8;
            [signIn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:signIn];
            UILabel *welcome=[[UILabel alloc]initWithFrame:CGRectMake(22,CGRectGetMaxY(signIn.frame)+10,130,20)];
            welcome.text=[NSString stringWithFormat:@"%@",@"欢迎来到箐箐辅导~"];
            welcome.textColor=[UIColor colorWithHex:@"#2C2D2D"];
            welcome.font=[UIFont systemFontOfSize:12];
            [_headView addSubview:welcome];
    
            UIButton *login=[[UIButton alloc]initWithFrame:CGRectMake(22,CGRectGetMaxY(welcome.frame)+5,70,20)];
            login.backgroundColor = [UIColor colorWithHex:@"#3BAEFD"];
            [login setTitle:@"登录" forState:UIControlStateNormal];
            [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            login.titleLabel.font = [UIFont systemFontOfSize:12];
            login.clipsToBounds=YES;
            login.layer.cornerRadius=8;
            [login addTarget:self action:@selector(loginIn) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:login];
    
            UIImageView *panda = [UIImageView new];
            panda.frame=CGRectMake(CGRectGetMaxX(welcome.frame)+20,46,165,90);
            panda.contentMode=UIViewContentModeScaleAspectFill;
            panda.image=[UIImage imageNamed:@"mine_head_bg"];
            [_headView addSubview:panda];
    
            UIView *underLine=[UIView new];
            underLine.frame=CGRectMake(0,CGRectGetMaxY(panda.frame)+5,SCREEN_WIDTH,10);
            underLine.backgroundColor= [UIColor colorWithHex:@"#F6F6F6"];
            [_headView addSubview:underLine];
        }else{
            //已登录
            UIButton *userHead=[[UIButton alloc]initWithFrame:CGRectMake(30,62,65,65)];
            userHead.clipsToBounds=YES;
            userHead.backgroundColor = [UIColor whiteColor];
            userHead.layer.cornerRadius = 32.5;
            [userHead setBackgroundImage:[UIImage imageNamed:@"mine_master"] forState:UIControlStateNormal];
            [userHead addTarget:self action:@selector(choosePhotosView) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:userHead];
            
            UILabel *phone=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHead.frame)+5,userHead.origin.y+10,90,20)];
            phone.text=[NSString stringWithFormat:@"%@",@"17625902072"];
            phone.textColor=[UIColor colorWithHex:@"#2C2D2D"];
            phone.font=[UIFont systemFontOfSize:12];
            [_headView addSubview:phone];
            
            UIImageView *members = [UIImageView new];
            members.frame=CGRectMake(CGRectGetMaxX(phone.frame),phone.origin.y,15,15);
            members.contentMode=UIViewContentModeScaleAspectFill;
            members.image=[UIImage imageNamed:@"Lv2"];
            [_headView addSubview:members];
            
            UIButton *improveInformation=[[UIButton alloc]initWithFrame:CGRectMake(phone.origin.x,CGRectGetMaxY(phone.frame)+15,70,15)];
            improveInformation.backgroundColor = [UIColor colorWithHex:@"#3BAEFD"];
            [improveInformation setTitle:@"补充资料" forState:UIControlStateNormal];
            [improveInformation  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            improveInformation .titleLabel.font = [UIFont systemFontOfSize:12];
            improveInformation .clipsToBounds=YES;
            improveInformation .layer.cornerRadius=8;
            [improveInformation  addTarget:self action:@selector(improveInformation) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:improveInformation ];
            
            UILabel *grade=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(improveInformation.frame)+5,improveInformation.origin.y-3,57,22)];
            grade.text=[NSString stringWithFormat:@"%@",@"七年级"];
            grade.textColor=[UIColor colorWithHex:@"#A7A7A7"];
            grade.font=[UIFont systemFontOfSize:12];
            [_headView addSubview:grade];
            
            UIView *underGradeLine=[UIView new];
            underGradeLine.frame=CGRectMake(0,CGRectGetMaxY(grade.frame)+35,SCREEN_WIDTH,10);
            underGradeLine.backgroundColor= [UIColor colorWithHex:@"#F6F6F6"];
            [_headView addSubview:underGradeLine];
        }
        
    }
    return _headView;
}
-(void)improveInformation{
    IdentityInformationViewController * identityInformationVC = [[IdentityInformationViewController alloc] init];
    identityInformationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:identityInformationVC animated:YES];
}
-(void)choosePhotosView{
    NSLog(@"choosePhotosView");
}
-(void)signIn{
    NSLog(@"signIn");
}
-(void)loginIn{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}
@end
