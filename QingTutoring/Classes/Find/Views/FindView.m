//
//  FindView.m
//  QingTutoring
//
//  Created by Charles on 2019/1/29.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "FindView.h"

@implementation FindView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.userInteractionEnabled=YES;
        [self addSubViews];
//        [self requestCycleData];
        
    }
    return self;
}
-(void)addSubViews{
    [self addSubview:self.modFindCycleScrollView];
    [self addSubview:self.hotTutorial];
    [self addSubview:self.moreTutorial];
   
}
#pragma mark - LazyLoading

-(SDCycleScrollView*)modFindCycleScrollView{
    if (!_modFindCycleScrollView) {
        _modFindCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,10,SCREEN_WIDTH,138) delegate:self placeholderImage:[UIImage imageNamed:@"find_banner"]];
        _modFindCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _modFindCycleScrollView.imageURLStringsGroup=_imageURLStringsGroup;
        _modFindCycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    return _modFindCycleScrollView;
}
- (ButtonWithTitle*)hotTutorial{
    if(!_hotTutorial){
        _hotTutorial = [[ButtonWithTitle alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_modFindCycleScrollView.frame)+3,115,30) andImageFrame:CGRectMake(100,7.5,15,15) andTitleFrame:CGRectMake(0,0,100,30)];
        [_hotTutorial setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:14] andColor:[UIColor colorWithHex:@"#313131"] andTitle:@"热门辅导班" andImageName:@"find_hot"];
        
    }
    return _hotTutorial;
}
- (ButtonWithTitle*)moreTutorial{
    if(!_moreTutorial){
        _moreTutorial = [[ButtonWithTitle alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60,CGRectGetMaxY(_modFindCycleScrollView.frame)+3,55,26) andImageFrame:CGRectMake(40,5.5,15,15) andTitleFrame:CGRectMake(0,0,40,26)];
        [_moreTutorial setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:13] andColor:[UIColor colorWithHex:@"#BBBBBB"] andTitle:@"更多" andImageName:@"mine_arrow"];
        [_moreTutorial addTarget:self action:@selector(moreTutorialClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _moreTutorial;
}
-(void)requestCycleData{
    _imageURLStringsGroup= @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
}
#pragma mark--btnClicked
-(void)moreTutorialClicked:(UIButton*)sender{
    NSLog(@"sss");
    
}

@end
