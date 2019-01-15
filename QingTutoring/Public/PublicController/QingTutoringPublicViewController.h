//
//  QingTutoringPublicViewController.h
//  Nplan
//
//  Created by xpp on 16/12/13.
//  Copyright © 2016年 xpp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QingTutoringPublicViewController : UIViewController<UIGestureRecognizerDelegate>
- (void)show;
- (void)hidden;
- (void)showHudTitleString:(NSString *)hudString;
@end
