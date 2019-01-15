//
//  QingTutoringPublicReusableView.m
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/30.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import "QingTutoringPublicReusableView.h"

@implementation QingTutoringPublicReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, 22,120, 20)];
        self.title.font=[UIFont boldSystemFontOfSize:14];
        self.title.textColor =[UIColor colorWithHex:@"#40464D"];
        self.dragTips=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.title.frame),25,120,17)];
        self.dragTips.font=[UIFont systemFontOfSize:12];
        self.dragTips.textColor=[UIColor colorWithHex:@"#999999"];
        
        self.applicationEdit = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70,20,50,20)];
        [self.applicationEdit setTitle:@"编辑" forState:UIControlStateNormal];
        self.applicationEdit.layer.borderWidth=1;
        self.applicationEdit.titleLabel.font=[UIFont systemFontOfSize:12];
        [self.applicationEdit setTitleColor:[UIColor colorWithHex:@"#1B75E0"] forState:UIControlStateNormal];
        self.applicationEdit.layer.borderColor=[UIColor colorWithHex:@"#1B75E0"].CGColor;
        [self.applicationEdit addTarget:self action:@selector(goApplicationEditActions:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.applicationEdit];
        [self addSubview:self.title];
        [self addSubview:self.dragTips];
        
    }
    return self;
}
-(void)goApplicationEditActions:(UIButton*)sender{
    NSLog(@"ss");
    if ([_delegate respondsToSelector:@selector(selectModQingTutoringPublicReusableView:modQingTutoringPublicReusableViewCenterAction:)]){
        [_delegate selectModQingTutoringPublicReusableView:self modQingTutoringPublicReusableViewCenterAction:sender];
    }
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [self.applicationEdit hitTest:[self.applicationEdit convertPoint:point fromView:self] withEvent:event];
    if (view == nil) {
        view = [super hitTest:point withEvent:event];
    }
    return view;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if ([super pointInside:point withEvent:event]) {
        return YES;
    }
    //Check to see if it is within the delete button
    return !self.applicationEdit.hidden && [self.applicationEdit pointInside:[self.applicationEdit convertPoint:point fromView:self] withEvent:event];
}
@end
