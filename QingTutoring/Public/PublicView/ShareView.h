//
//  ShareView.h
//  Nplan
//
//  Created by Ponfey on 2016/12/27.
//  Copyright © 2016年 thirdnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

typedef void (^SuccessHandle)();

@interface ShareView : UIView
@property (nonatomic, assign) NSInteger workId;
@property (nonatomic, strong) NSMutableDictionary *shareInfo;
@property (nonatomic, strong) UIColor *titleColor;

- (void)showWithSuccess:(SuccessHandle)success;

@end
