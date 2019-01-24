//
//  TutorialViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/15.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "TutorialViewController.h"
#import "IdentityInformationViewController.h"
#import "TutorialCell.h"
#import "Tutorial.h"
#define kTutorialTableViewCellId @"tutorialCellId"

@interface TutorialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ButtonWithTitle * gradeButton;
@property(nonatomic,strong)ButtonWithTitle * searchButton;
@property(nonatomic,strong)UIView * grayBgView;
@property(nonatomic,strong)NSMutableArray<UIButton *> *itemSelectdArray;
@property(nonatomic,assign)NSInteger superIndex;
@property(nonatomic,copy)NSArray<NSArray *> *selectArray;
@property(nonatomic,strong)UIScrollView *selectBgView;
@property (nonatomic, strong)UITableView *tutorialTableView;
@property (nonatomic,strong)NSMutableArray *tutorial_Array;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _superIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.grayBgView = [[UIView alloc]initWithFrame:CGRectMake(0,NavigateBarH +40,SCREEN_WIDTH,SCREEN_HEIGHT-64-49)];
    self.grayBgView.backgroundColor = [UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:0.8];
    self.grayBgView.hidden =YES;
    [self.view addSubview:self.grayBgView];
    [self setNavigation];
    [self selectView];
    [self createTableView];
    [self requestTutorialData];
    
}
-(void)createTableView{
    self.tutorialTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,NavigateBarH+40,SCREEN_WIDTH,SCREEN_HEIGHT-64-49-40) style:UITableViewStylePlain];
    self.tutorialTableView.showsVerticalScrollIndicator = NO;
    self.tutorialTableView.showsHorizontalScrollIndicator = NO;
    self.tutorialTableView.backgroundColor=[UIColor colorWithHex:@"#F5F5F5"];
    self.tutorialTableView.delegate   = self;
    self.tutorialTableView.dataSource = self;
    [self.tutorialTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tutorialTableView registerClass:[TutorialCell class] forCellReuseIdentifier:kTutorialTableViewCellId];
    self.tutorialTableView.tableFooterView = [[UIView alloc]init];
    self.tutorialTableView.showsVerticalScrollIndicator = false;
    self.tutorialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tutorialTableView];
}
-(void)selectView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,NavigateBarH,SCREEN_WIDTH,40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    NSArray * titleArray=@[@"推荐",@"距离",@"年龄",@"课程"];
    float originalX = 10;
    float width = 60;
    float titleWidth = width-10;
    float space = (SCREEN_WIDTH-240-20)/3.0;
    for (int i=0; i<titleArray.count; i++) {
        ButtonWithTitle *typeBtn =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(originalX+(i)*(width+space),0,width,40) andImageFrame:CGRectMake(titleWidth+5,30/2.0+5,5,5) andTitleFrame:CGRectMake(0,0,titleWidth, 40)];
        [typeBtn setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:titleArray[i] andImageName:@"home_down-select"];
        [typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        typeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        typeBtn.tag = 100+i;
        [bgView addSubview:typeBtn];
        UIScrollView * selectBgView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,NavigateBarH + 40, SCREEN_WIDTH,0)];
        selectBgView.tag = 1000+i;
        selectBgView.clipsToBounds=true;
        selectBgView.backgroundColor= [UIColor  whiteColor];
        [self.view addSubview:selectBgView];
        NSArray<NSArray *> *selectArray = @[
                           @[@"推荐"],
                           @[@"距离",
                            @"100米以内",
                            @"200米以内",
                            @"300米以内"],
                           @[@"年龄",@"5-10岁",@"10-15",@"15-20"],
                           @[@"课程",@"语文",@"数学",@"英语",@"物理",@"化学",@"生物"]
                           ];
        self.selectArray = selectArray;
        for (int j=0; j<selectArray[i].count; j++) {
            UIButton *btn =[ViewManager createBtnWithFrame:CGRectMake(0,j*30,SCREEN_WIDTH,30) andTitle:selectArray[i][j] andBgImageName:nil andTarget:self andAction:@selector(selectBtnClick:)];
            btn.tag = 100*(i+2)+j;
            btn.titleLabel.font =[UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (j==0) {
                [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
                [self.itemSelectdArray appendObject:btn];
            }
            [selectBgView addSubview:btn];
            UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0,(j+1)*30-1,SCREEN_WIDTH, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
            [selectBgView addSubview:lineView];
        }
        selectBgView.contentSize =CGSizeMake(SCREEN_WIDTH,(selectArray[i].count)*30);
        }
     UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0,39,SCREEN_WIDTH, 1)];
     lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
     [bgView addSubview:lineView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tutorial_Array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TutorialCell *cell = [tableView dequeueReusableCellWithIdentifier:kTutorialTableViewCellId];
    if (!cell) {
        cell=[[TutorialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTutorialTableViewCellId];
    }
    if (self.tutorial_Array.count>0) {
        cell.model=self.tutorial_Array[indexPath.row];
    }
    return cell;
}
-(void)setNavigation{
     self.navigationItem.title = @"辅导班";
     [self showBarButton:NAV_LEFT button:self.gradeButton];
     [self showBarButton:NAV_RIGHT button:self.searchButton];
    
   
}
-(void)requestTutorialData{
    NSDictionary * tutorial_Dic = @{
        @"msg": @"0",
        @"results": @[@{
                @"tutorialId": @"1",
                @"tutorialPicture": @"145812834453564157.png",
                @"subjectName": @"",
                @"tutorialName": @"3200000000",
                @"shiziCount": @"10",
                @"phone": @"2017-12-18",
                @"locatation": @"2017-12-18",
                @"tutorialCount": @"60"
        }, @{
              @"tutorialId": @"1",
              @"tutorialPicture": @"145812834453564157.png",
              @"subjectName": @"",
              @"tutorialName": @"3200000000",
              @"shiziCount": @"10",
              @"phone": @"2017-12-18",
              @"locatation": @"2017-12-18",
              @"tutorialCount": @"60"
        }, @{
              @"tutorialId": @"1",
              @"tutorialPicture": @"145812834453564157.png",
              @"subjectName": @"",
              @"tutorialName": @"3200000000",
              @"shiziCount": @"10",
              @"phone": @"2017-12-18",
              @"locatation": @"2017-12-18",
              @"tutorialCount": @"60"
        }, @{
              @"tutorialId": @"1",
              @"tutorialPicture": @"145812834453564157.png",
              @"subjectName": @"",
              @"tutorialName": @"3200000000",
              @"shiziCount": @"10",
              @"phone": @"2017-12-18",
              @"locatation": @"2017-12-18",
              @"tutorialCount": @"60"
        }, @{
              @"tutorialId": @"1",
              @"tutorialPicture": @"145812834453564157.png",
              @"subjectName": @"",
              @"tutorialName": @"3200000000",
              @"shiziCount": @"10",
              @"phone": @"2017-12-18",
              @"locatation": @"2017-12-18",
              @"tutorialCount": @"60"
            }]
        };
    for (NSDictionary *dict in [tutorial_Dic objectForKey:@"results"]) {
        Tutorial *model = [Tutorial initWithDict:dict];
        [self.tutorial_Array addObject:model];
    }
    [self.tutorialTableView reloadData];
    
}

-(void)selectGrade{
    IdentityInformationViewController * selectGrade =[IdentityInformationViewController new];
    selectGrade.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:selectGrade animated:YES];
}
-(void)searchTutorial{
    NSLog(@"开始搜索");
}
-(void)typeBtnClick:(ButtonWithTitle*)btn{
    [self.view bringSubviewToFront:self.grayBgView];
    NSInteger index = btn.tag-100;
    self.superIndex = index;
    NSInteger count = self.selectArray[index].count;
    float height = count * 30;
    if (height > 300)
    {
        height = 300;
    }
    UIScrollView *selectBgView =(UIScrollView*)[self.view viewWithTag:index+1000];
    [self.view bringSubviewToFront:selectBgView];
    if (self.selectBgView == nil)//都是收起状态，将直接展开
    {
        
        self.grayBgView.hidden = false;
        self.selectBgView = selectBgView;
        [UIView animateWithDuration:0.5 animations:^{
            selectBgView.frame = CGRectMake(0,NavigateBarH + 40,SCREEN_WIDTH,height);
        }];
    }
    else if (self.selectBgView == selectBgView)//点击同一个
    {
        self.grayBgView.hidden=true;
        self.selectBgView = nil;
        [UIView animateWithDuration:0.5 animations:^{
            selectBgView.frame = CGRectMake(0,NavigateBarH +40,SCREEN_WIDTH,0);
        }];
        
    }else{
        self.selectBgView.frame = CGRectMake(0,NavigateBarH +40,SCREEN_WIDTH,0);
        self.selectBgView = selectBgView;
        [UIView animateWithDuration:0.5 animations:^{
            selectBgView.frame = CGRectMake(0,NavigateBarH + 40,SCREEN_WIDTH,height);
        }];
    }
}
-(void)selectBtnClick:(UIButton*)btn{
    
    
}
- (ButtonWithTitle*)gradeButton{
    if(!_gradeButton){
        _gradeButton = [[ButtonWithTitle alloc]initWithFrame:CGRectMake(0,0,60,30) andImageFrame:CGRectMake(52.5,12.5, 7.5, 7.5) andTitleFrame:CGRectMake(0,7.5,52.5, 15)];
        [_gradeButton setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:@"三年级" andImageName:@"home_right_down"];
        [_gradeButton addTarget:self action:@selector(selectGrade) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _gradeButton;
}
- (ButtonWithTitle*)searchButton{
    if(!_searchButton){
        _searchButton = [[ButtonWithTitle alloc]initWithFrame:CGRectMake(0,0,15,15) andImageFrame:CGRectMake(0,0,15,15) andTitleFrame:CGRectMake(0,0,0,0)];
        [_searchButton setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:@"" andImageName:@"home_search"];
        [_searchButton addTarget:self action:@selector(searchTutorial) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _searchButton;
}
-(NSMutableArray *)tutorial_Array{
    if (!_tutorial_Array) {
        _tutorial_Array = [NSMutableArray array];
    }
    return _tutorial_Array;
    
}
@end
