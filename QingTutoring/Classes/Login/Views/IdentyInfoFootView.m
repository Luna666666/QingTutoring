//
//  IdentyInfoFootView.m
//  QingTutoring
//
//  Created by Charles on 2019/1/18.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "IdentyInfoFootView.h"

@implementation IdentyInfoFootView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.identyFootView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,10)];
    self.identyFootView.backgroundColor = [UIColor colorWithHex:@"#F6F6F6"];
    self.identyFootView.hidden = YES;
    [self addSubview:self.identyFootView];
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,CGRectGetMaxY(self.identyFootView.frame));
   
}
@end
