//
//  UITextField+MadeInChina.m
//  HzTraffic
//
//  Created by swkj001152 on 14-5-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "UITextField+MadeInChina.h"

@implementation UITextField (MadeInChina)

-(void)setPlaceholderLabelTextColor:(UIColor *)textColor{
    
    [self setValue:textColor
        forKeyPath: @"_placeholderLabel.textColor"];
    
}

@end
