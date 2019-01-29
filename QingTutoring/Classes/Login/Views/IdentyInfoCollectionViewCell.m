//
//  IdentyInfoCollectionViewCell.m
//  QingTutoring
//
//  Created by Charles on 2019/1/18.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "IdentyInfoCollectionViewCell.h"

@implementation IdentyInfoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.gradeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.gradeBtn.frame=CGRectMake(0,5,90,40);
        self.gradeBtn.clipsToBounds = YES;
        self.gradeBtn.layer.cornerRadius = 4;
        self.gradeBtn.layer.borderWidth = 1;
        [self.gradeBtn addTarget:self action:@selector(didClickedTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        self.gradeBtn.layer.borderColor = [UIColor colorWithHex:@"#BBBBBB"].CGColor;
        [self.gradeBtn setTitleColor:[UIColor colorWithHex:@"#101010"] forState:UIControlStateNormal];
        self.gradeBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
        [self addSubview:self.gradeBtn];
    }
    return self;
}
#pragma mark -didClickedTitle
- (void)didClickedTitleAction:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(selectModIdentyInfoCollectionViewCell:didClickAction:)]){
        [_delegate selectModIdentyInfoCollectionViewCell:self didClickAction:sender];
    }
}
@end
