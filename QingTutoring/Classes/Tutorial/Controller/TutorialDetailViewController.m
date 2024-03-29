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
static const CGFloat MJDuration = 1.0;
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
    // 下拉刷新
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.registrationArray removeAllObjects];
        [self requestTutorialDetail];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    [self.tableView.mj_header beginRefreshing];
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
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    
}
-(void)createTableView{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,statusBarH,SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
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
    return 70;
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
        
        ButtonWithTitle *backTutoria = [[ButtonWithTitle alloc]initWithFrame:CGRectMake(10,20,20,20) andImageFrame:CGRectMake(0,0,20,20) andTitleFrame:CGRectZero];
        [backTutoria addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
        [backTutoria setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:12] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"17625902072" andImageName:@"home_back"];
        [blueView addSubview:backTutoria];
        UILabel *tutorialName=[[UILabel alloc]initWithFrame:CGRectMake(0,backTutoria.frame.origin.y+15,171,25)];
        tutorialName.center = CGPointMake(_headView.frame.size.width/2,backTutoria.frame. origin.y);
        tutorialName.text=[NSString stringWithFormat:@"%@",@"杨倩倩@思成辅导班"];
        tutorialName.textColor=[UIColor whiteColor];
        tutorialName.font=[UIFont fontWithName:@"PingFang SC" size:14];
        [blueView addSubview:tutorialName];
        
        UILabel *teacherName=[[UILabel alloc]initWithFrame:CGRectMake(backTutoria.frame.origin.x+20,CGRectGetMaxY(tutorialName.frame)+10,195,30)];
        teacherName.text=[NSString stringWithFormat:@"%@",@"杨倩倩.数学辅导一级名师"];
        teacherName.textColor=[UIColor whiteColor];
        
        teacherName.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [blueView addSubview:teacherName];
        
        UILabel *ownTutorial=[[UILabel alloc]initWithFrame:CGRectMake(teacherName.frame.origin.x,CGRectGetMaxY(teacherName.frame),110,30)];
        ownTutorial.text=[NSString stringWithFormat:@"%@",@"思成辅导班"];
        ownTutorial.textColor=[UIColor whiteColor];;
        ownTutorial.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [blueView addSubview:ownTutorial];
        
        ButtonWithTitle *certification =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(teacherName.frame.origin.x,CGRectGetMaxY(ownTutorial.frame),95,20) andImageFrame:CGRectMake(0,3,20,17) andTitleFrame:CGRectMake(28,0,70,20)];
        [certification setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:13] andColor:[UIColor whiteColor] andTitle:@"已认证" andImageName:@"home_certification"];
        certification.titleLabel.textAlignment = NSTextAlignmentLeft;
        [blueView addSubview:certification];
        
        UIButton *userHead=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100,teacherName.frame.origin.y,50,50)];
        userHead.clipsToBounds=YES;
        userHead.backgroundColor = [UIColor whiteColor];
        userHead.layer.cornerRadius = 25;
        [userHead setBackgroundImage:[UIImage imageNamed:@"home_master"] forState:UIControlStateNormal];
        [blueView addSubview:userHead];
        
        UIImageView *members = [UIImageView new];
        members.frame=CGRectMake(CGRectGetMaxX(userHead.frame)-10,CGRectGetMaxY(userHead.frame)-20,20,20);
        members.contentMode=UIViewContentModeScaleAspectFill;
        members.image=[UIImage imageNamed:@"home_member"];
        [blueView addSubview:members];
        
        UILabel *ownTutorialClass=[[UILabel alloc]initWithFrame:CGRectMake(teacherName.frame.origin.x,CGRectGetMaxY(blueView.frame)+10,89,20)];
        ownTutorialClass.text=[NSString stringWithFormat:@"%@",@"所在辅导班"];
        ownTutorialClass.textColor=[UIColor colorWithHex:@"#101010"];;
        ownTutorialClass.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [_headView addSubview:ownTutorialClass];
        
        UIButton *immediateCommunicate=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-85,ownTutorialClass.frame.origin.y,70,20)];
        immediateCommunicate.titleLabel.font = [UIFont systemFontOfSize:12];
        [immediateCommunicate setTitle:@"立即沟通" forState:UIControlStateNormal];
        [immediateCommunicate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        immediateCommunicate.clipsToBounds=YES;
        immediateCommunicate.backgroundColor = [UIColor colorWithHex:@"#3DADFF"];
        immediateCommunicate.layer.cornerRadius = 5;
        [_headView addSubview:immediateCommunicate];
        
        UIImageView *companyLogo = [UIImageView new];
        companyLogo.frame=CGRectMake(ownTutorialClass.frame.origin.x,CGRectGetMaxY(ownTutorialClass.frame)+10,50,50);
        companyLogo.clipsToBounds = YES;
        companyLogo.layer.cornerRadius = 7;
        companyLogo.contentMode=UIViewContentModeScaleAspectFill;
        companyLogo.image=[UIImage imageNamed:@"home_companyLogo"];
        [_headView addSubview:companyLogo];
        
        NSArray *title_Array = @[@"思成数学辅导班",@"辅导效率:",@"满意",@"数学",@"师资规模:40人",@"已报名:30人"];
        NSArray *image_Array = @[@"",@"find_hot",@"home_satisfy",@"",@"home_shuxian",@"home_shuxian"];
        [self addTagBtnsToHeadView:_headView
                            titles:title_Array
                            images:image_Array
                        beginPoint:CGPointMake(CGRectGetMaxX(companyLogo.frame) +10,
                                               CGRectGetMinY(companyLogo.frame))];
        
        UIView *underLine=[UIView new];
        underLine.frame=CGRectMake(companyLogo.frame.origin.x,_totalHeight+15,SCREEN_WIDTH,1);
        underLine.backgroundColor= [UIColor colorWithHex:@"#E4E5F0"];
        [_headView addSubview:underLine];
        
        ButtonWithTitle *publishedCourse =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(companyLogo.frame.origin.x,CGRectGetMaxY(underLine.frame)+10,100,20) andImageFrame:CGRectMake(0,0,20,20) andTitleFrame:CGRectMake(26,0,80,20)];
        [publishedCourse setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:13] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"她发布的课程" andImageName:@"home_subject"];
        publishedCourse.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:publishedCourse];
        
        ButtonWithTitle *moreCourse =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-55,publishedCourse.frame.origin.y,55,26) andImageFrame:CGRectMake(0,0,0,0) andTitleFrame:CGRectMake(0,0,55,26)];
        [moreCourse setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:13] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"更多" andImageName:@""];
        moreCourse.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:moreCourse];
        
        ButtonWithTitle *gradeClass =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(publishedCourse.frame.origin.x,CGRectGetMaxY(publishedCourse.frame)+8,70,25) andImageFrame:CGRectMake(0,0,0,0) andTitleFrame:CGRectMake(0,0,70,25)];
        [gradeClass setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:13] andColor:[UIColor colorWithHex:@"#090909"] andTitle:@"七年级数学" andImageName:@""];
        gradeClass.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:gradeClass];
        
        ButtonWithTitle *price =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70,gradeClass.frame.origin.y,55,26) andImageFrame:CGRectMake(0,0,0,0) andTitleFrame:CGRectMake(0,0,55,26)];
        [price setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:13] andColor:[UIColor colorWithHex:@"#E51C23"] andTitle:@"100￥/期" andImageName:@""];
        price.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:price];
        
        NSArray *information_Array = @[@"南京雨花台区",@"6-17岁",@"剩余:7名额"];
        NSArray *information_image_Array = @[@"home_locate",@"home_tioajian",@"home_remain"];
        [self addTagBtnsToHeadView:_headView
                            titles:information_Array
                            images:information_image_Array
                        beginPoint:CGPointMake(gradeClass.frame.origin.x,
                                               CGRectGetMaxY(price.frame)+5)];
        UIView *underLocationLine=[UIView new];
        underLocationLine.frame=CGRectMake(companyLogo.frame.origin.x,_totalHeight+13,SCREEN_WIDTH,1);
        underLocationLine.backgroundColor= [UIColor colorWithHex:@"#E4E5F0"];
        [_headView addSubview:underLocationLine];
        
        
        
        
        
        
}
    return _headView;
}


