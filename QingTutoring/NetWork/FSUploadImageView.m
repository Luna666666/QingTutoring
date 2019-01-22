//
//  FSUploadImageView.m
//  JTXX
//
//  Created by Mac on 16/3/21.
//  Copyright © 2016年 nanjingfeisheng. All rights reserved.
//

#import "FSUploadImageView.h"

@implementation FSUploadImageView

- (void)createProgressView {
    self.userInteractionEnabled = YES;
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    _progressView.tintColor =[UIColor orangeColor];
    _progressView.trackTintColor = [UIColor lightGrayColor];
    _progressView.hidden = NO;
    _progressView.progress = 0;
    [self addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(5);
        make.width.equalTo(self);
    }];
}

@end
