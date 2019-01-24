//
//  TutorialCell.m
//  QingTutoring
//
//  Created by Charles on 2019/1/23.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "TutorialCell.h"

@implementation TutorialCell
{
    UIImageView *_tutorialPic;//图片
    UILabel *_subject;//课程名称
    UILabel *_tutorialName;//辅导机构名称
    UILabel *_teachersSize;//师资规模
    ButtonWithTitle*_phone;//联系电话
    ButtonWithTitle *_locatation;//地点
    ButtonWithTitle *_tutorialNum;//辅导人数
    UIView *_underLine;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _tutorialPic = [UIImageView new];
        _tutorialPic.frame=CGRectMake(0,0,SCREEN_WIDTH,110);
        _tutorialPic.contentMode=UIViewContentModeScaleAspectFill;
        _tutorialPic.clipsToBounds = YES;
        _tutorialPic.image=[UIImage imageNamed:@"home_Tutorial"];
        [self addSubview:_tutorialPic];
        
        _subject = [UILabel new];
        _subject.frame=CGRectMake(10,CGRectGetMaxY(_tutorialPic.frame),110,25);
        _subject.text=@"七年级数学";
        _subject.font =[UIFont systemFontOfSize:14];
        _subject.textColor = [UIColor colorWithHex:@"#101010"];
        [self addSubview:_subject];
        
        _tutorialName = [UILabel new];
        _tutorialName.frame=CGRectMake(_subject.frame.origin.x,CGRectGetMaxY(_subject.frame)+5,110,20);
        _tutorialName.text=@"思成辅导班";
        _tutorialName.textColor= [UIColor colorWithHex:@"#101010"];
        _tutorialName.font =[UIFont systemFontOfSize:14];
        _tutorialName.numberOfLines = 1;
        [self addSubview:_tutorialName];
        
        _teachersSize = [UILabel new];
        _teachersSize.frame=CGRectMake(CGRectGetMaxX(_tutorialName.frame),CGRectGetMaxY(_subject.frame)+5,117,20);
        _teachersSize.text=@"师资规模:  60人";
        _teachersSize.textColor= [UIColor colorWithHex:@"#101010"];
        _teachersSize.font =[UIFont systemFontOfSize:14];
        _teachersSize.numberOfLines = 1;
        [self addSubview:_teachersSize];
        
        _phone =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_teachersSize.frame),CGRectGetMaxY(_subject.frame)+5,110,30) andImageFrame:CGRectMake(0,5,19,20) andTitleFrame:CGRectMake(20,5,90,20)];
        [_phone setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:@"17625902072" andImageName:@"home_phone"];
        [self addSubview:_phone];
        
        _locatation =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(_subject.frame.origin.x,CGRectGetMaxY(_tutorialName.frame)+8,130,30) andImageFrame:CGRectMake(0,5,19,20) andTitleFrame:CGRectMake(20,0,120,30)];
        [_locatation setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:@"江苏南京雨花台区" andImageName:@"home_locate"];
        _locatation.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_locatation];
        
        _tutorialNum =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_locatation.frame)+15,CGRectGetMaxY(_tutorialName.frame)+8,130,30) andImageFrame:CGRectMake(0,5,19,20) andTitleFrame:CGRectMake(18,0,120,30)];
        [_tutorialNum setUIWithFont:[UIFont systemFontOfSize:14] andColor:[UIColor blackColor] andTitle:@"辅导人数: 50人" andImageName:@"home_people_join"];
        _tutorialNum.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tutorialNum];
        
        _underLine=[UIView new];
        _underLine.frame=CGRectMake(0,CGRectGetMaxY(_locatation.frame)+5,SCREEN_WIDTH,1);
        _underLine.backgroundColor= [UIColor colorWithHex:@"#E4E5F0"];
        [self addSubview:_underLine];
    }
    return self;
}
-(void)setModel:(Tutorial*)model{
    _model = model;
    
    
}
@end