- (void)addTagBtnsToHeadView:(UIView *)toHeadView
                      titles:(NSArray *)titles
                      images:(NSArray *)images
                  beginPoint:(CGPoint)beginPoint {
    if (!titles || titles.count != images.count || titles.count == 0) {
        NSLog(@"titles has no data...");
        return;
    }
    
    UIFont *font = [UIFont fontWithName:@"PingFang SC" size:13];
    UIColor *color = [UIColor colorWithHex:@"#101010"];
    CGFloat btnHeight = 25;
    CGFloat offsetX = beginPoint.x;
    CGFloat offsetY = beginPoint.y;
    CGFloat marginX = 8;
    CGFloat marginT = 1;
    CGFloat lastBtnRight = 0;
    CGFloat lastBtnTop = 0;
    CGFloat margin = 15;
    CGFloat maxWidth = CGRectGetWidth(toHeadView.frame) -margin/3.0;
    
    CGFloat imageExtendW = 20;
    
    NSInteger index = 0;
    for (NSString *title in titles) {
        CGFloat width = [Helper widthOfString:title font:[UIFont systemFontOfSize:13] height:20] + imageExtendW;
        
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        if (index == 0) {
            btnX = offsetX;
            btnY = offsetY;
            lastBtnTop = btnY;
        }else if ((lastBtnRight + marginX + width) <= maxWidth) {
            btnX = lastBtnRight + marginX;
            btnY = lastBtnTop;
        }else { //换行
            btnX = offsetX;
            btnY = lastBtnTop + marginT + btnHeight;
            lastBtnTop = btnY;
            lastBtnRight = btnX;
        }
        lastBtnRight = btnX + width;
        
        UIButton * hotTutorial = [UIButton buttonWithType:UIButtonTypeCustom];
        hotTutorial.frame = CGRectMake(btnX, btnY, width,btnHeight);
        hotTutorial.tag = 100+index;
        hotTutorial.titleLabel.font = font;
        [hotTutorial setTitleColor:color forState:UIControlStateNormal];
        [hotTutorial setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
        [hotTutorial setTitle:title forState:UIControlStateNormal];
        
        hotTutorial.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:hotTutorial];
        
        index ++;
        if (index ==titles.count-1) {
            _totalHeight = CGRectGetMaxY(hotTutorial.frame);
            NSLog(@"totalHeight:%f",_totalHeight);
        }
    }
}
#pragma mark-btnClicked
-(void)backHome{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
