//
//  HotTutorialCell.m
//  QingTutoring
//
//  Created by Charles on 2019/1/30.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "HotTutorialCell.h"

@implementation HotTutorialCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        UIImageView * headPic= [UIImageView new];
        headPic.frame=CGRectMake(20,10,35,35);
        headPic.contentMode=UIViewContentModeScaleAspectFill;
        headPic.layer.cornerRadius = headPic.frame.size.height/2;
        headPic.clipsToBounds = YES;
        headPic.image=[UIImage imageNamed:@"home_master"];
        [self addSubview:headPic];
        
        UILabel *tutorialName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headPic.frame)+5,10,130,27)];
        tutorialName.text=[NSString stringWithFormat:@"%@",@"思成七年级辅导班"];
        tutorialName.textColor=[UIColor colorWithHex:@"#101010"];
        tutorialName.font=[UIFont systemFontOfSize:14];
        [self addSubview:tutorialName];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60,tutorialName.origin.y,50,25)];
        time.text=[NSString stringWithFormat:@"%@",@"刚刚"];
        time.textColor=[UIColor colorWithHex:@"#4C494D"];
        time.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [self addSubview:time];
        
        UILabel *signUp=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headPic.frame),CGRectGetMaxY(tutorialName.frame),80,20)];
        signUp.text=[NSString stringWithFormat:@"%@",@"杨志凯报了名"];
        signUp.textColor=[UIColor colorWithHex:@"#4C494D"];
        signUp.font=[UIFont fontWithName:@"PingFang SC" size:12];
        [self addSubview:signUp];
        
       UIView* underLine=[UIView new];
        underLine.frame=CGRectMake(30,CGRectGetMaxY(signUp.frame)+5,SCREEN_WIDTH,1);
        underLine.backgroundColor= [UIColor colorWithHex:@"#E4E5F0"];
        [self addSubview:underLine];
        
        
        
    }
    return self;
}
-(void)setModel:(Tutorial*)model{
    _model = model;
    
    
}

@end
