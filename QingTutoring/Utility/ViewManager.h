//
//  ViewManager.h
//  MuYingShopping
//
//  Created by wangwang on 15/10/20.
//  Copyright © 2015年 wangwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewManager : NSObject

//创建imageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame andImageName:(NSString *)imageName;

//创建label
+(UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines textColor:(UIColor *)textColor;
+(UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font;
//创建button
+(UIButton *)createBtnWithFrame:(CGRect)frame andTitle:(NSString *)title andBgImageName:(NSString *)imageName andTarget:(id)target andAction:(SEL)action;
@end
