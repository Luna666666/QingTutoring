//
//  QingTutoringPublicCollectionCell.m
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/30.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import "QingTutoringPublicCollectionCell.h"

@implementation QingTutoringPublicCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,5, (SCREEN_WIDTH - 250) / 5, (SCREEN_WIDTH -250) / 5)];
        self.imageView.userInteractionEnabled=NO;
        [self addSubview:self.imageView];
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_WIDTH - 240) / 5+8, (SCREEN_WIDTH - 80) / 5, 20)];
        self.descLabel.textAlignment = NSTextAlignmentCenter;
        self.descLabel.userInteractionEnabled=NO;
        self.descLabel.textColor=[UIColor colorWithHex:@"#575F68"];
        self.descLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:self.descLabel];
        self.deleteOradd=[UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteOradd.frame=CGRectMake(CGRectGetMaxX(self.imageView.frame),3,13,13);
        [self addSubview:self.deleteOradd];
        
    }
    return self;
}
@end
