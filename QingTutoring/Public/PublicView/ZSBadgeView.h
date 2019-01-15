//
//  ZSBadgeView.h
//  ZSStandard
//
//  Created by zhaopeng on 2017/11/30.
//  Copyright © 2017年 zhaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>

// Enums
typedef enum {
    ZSBadgeViewHorizontalAlignmentLeft = 0,
    ZSBadgeViewHorizontalAlignmentCenter,
    ZSBadgeViewHorizontalAlignmentRight
    
} ZSBadgeViewHorizontalAlignment;

typedef enum {
    ZSBadgeViewWidthModeStandard = 0,     // 30x20
    ZSBadgeViewWidthModeSmall            // 22x20
} ZSBadgeViewWidthMode;

typedef enum {
    ZSBadgeViewHeightModeStandard = 0,    // 20
    ZSBadgeViewHeightModeLarge             // 30
} ZSBadgeViewHeightMode;


// Constants
#define ZS_BADGE_VIEW_STANDARD_HEIGHT       20.0
#define ZS_BADGE_VIEW_LARGE_HEIGHT          30.0
#define ZS_BADGE_VIEw_STANDARD_WIDTH        30.0
#define ZS_BADGE_VIEw_MINIMUM_WIDTH         20.0
#define ZS_BADGE_VIEW_FONT_SIZE             16.0

@interface ZSBadgeView : UIView

@property (nonatomic, copy) NSString* text;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* badgeColor;
@property (nonatomic, strong) UIColor* outlineColor;
@property (nonatomic, assign) CGFloat outlineWidth;
@property (nonatomic, assign) BOOL outline;
@property (nonatomic, assign) ZSBadgeViewHorizontalAlignment horizontalAlignment;
@property (nonatomic, assign) ZSBadgeViewWidthMode widthMode;
@property (nonatomic, assign) ZSBadgeViewHeightMode heightMode;
@property (nonatomic, assign) BOOL shadow;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, strong) UIColor* shadowColor;
@property (nonatomic, assign) BOOL shadowOfOutline;
@property (nonatomic, assign) BOOL shadowOfText;
@property (nonatomic, assign) CGSize textOffset;

+ (CGFloat)badgeHeight; // @depricated
- (CGFloat)badgeHeight;

@end
