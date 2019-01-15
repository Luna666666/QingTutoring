//
//  UIView+ZSCategory.h
//  ZSStandard
//
//  Created by zhaopeng on 2017/11/30.
//  Copyright © 2017年 zhaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSBadgeLabel.h"

@interface UIView (ZSCategory)

/**
 打开 附件指示功能
 */
- (void)openBadgeWith:(CGFloat)height;
@property (nonatomic, assign) CGPoint badgeOffset;/**<附件控件中心偏移量设置,参照中心是view的center 默认偏移 (self.width/2,-self.height/2)*/
@property (nonatomic, copy) NSString *badgeCount;/**<角标数量 没有返回空字符串*/
@property (nonatomic, strong) ZSBadgeLabel *badgeLabel;/**<角标控件,便于个性化设置*/

/**
 快速创建一个视图的截图 (用于动画的创建)
 */
- ( UIImage *)snapshotImage;

/**
 清除所有子视图
 */
- (void)removeAllSubviews;

/**
 持有该视图最近的控制器(通常用在cell上解耦)
 */
- (UIViewController *)lastestViewController;

@end
