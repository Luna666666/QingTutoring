//
//  TutorialDetailViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/30.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "TutorialDetailViewController.h"
#import "MineTableViewCell.h"
#import "Tutorial.h"
#import "HotTutorialCell.h"
#define kTutorialDetailCellId @"kTutorialDetailCellId"

@interface TutorialDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *headView;
@property (nonatomic,strong)NSDictionary *detailDic;//辅导班详情
@property (nonatomic,strong)NSMutableArray *registrationArray;//报名数组
@property (nonatomic,assign)CGFloat totalHeight;
@end

@implementation TutorialDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden =YES;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    [self createTableView];
    [self requestTutorialDetail];
}
-(void)requestTutorialDetail{
    self.detailDic = @{
                       @"tutorialId": @"1",
                       @"tutorialPicture": @"145812834453564157.png",
                       @"subjectName": @"",
                       @"tutorialName": @"3200000000",
                       @"shiziCount": @"10",
                       @"tutorialName": @"2017-12-18",
                       @"certification": @"2017-12-18",
                       @"tutorialCount": @"60"
                       };
    NSDictionary * registration_Dic = @{
                                    @"msg": @"0",
                                    @"results": @[@{
                                                      @"tutorialId": @"1",
                                                      @"tutorialPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"tutorialName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"tutorialName": @"2017-12-18",
                                                      @"certification": @"2017-12-18",
                                                      @"tutorialCount": @"60"
                                                      }, @{
                                                      @"tutorialId": @"1",
                                                      @"tutorialPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"tutorialName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"tutorialName": @"2017-12-18",
                                                      @"certification": @"2017-12-18",
                                                      @"tutorialCount": @"60"
                                                      }, @{
                                                      @"tutorialId": @"1",
                                                      @"tutorialPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"tutorialName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"tutorialName": @"2017-12-18",
                                                      @"certification": @"2017-12-18",
                                                      @"tutorialCount": @"60"
                                                      }, @{
                                                      @"tutorialId": @"1",
                                                      @"tutorialPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"tutorialName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"tutorialName": @"2017-12-18",
                                                      @"certification": @"2017-12-18",
                                                      @"tutorialCount": @"60"
                                                      }, @{
                                                      @"tutorialId": @"1",
                                                      @"tutorialPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"tutorialName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"tutorialName": @"2017-12-18",
                                                      @"certification": @"2017-12-18",
                                                      @"tutorialCount": @"60"
                                                      }]
                                    };
    for (NSDictionary *dict in [registration_Dic objectForKey:@"results"]) {
        Tutorial *model = [Tutorial initWithDict:dict];
        [self.registrationArray addObject:model];
    }
    [self.tableView reloadData];
    
}
-(void)createTableView{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor=[UIColor colorWithHex:@"#F5F5F5"];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[HotTutorialCell class] forCellReuseIdentifier:kTutorialDetailCellId];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView=self.headView;
    [self.view addSubview:self.tableView];
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
    
    return self.registrationArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 185;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotTutorialCell *cell = [tableView dequeueReusableCellWithIdentifier:kTutorialDetailCellId];
    if (!cell) {
        cell=[[HotTutorialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTutorialDetailCellId];
    }
    if (self.registrationArray.count>0) {
        cell.model=self.registrationArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"jjjj");
}
-(NSMutableArray *)registrationArray{
    if (!_registrationArray) {
        _registrationArray = [NSMutableArray array];
    }
    return _registrationArray;
    
}
-(UIView *)headView{
    if (!_headView) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,148+117+73+30)];
        _headView.backgroundColor= [UIColor whiteColor];
        _headView.userInteractionEnabled=YES;
        UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,148)];
        blueView.backgroundColor= [UIColor colorWithHex:@"#3DADFF"];
        blueView.userInteractionEnabled=YES;
        [_headView addSubview:blueView];
        
        ButtonWithTitle *backTutoria = [[ButtonWithTitle alloc]initWithFrame:CGRectMake(10,20,10,20) andImageFrame:CGRectMake(0,0,20,20) andTitleFrame:CGRectZero];
        [backTutoria setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:12] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"17625902072" andImageName:@"home_back"];
        [blueView addSubview:backTutoria];
        UILabel *tutorialName=[[UILabel alloc]initWithFrame:CGRectMake(0,backTutoria.origin.y+15,171,25)];
        tutorialName.center = CGPointMake(_headView.frame.size.width/2,backTutoria.origin.y);
        tutorialName.text=[NSString stringWithFormat:@"%@",@"杨倩倩@思成辅导班"];
        tutorialName.textColor=[UIColor colorWithHex:@"#FFFFFF"];
        tutorialName.font=[UIFont fontWithName:@"PingFang SC" size:14];
        [blueView addSubview:tutorialName];
        
        UILabel *teacherName=[[UILabel alloc]initWithFrame:CGRectMake(backTutoria.origin.x+20,CGRectGetMaxY(tutorialName.frame)+10,195,30)];
        teacherName.text=[NSString stringWithFormat:@"%@",@"杨倩倩.数学辅导一级名师"];
        teacherName.textColor=[UIColor colorWithHex:@"#FFFFFF"];;
        teacherName.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [blueView addSubview:teacherName];
        
        UILabel *ownTutorial=[[UILabel alloc]initWithFrame:CGRectMake(teacherName.origin.x,CGRectGetMaxY(teacherName.frame),110,30)];
        ownTutorial.text=[NSString stringWithFormat:@"%@",@"思成辅导班"];
        ownTutorial.textColor=[UIColor colorWithHex:@"#FFFFFF"];;
        ownTutorial.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [blueView addSubview:ownTutorial];
        
        ButtonWithTitle *certification =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(teacherName.origin.x,CGRectGetMaxY(ownTutorial.frame),95,20) andImageFrame:CGRectMake(0,0,25,20) andTitleFrame:CGRectMake(28,0,70,20)];
        [certification setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:13] andColor:[UIColor colorWithHex:@"#FFFFFF"] andTitle:@"已认证" andImageName:@"home_certification"];
        certification.titleLabel.textAlignment = NSTextAlignmentLeft;
        [blueView addSubview:certification];
        
        UIButton *userHead=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100,teacherName.frame.origin.y,50,50)];
        userHead.clipsToBounds=YES;
        userHead.backgroundColor = [UIColor whiteColor];
        userHead.layer.cornerRadius = 25;
        [userHead setBackgroundImage:[UIImage imageNamed:@"mine_master"] forState:UIControlStateNormal];
        [blueView addSubview:userHead];
        
        UIImageView *members = [UIImageView new];
    members.frame=CGRectMake(CGRectGetMaxX(userHead.frame)-10,CGRectGetMaxY(userHead.frame)-20,15,15);
        members.contentMode=UIViewContentModeScaleAspectFill;
        members.image=[UIImage imageNamed:@"Lv2"];
        [blueView addSubview:members];
        
        UILabel *ownTutorialClass=[[UILabel alloc]initWithFrame:CGRectMake(teacherName.origin.x,CGRectGetMaxY(blueView.frame)+10,89,30)];
        ownTutorialClass.text=[NSString stringWithFormat:@"%@",@"所在辅导班"];
        ownTutorialClass.textColor=[UIColor colorWithHex:@"#101010"];;
        ownTutorialClass.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [_headView addSubview:ownTutorialClass];
        
        UIButton *immediateCommunicate=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-85,ownTutorialClass.frame.origin.y,70,20)];
        immediateCommunicate.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
        [immediateCommunicate setTitle:@"立即沟通" forState:UIControlStateNormal];
        [immediateCommunicate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        immediateCommunicate.clipsToBounds=YES;
        immediateCommunicate.backgroundColor = [UIColor colorWithHex:@"#3DADFF"];
        immediateCommunicate.layer.cornerRadius = 5;
        [_headView addSubview:immediateCommunicate];
        
        UIImageView *companyLogo = [UIImageView new];
    companyLogo.frame=CGRectMake(ownTutorialClass.origin.x,CGRectGetMaxY(ownTutorialClass.frame)+10,50,50);
        companyLogo.clipsToBounds = YES;
        companyLogo.layer.cornerRadius = 7;
        companyLogo.contentMode=UIViewContentModeScaleAspectFill;
        companyLogo.image=[UIImage imageNamed:@"home_companyLogo"];
        [_headView addSubview:companyLogo];
        
        NSArray *title_Array = @[@"思成数学辅导班",@"辅导效率:",@"满意",@"数学",@"师资规模:40人",@"已报名:30人"];
        NSArray *image_Array = @[@"find_hot",@"find_hot",@"find_hot",@"find_hot",@"find_hot",@"find_hot"];
        CGFloat btnHeight = 25;
        for (int i=0; i<title_Array.count; i++) {
        CGFloat width = [Helper widthOfString:title_Array[i] font:[UIFont systemFontOfSize:13] height:20];
        CGFloat btnX = CGRectGetMaxX(companyLogo.frame)+10 + (width + 5) *((i % 3));
        CGFloat btnY =companyLogo.origin.y+ (btnHeight + 1) * ((i / 3));
        UIButton * hotTutorial = [UIButton buttonWithType:UIButtonTypeCustom];
        hotTutorial.frame = CGRectMake(btnX, btnY, width,btnHeight);
        hotTutorial.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
        [hotTutorial setTitleColor:[UIColor colorWithHex:@"#101010"] forState:UIControlStateNormal];
        [hotTutorial setImage:[UIImage imageNamed:image_Array[i]] forState:UIControlStateNormal];
        hotTutorial.tag = 100+i;
            hotTutorial.backgroundColor =[UIColor orangeColor];
        hotTutorial.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, width-10);
        hotTutorial.imageEdgeInsets = UIEdgeInsetsMake(0,width-10,0,10);
        hotTutorial.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:hotTutorial];
        }
        
}
    return _headView;
}
@end
