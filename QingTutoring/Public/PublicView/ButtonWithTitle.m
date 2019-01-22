//
//  ButtonWithTitle.m
//  DCApp
//
//  Created by wangwang on 16/11/25.
//  Copyright © 2016年 SS. All rights reserved.
//

#import "ButtonWithTitle.h"

@implementation ButtonWithTitle

-(instancetype)initWithFrame:(CGRect)frame andImageFrame:(CGRect)imageFrame andTitleFrame:(CGRect)titleFrame
{
    if(self=[super initWithFrame:frame])
    {
        _imageView=[[UIImageView alloc] initWithFrame:imageFrame];
        [self addSubview:_imageView];
        _titleLabel=[[UILabel alloc] initWithFrame:titleFrame];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)setUIWithFont:(UIFont *)font andColor:(UIColor *)color andTitle:(NSString *)title andImageName:(NSString *)imageName
{
    
    _titleLabel.text=title;
    _titleLabel.numberOfLines = 0;
    if(font)
    {
        _titleLabel.font=font;
    }
    if(color)
    {
        _titleLabel.textColor=color;
    }
    
    if (imageName != nil) {
       _imageView.image=[UIImage imageNamed:imageName];
    }
    
}
@end
