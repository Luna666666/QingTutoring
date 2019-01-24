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
    UIImageView *_teacherPic;
    UILabel *_teacherName;
    UILabel *_curriculumName;//课程名称
    UILabel *_teachersSize;//师资规模
    ButtonWithTitle*_subject;//科目名称
    UILabel *_grade;//年级
    UILabel *_curriculumTime;//课程截止时间
    UILabel *_curriculumDescription;//课程描述
    UIView *_underLine;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _teacherPic = [UIImageView new];
        _teacherPic.frame=CGRectMake(20,12,40,40);
        _teacherPic.clipsToBounds = YES;
        _teacherPic.layer.cornerRadius = 20;
        _teacherPic.contentMode=UIViewContentModeScaleAspectFill;
        _teacherPic.clipsToBounds = YES;
        _teacherPic.image=[UIImage imageNamed:@"home_master"];
        [self addSubview:_teacherPic];
        
        _teacherName = [UILabel new];
        _teacherName.frame=CGRectMake(CGRectGetMaxX(_teacherPic.frame)+5,12,60,35);
        _teacherName.text=@"王婷婷";
        _teacherName.font =[UIFont systemFontOfSize:14];
        _teacherName.textColor = [UIColor colorWithHex:@"#585858"];
        [self addSubview:_teacherName];
        
        _curriculumName = [UILabel new];
        _curriculumName.frame=CGRectMake(CGRectGetMaxX(_teacherName.frame)+26,_teacherName.frame.origin.y,180,35);
        _curriculumName.text=@"三年级数学下学期提升班";
        _curriculumName.textColor= [UIColor colorWithHex:@"#101010"];
        _curriculumName.font =[UIFont systemFontOfSize:14];
        _curriculumName.numberOfLines = 1;
        [self addSubview:_curriculumName];
        
        _subject =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(_teacherPic.frame.origin.x,CGRectGetMaxY(_teacherPic.frame)+5,46,15) andImageFrame:CGRectZero andTitleFrame:CGRectMake(0,0,46,15)];
        _subject.clipsToBounds = YES;
        _subject.layer.cornerRadius = 6;
        _subject.backgroundColor = [UIColor colorWithHex:@"#585858"];
        [_subject setUIWithFont:[UIFont systemFontOfSize:11] andColor:[UIColor whiteColor] andTitle:@"数学" andImageName:nil];
        [self addSubview:_subject];
        
        _grade = [UILabel new];
        _grade.frame=CGRectMake(CGRectGetMaxX(_subject.frame),_subject.frame.origin.y,50,25);
        _grade.text=@"三年级";
        _grade.textColor= [UIColor colorWithHex:@"#A7A7A7"];
        _grade.font =[UIFont systemFontOfSize:13];
        _grade.numberOfLines = 1;
        [self addSubview:_grade];
        
        _curriculumTime = [UILabel new];
        _curriculumTime.frame=CGRectMake(CGRectGetMaxX(_grade.frame),_subject.frame.origin.y,100,25);
        _curriculumTime.text=@"7月1号-7月31日";
        _curriculumTime.textColor= [UIColor colorWithHex:@"#A7A7A7"];
        _curriculumTime.font =[UIFont systemFontOfSize:13];
        _curriculumTime.numberOfLines = 1;
        [self addSubview:_curriculumTime];
        
        _curriculumDescription = [UILabel new];
    _curriculumDescription.frame=CGRectMake(CGRectGetMaxX(_curriculumTime.frame),_subject.frame.origin.y,150,25);
        _curriculumDescription.text=@"· 每天 ·8:00-18:00";
        _curriculumDescription.textColor= [UIColor colorWithHex:@"#A7A7A7"];
        _curriculumDescription.font =[UIFont systemFontOfSize:13];
        _curriculumDescription.numberOfLines = 1;
        [self addSubview:_curriculumDescription];
        
        _underLine=[UIView new];
        _underLine.frame=CGRectMake(0,CGRectGetMaxY(_curriculumDescription.frame)+5,SCREEN_WIDTH,3);
        _underLine.backgroundColor= [UIColor colorWithHex:@"#E4E5F0"];
        [self addSubview:_underLine];
    }
    return self;
}
-(void)setModel:(curriculum*)model{
    _model = model;
    
    
}

@end
