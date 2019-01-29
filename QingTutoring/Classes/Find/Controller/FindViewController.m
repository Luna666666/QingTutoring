//
//  FindViewController.m
//  QingTutoring
//
//  Created by Charles on 2019/1/15.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "FindViewController.h"
#import "TutorialCell.h"
#import "Tutorial.h"
#import "FindView.h"

#define kFindTableViewCellId @"findCellId"

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *findTableView;
@property (nonatomic, strong)FindView *findHeadView;
@property (nonatomic,strong)NSMutableArray *find_Array;
@property (nonatomic,strong)NSMutableArray *homeCyclePicArray;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self requestTutorialData];
}
-(void)createTableView{
    self.findTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,NavigateBarH,SCREEN_WIDTH,SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    self.findTableView.showsVerticalScrollIndicator = NO;
    self.findTableView.showsHorizontalScrollIndicator = NO;
    self.findTableView.backgroundColor=[UIColor colorWithHex:@"#F5F5F5"];
    self.findTableView.delegate   = self;
    self.findTableView.dataSource = self;
    [self.findTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.findTableView registerClass:[TutorialCell class] forCellReuseIdentifier:kFindTableViewCellId];
    self.findTableView.tableFooterView = [[UIView alloc]init];
    self.findTableView.showsVerticalScrollIndicator = false;
    self.findTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.findTableView.tableHeaderView = self.findHeadView;
    [self.view addSubview:self.findTableView];
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
        [self.find_Array addObject:model];
    }
    _homeCyclePicArray= [NSMutableArray arrayWithArray:@[
                                                         @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                                         ]];
    self.findHeadView.modFindCycleScrollView.imageURLStringsGroup = _homeCyclePicArray;
    [self.findTableView reloadData];
    
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
    
    return 185;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.find_Array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TutorialCell *cell = [tableView dequeueReusableCellWithIdentifier:kFindTableViewCellId];
    if (!cell) {
        cell=[[TutorialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFindTableViewCellId];
    }
    if (self.find_Array.count>0) {
        cell.model=self.find_Array[indexPath.row];
    }
    return cell;
}
-(NSMutableArray *)find_Array{
    if (!_find_Array) {
        _find_Array = [NSMutableArray array];
    }
    return _find_Array;
    
}
#pragma mark - LazyLoading

-(FindView*)findHeadView{
    if (!_findHeadView) {
        _findHeadView = [[FindView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,138+48)];
        _findHeadView.imageURLStringsGroup=_homeCyclePicArray;
     
    }
    return _findHeadView;
}
-(NSMutableArray*)homeCyclePicArray{
    if (!_homeCyclePicArray) {
        _homeCyclePicArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _homeCyclePicArray;
}
@end
