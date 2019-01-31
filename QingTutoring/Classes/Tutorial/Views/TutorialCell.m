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
    UILabel *_tutorialName;//辅导机构名称
    UILabel *_teachersSize;//师资规模
    ButtonWithTitle*_phone;//联系电话
    ButtonWithTitle*_hotTutorial;//热门辅导班
    ButtonWithTitle *_locatation;//地点
    ButtonWithTitle *_tutorialNum;//辅导人数
    UIView *_underLine;
    UIImageView *_headPic;//头像
    UILabel *_tutorialTeacher;//辅导老师
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _tutorialPic = [UIImageView new];
        _tutorialPic.frame=CGRectMake(10,5,SCREEN_WIDTH-20,80);
        _tutorialPic.contentMode=  UIViewContentModeScaleToFill;
        _tutorialPic.clipsToBounds = YES;
        _tutorialPic.image=[UIImage imageNamed:@"home_Tutorial"];
        [self addSubview:_tutorialPic];
        
        _tutorialName = [UILabel new];
    _tutorialName.frame=CGRectMake(_tutorialPic.frame.origin.x,CGRectGetMaxY(_tutorialPic.frame)+5,70,25);
        _tutorialName.text=@"思成辅导班";
        _tutorialName.textColor= [UIColor colorWithHex:@"#101010"];
        _tutorialName.font =[UIFont fontWithName:@"PingFang SC" size:12];
        _tutorialName.numberOfLines = 1;
        [self addSubview:_tutorialName];
        
        _teachersSize = [UILabel new];
      _teachersSize.frame=CGRectMake(CGRectGetMaxX(_tutorialName.frame),CGRectGetMaxY(_tutorialPic.frame)+5,87,25);
        _teachersSize.text=@"师资规模:  60人";
        _teachersSize.textColor= [UIColor colorWithHex:@"#101010"];
        _teachersSize.font = [UIFont fontWithName:@"PingFang SC" size:12];
        _teachersSize.numberOfLines = 1;
        [self addSubview:_teachersSize];
        
        _phone =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_teachersSize.frame)+10,CGRectGetMaxY(_tutorialPic.frame)+5,110,30) andImageFrame:CGRectMake(5,5,12,15) andTitleFrame:CGRectMake(17,3,90,20)];
        [_phone setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:12] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"17625902072" andImageName:@"home_phone"];
        [self addSubview:_phone];
        
        _hotTutorial =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_phone.frame)+5,CGRectGetMaxY(_tutorialPic.frame)+5,80,30) andImageFrame:CGRectMake(0,5,12,15) andTitleFrame:CGRectMake(12,3,60,20)];
        _hotTutorial.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_hotTutorial setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:12] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"火热报名" andImageName:@"find_hot"];
        [self addSubview:_hotTutorial];
        
        _locatation =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(_tutorialPic.frame.origin.x,CGRectGetMaxY(_tutorialName.frame)+8,130,20) andImageFrame:CGRectMake(0,2.5,12,15) andTitleFrame:CGRectMake(17,0,110,20)];
        [_locatation setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:12] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"江苏南京雨花台区" andImageName:@"home_locate"];
        _locatation.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_locatation];
        
        _tutorialNum =  [[ButtonWithTitle alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_locatation.frame)+15,CGRectGetMaxY(_tutorialName.frame)+8,110,20) andImageFrame:CGRectMake(0,1.5,14,17) andTitleFrame:CGRectMake(18,0,90,20)];
        [_tutorialNum setUIWithFont:[UIFont fontWithName:@"PingFang SC" size:12] andColor:[UIColor colorWithHex:@"#101010"] andTitle:@"辅导人数: 50人" andImageName:@"home_people_join"];
        _tutorialNum.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tutorialNum];
        
        _underLine=[UIView new];
        _underLine.frame=CGRectMake(0,CGRectGetMaxY(_locatation.frame)+5,SCREEN_WIDTH,1);
        _underLine.backgroundColor= [UIColor colorWithHex:@"#E4E5F0"];
        [self addSubview:_underLine];
        
        _headPic = [UIImageView new];
        _headPic.frame=CGRectMake(_tutorialPic.frame.origin.x,CGRectGetMaxY(_underLine.frame)+3,30,30);
        _headPic.contentMode=UIViewContentModeScaleAspectFill;
        _headPic.layer.cornerRadius = _headPic.frame.size.height/2;
        _headPic.clipsToBounds = YES;
        _headPic.image=[UIImage imageNamed:@"home_master"];
        [self addSubview:_headPic];
        _tutorialTeacher = [UILabel new];
        _tutorialTeacher.frame=CGRectMake(CGRectGetMaxX(_headPic.frame)+10,CGRectGetMaxY(_underLine.frame)+3,102,30);
        _tutorialTeacher.backgroundColor = [UIColor whiteColor];
        _tutorialTeacher.text=@"辅导老师 | 李倩倩";
        _tutorialTeacher.textColor= [UIColor colorWithHex:@"#101010"];
        _tutorialTeacher.font =[UIFont fontWithName:@"PingFang SC" size:12];
        _tutorialTeacher.numberOfLines = 1;
        [self addSubview:_tutorialTeacher];
        
    }
    return self;
}
-(void)setModel:(Tutorial*)model{
    _model = model;
    
    
}
@end
