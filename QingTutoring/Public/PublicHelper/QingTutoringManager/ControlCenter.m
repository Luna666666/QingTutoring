//
//  ControlCenter.m
//  BusinessCard
//
//  Created by Ponfey on 16/4/1.
//  Copyright © 2016年 thirdnet. All rights reserved.
//

#import "ControlCenter.h"

static ReachabilityStatus reachability;

@implementation ControlCenter

+ (instancetype)sharedInstance{
    static ControlCenter *control;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[ControlCenter alloc] init];
    });
    return control;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.reachabilityBlock = ^(AFNetworkReachabilityStatus status){
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    reachability = ReachabilityStatusWiFi;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    reachability = ReachabilityStatusCellular;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    reachability = ReachabilityStatusNone;
                    break;
                default:
                    break;
            }
            if (weakSelf.reachabilityStatusChangedHandle) {
                weakSelf.reachabilityStatusChangedHandle(reachability);
            }
            if (weakSelf.homePageReachabilityStatusChangedHandle) {
                weakSelf.homePageReachabilityStatusChangedHandle(reachability);
            }
        };
    }
    return self;
}

+ (BOOL)isEmpty:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
        string = [string description];
    if (string == nil || string == NULL)
        return YES;
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    if ([[string stringByReplacingOccurrencesOfString:@" " withString:@""] length]==0)
        return YES;
    if ([string isEqualToString:@"(null)"])
        return YES;
    if ([string isEqualToString:@"(null)(null)"])
        return YES;
    if ([string isEqualToString:@"<null>"])
        return YES;
    
    return NO;
}

- (ReachabilityStatus)reachabilityStatus{
    return reachability;
}


@end
