//
//  QingTutoringPublicViewController.h
//  Nplan
//
//  Created by xpp on 16/12/13.
//  Copyright © 2016年 xpp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    NAV_LEFT                    =0,
    NAV_RIGHT                   =1,
} WWNavigationBar;

@interface QingTutoringPublicViewController : UIViewController<UIGestureRecognizerDelegate>
- (void)show;
- (void)hidden;
- (void)showHudTitleString:(NSString *)hudString;
- (void)showBarButton:(WWNavigationBar)position button:(ButtonWithTitle *)button;
@end
