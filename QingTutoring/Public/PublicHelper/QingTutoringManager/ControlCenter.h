//
//  ControlCenter.h
//  BusinessCard
//
//  Created by Ponfey on 16/4/1.
//  Copyright © 2016年 thirdnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworkReachabilityManager.h"

typedef NS_ENUM(NSInteger, ReachabilityStatus){
    ReachabilityStatusNone,
    ReachabilityStatusCellular,
    ReachabilityStatusWiFi
};

/*!
 @class
 @abstract 实用工具类
 @discussion 一些实用的全局方法
 */
@interface ControlCenter : NSObject

@property (nonatomic, copy) void (^reachabilityBlock)(AFNetworkReachabilityStatus status);

@property (nonatomic, copy) void (^reachabilityStatusChangedHandle)(ReachabilityStatus);
@property (nonatomic, copy) void (^homePageReachabilityStatusChangedHandle)(ReachabilityStatus);
@property (nonatomic, assign)BOOL hasNotification;

+ (instancetype)sharedInstance;

+ (BOOL)isEmpty:(NSString *)string;

- (ReachabilityStatus)reachabilityStatus;


@end
