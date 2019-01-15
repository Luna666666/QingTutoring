//
//  FSUploadImageView.h
//  JTXX
//
//  Created by Mac on 16/3/21.
//  Copyright © 2016年 nanjingfeisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSUploadImageView : UIImageView

@property (nonatomic, strong) UIProgressView * progressView;

- (void)createProgressView;

@end
