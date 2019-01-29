//
//  IdentyInfoHeadView.m
//  QingTutoring
//
//  Created by Charles on 2019/1/18.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "IdentyInfoHeadView.h"

@implementation IdentyInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.identySelectView = [[UIView alloc]initWithFrame:CGRectMake(10,0,SCREEN_WIDTH,37)];
    self.identySelectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.identySelectView];
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,CGRectGetMaxY(self.identySelectView.frame));
    UILabel * selectIdentyLB =[[UILabel alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,33)];
    selectIdentyLB.text = @"请选择您的身份以提供最佳服务";
    self.selectIdentyLB = selectIdentyLB;
    selectIdentyLB.textColor =[UIColor colorWithHex:@"#101010"];
    selectIdentyLB.font =[UIFont fontWithName:@"PingFang SC" size:13];
    [self.identySelectView addSubview:selectIdentyLB];
    
    UIView *underSelectLine =[[UIView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(selectIdentyLB.frame)+3,SCREEN_WIDTH,1)];
    underSelectLine.backgroundColor = [UIColor colorWithHex:@"#F6F6F6"];
    self.underSelectLine = underSelectLine;
    underSelectLine.hidden = YES;
    [self.identySelectView addSubview:underSelectLine];
}
@end
