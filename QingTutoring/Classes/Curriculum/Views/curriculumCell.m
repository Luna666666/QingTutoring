//
//  curriculumCell.m
//  QingTutoring
//
//  Created by Charles on 2019/1/23.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "curriculumCell.h"

@implementation curriculumCell
{
    UIImageView *_tutorialPic;//图片
    UIImageView *_headPic;//头像
    UILabel *_tutorialTeacher;//辅导老师
    ButtonWithTitle *_grade;//科目
    UILabel *_teachersSize;//师资规模
    UILabel *_subjectName;//提升班
    UILabel *_description;//描述
    UIView *_underLine;
  
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _tutorialPic = [UIImageView new];
        _tutorialPic.frame=CGRectMake(10,0,SCREEN_WIDTH-20,80);
        _tutorialPic.contentMode=UIViewContentModeScaleAspectFill;
        _tutorialPic.clipsToBounds = YES;
        _tutorialPic.image=[UIImage imageNamed:@"home_Tutorial"];
        [self addSubview:_tutorialPic];
        
        _headPic = [UIImageView new];
        _headPic.frame=CGRectMake(_tutorialPic.origin.x,CGRectGetMaxY(_tutorialPic.frame)+7,30,30);
        _headPic.contentMode=UIViewContentModeScaleAspectFill;
        _headPic.layer.cornerRadius = _headPic.frame.size.height/2;
        _headPic.clipsToBounds = YES;
        _headPic.image=[UIImage imageNamed:@"home_master"];
        [self addSubview:_headPic];
        
        _tutorialTeacher = [UILabel new];
        _tutorialTeacher.frame=CGRectMake(CGRectGetMaxX(_headPic.frame)+5,_headPic.origin.y,47,26);
        _tutorialTeacher.backgroundColor = [UIColor whiteColor];
        _tutorialTeacher.text=@"王婷婷";
        _tutorialTeacher.textColor= [UIColor colorWithHex:@"#101010"];
        _tutorialTeacher.font =[UIFont fontWithName:@"PingFang SC" size:12];
        _tutorialTeacher.numberOfLines = 1;
        [self addSubview:_tutorialTeacher];
        
        _grade =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_tutorialTeacher.frame),_tutorialTeacher.origin.y+5,42,15) andImageFrame:CGRectZero andTitleFrame:CGRectMake(0,0,42,17)];
        _grade.backgroundColor= [UIColor colorWithHex:@"#585858"];
        _grade.clipsToBounds = YES;
        _grade.layer.cornerRadius = 4;
        [_grade setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:10] andColor:[UIColor whiteColor] andTitle:@"数学" andImageName:@"home_phone"];
        [self addSubview:_grade];
        
        _subjectName = [UILabel new];
         _subjectName.frame=CGRectMake(CGRectGetMaxX(_grade.frame) +5,_headPic.origin.y,200,26);
        _subjectName.text=@"三年级下学期数学提升班";
        _subjectName.textColor= [UIColor colorWithHex:@"#101010"];
        _subjectName.font = [UIFont fontWithName:@"PingFang SC" size:12];
        _subjectName.numberOfLines = 1;
        [self addSubview:_subjectName];
       _description= [UILabel new];
    _description.frame=CGRectMake(_tutorialTeacher.origin.x,CGRectGetMaxY(_subjectName.frame)+3,236,26);
        _description.text=@"三年级7月1号-7月31号 · 每天 ·8:00-18:00";
        _description.textColor= [UIColor colorWithHex:@"#101010"];
        _description.font = [UIFont fontWithName:@"PingFang SC" size:12];
        _description.numberOfLines = 1;
        [self addSubview:_description];
        
        _underLine=[UIView new];
        _underLine.frame=CGRectMake(0,CGRectGetMaxY(_description.frame)+5,SCREEN_WIDTH,1);
        _underLine.backgroundColor= [UIColor colorWithHex:@"#E4E5F0"];
        [self addSubview:_underLine];
        
    }
    return self;
}
-(void)setModel:(curriculum*)model{
    _model = model;
    
    
}

@end
