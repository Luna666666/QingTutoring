//
//  UserMainInfo.h
//  DamiOA
//
//  Created by ZhouLord on 15/3/30.
//  Copyright (c) 2015年 ZhouLord. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainUserInfo : NSObject

+(MainUserInfo *)shareInfo;

@end


@interface APPInfo : NSObject
@property(nonatomic,copy)NSString *districtName;//地区名称
@property(nonatomic,copy)NSString *isHospital;//是否是医院
@property(nonatomic,copy)NSString *orgKey;//机构key
@property(nonatomic,copy)NSString *orgName;//机构名称
@property(nonatomic,copy)NSString *userKey;//用户key
@property(nonatomic,copy)NSString *userName;//用户姓名
@property(nonatomic,copy)NSString *userTrueName;//用户真实姓名
@property(nonatomic,copy)NSString *userType;//用户电话
@property(nonatomic,copy)NSString *userId;

+(APPInfo *)shareInfo;
+(void)releaseInfo;
+(void)Save;

@end


