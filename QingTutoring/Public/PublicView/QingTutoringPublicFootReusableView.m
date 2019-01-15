//
//  QingTutoringPublicFootReusableView.m
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/6/27.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#import "QingTutoringPublicFootReusableView.h"

@implementation QingTutoringPublicFootReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.grayLine = [[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,10)];
        self.grayLine.backgroundColor=[UIColor colorWithHex:@"#F5F5F5"];
        [self addSubview:self.grayLine];
    }
    return self;
}
@end
