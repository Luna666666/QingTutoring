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
    self.identySelectView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,42)];
    self.identySelectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.identySelectView];
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,CGRectGetMaxY(self.identySelectView.frame));
    UILabel * selectIdentyLB =[[UILabel alloc]initWithFrame:CGRectMake(10,0,SCREEN_WIDTH,41)];
    selectIdentyLB.text = @"请选择您的身份以提供最佳服务";
    self.selectIdentyLB = selectIdentyLB;
    selectIdentyLB.textColor =[UIColor colorWithHex:@"#101010"];
    selectIdentyLB.font =[UIFont systemFontOfSize:16];
    [self.identySelectView addSubview:selectIdentyLB];
    
    UIView *underSelectLine =[[UIView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(selectIdentyLB.frame),SCREEN_WIDTH,1)];
    underSelectLine.backgroundColor = [UIColor lightGrayColor];
    self.underSelectLine = underSelectLine;
    underSelectLine.hidden = YES;
    [self.identySelectView addSubview:underSelectLine];
}
@end
