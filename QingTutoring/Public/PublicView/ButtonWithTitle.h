//
//  ButtonWithTitle.h
//  DCApp
//
//  Created by wangwang on 16/11/25.
//  Copyright © 2016年 SS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonWithTitle : UIControl

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;

-(instancetype)initWithFrame:(CGRect)frame andImageFrame:(CGRect)imageFrame andTitleFrame:(CGRect)titleFrame;
-(void)setUIWithFont:(UIFont *)font andColor:(UIColor *)color andTitle:(NSString *)title andImageName:(NSString *)imageName;
@end
