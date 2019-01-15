//
//  ZSBadgeLabel.h
//  ZSStandard
//
//  Created by zhaopeng on 2017/11/30.
//  Copyright © 2017年 zhaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSBadgeLabel : UILabel

@property (nonatomic, assign) NSUInteger maxAmount;/**<展示的最大数量 超过显示+ 默认999*/
@property (nonatomic, assign) BOOL isOutline;/**<是否描边 默认 NO*/
@property (nonatomic, strong) UIColor *outlineColor;/**<描边颜色 当且仅当isOutline为YES时生效*/

@property (nonatomic, copy) NSString *badgeCount;/**<数量 默认0*/

@property (nonatomic, assign) CGFloat height;/**<高度 默认18*/
@property (nonatomic, assign) CGFloat radius;/**<小圆点的半径 默认是5*/
/**
 展示小红点
 */
- (void)showPoint;
/**
 隐藏小红点
 */
- (void)hidePoint;

@end

/*
 
 本类继承于label 简单的属性 比如背景颜色 字体颜色 大小用户自行设置
 本类提供一些默认的属性值 默认: 背景色红色 字体白色 字号 12
 
 
 注意:
 1. 使用badgeCount赋值 建议使用整数(不要用浮点数) 直接使用text属性不会有数量限制的效果
 2. 数量为0的时候 不予显示 变为隐藏状态
 3. 使用 showPoint / hidePoint 来展示或者隐藏点 使用中心作为锚点 (设置offset一样有效)
 */

