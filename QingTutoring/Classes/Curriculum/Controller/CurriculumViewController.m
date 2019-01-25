//
//  CurriculumViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/15.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "CurriculumViewController.h"
#import "curriculumCell.h"
#import "curriculum.h"

#define kCurriculumTableViewCellId @"curriculumCellId"

@interface CurriculumViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView * grayBgView;
@property(nonatomic,strong)NSMutableArray<UIButton *> *itemSelectdArray;
@property(nonatomic,assign)NSInteger superIndex;
@property(nonatomic,copy)NSArray<NSArray *> *selectArray;
@property(nonatomic,strong)UIScrollView *selectBgView;
@property (nonatomic, strong)UITableView *curriculumTableView;
@property (nonatomic,strong)NSMutableArray *curriculum_Array;
@end

@implementation CurriculumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程";
    self.view.backgroundColor = [UIColor whiteColor];
    _superIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.grayBgView = [[UIView alloc]initWithFrame:CGRectMake(0,NavigateBarH +40,SCREEN_WIDTH,SCREEN_HEIGHT-64-49)];
    self.grayBgView.backgroundColor = [UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:0.8];
    self.grayBgView.hidden =YES;
    [self.view addSubview:self.grayBgView];
    [self selectView];
    [self createTableView];
    [self requestcurriculumData];
}
-(void)createTableView{
    self.curriculumTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,NavigateBarH+40,SCREEN_WIDTH,SCREEN_HEIGHT-64-49-40) style:UITableViewStylePlain];
    self.curriculumTableView.showsVerticalScrollIndicator = NO;
    self.curriculumTableView.showsHorizontalScrollIndicator = NO;
    self.curriculumTableView.backgroundColor=[UIColor colorWithHex:@"#F5F5F5"];
    self.curriculumTableView.delegate   = self;
    self.curriculumTableView.dataSource = self;
    [self.curriculumTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.curriculumTableView registerClass:[curriculumCell class] forCellReuseIdentifier:kCurriculumTableViewCellId];
    self.curriculumTableView.showsVerticalScrollIndicator = false;
    self.curriculumTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.curriculumTableView];
}
-(void)selectView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,NavigateBarH,SCREEN_WIDTH,40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    NSArray * titleArray=@[@"课程",@"年龄",@"距离"];
    float originalX = 10;
    float width = 100;
    float titleWidth = width-30;
    float space = (SCREEN_WIDTH-300-20)/2.0;
    for (int i=0; i<titleArray.count; i++) {
        ButtonWithTitle *typeBtn =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(originalX+(i)*(width+space),0,width,40) andImageFrame:CGRectMake(titleWidth+5,15,10,10) andTitleFrame:CGRectMake(0,0,titleWidth, 40)];
        [typeBtn setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:titleArray[i] andImageName:@"home_down"];
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
                                           @[@"课程",@"语文",@"数学",@"英语",@"物理",@"化学",@"生物"],
                                           @[@"年龄",@"5-10岁",@"10-15",@"15-20"],
                                           @[@"距离",@"100米以内",@"200米以内",@"300米以内"]];
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
    
    return 145;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.curriculum_Array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    curriculumCell *cell = [tableView dequeueReusableCellWithIdentifier:kCurriculumTableViewCellId];
    if (!cell) {
        cell=[[curriculumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCurriculumTableViewCellId];
    }
    if (self.curriculum_Array.count>0) {
        cell.model=self.curriculum_Array[indexPath.row];
    }
    return cell;
}
-(void)requestcurriculumData{
    NSDictionary * curriculum_Dic = @{
                                    @"msg": @"0",
                                    @"results": @[@{
                                                      @"curriculumId": @"1",
                                                      @"curriculumPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"curriculumName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"phone": @"2017-12-18",
                                                      @"locatation": @"2017-12-18",
                                                      @"curriculumCount": @"60"
                                                      }, @{
                                                      @"curriculumId": @"1",
                                                      @"curriculumPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"curriculumName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"phone": @"2017-12-18",
                                                      @"locatation": @"2017-12-18",
                                                      @"curriculumCount": @"60"
                                                      }, @{
                                                      @"curriculumId": @"1",
                                                      @"curriculumPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"curriculumName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"phone": @"2017-12-18",
                                                      @"locatation": @"2017-12-18",
                                                      @"curriculumCount": @"60"
                                                      }, @{
                                                      @"curriculumId": @"1",
                                                      @"curriculumPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"curriculumName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"phone": @"2017-12-18",
                                                      @"locatation": @"2017-12-18",
                                                      @"curriculumCount": @"60"
                                                      }, @{
                                                      @"curriculumId": @"1",
                                                      @"curriculumPicture": @"145812834453564157.png",
                                                      @"subjectName": @"",
                                                      @"curriculumName": @"3200000000",
                                                      @"shiziCount": @"10",
                                                      @"phone": @"2017-12-18",
                                                      @"locatation": @"2017-12-18",
                                                      @"curriculumCount": @"60"
                                                      }]
                                    };
    for (NSDictionary *dict in [curriculum_Dic objectForKey:@"results"]) {
        curriculum *model = [curriculum initWithDict:dict];
        [self.curriculum_Array addObject:model];
    }
    [self.curriculumTableView reloadData];
    
}
-(void)searchcurriculum{
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
-(NSMutableArray *)curriculum_Array{
    if (!_curriculum_Array) {
        _curriculum_Array = [NSMutableArray array];
    }
    return _curriculum_Array;
    
}

@end
