//
//  UserMainInfo.m
//  DamiOA
//
//  Created by ZhouLord on 15/3/30.
//  Copyright (c) 2015年 ZhouLord. All rights reserved.
//

#import "MainUserInfo.h"

static MainUserInfo *mainUserInfo;
@implementation MainUserInfo

+(MainUserInfo *)shareInfo{
    if (!mainUserInfo) {
        mainUserInfo=[[MainUserInfo alloc]init];
    }
    return mainUserInfo;
}

@end


static APPInfo *appInfo;
@implementation APPInfo

+(NSString *)path{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UserAppInfo.plist"];
}

+(APPInfo *)shareInfo{
    if (!appInfo) {
        appInfo=[NSKeyedUnarchiver unarchiveObjectWithFile:[APPInfo path]];
        if (!appInfo)
            appInfo=[[APPInfo alloc]initWithCoder:nil];
    }
    return appInfo;
}

+(void)Save{
    [NSKeyedArchiver archiveRootObject:appInfo toFile:[APPInfo path]];
}

+(void)releaseInfo{
    appInfo.districtName=@"";
    appInfo.isHospital =@"";
    appInfo.orgKey = @"";
    appInfo.orgName = @"";
    appInfo.userKey =@"";
    appInfo.userName =@"";
    appInfo.userTrueName =@"";
    appInfo.userType =@"";
    appInfo.userId =@"";
    [APPInfo Save];
    mainUserInfo=nil;
}
//解码
- (id) initWithCoder: (NSCoder *)coder{
    if (self = [super init]){
        
        
        
        if (coder) {
            
            self.districtName =[coder decodeObjectForKey:@"districtName"];
            self.isHospital=[coder decodeObjectForKey:@"isHospital"];
            self.orgKey =[coder decodeObjectForKey:@"orgKey"];
            self.orgName = [coder decodeObjectForKey:@"orgName"];
            self.userKey = [coder decodeObjectForKey:@"userKey"];
            self.userName = [coder decodeObjectForKey:@"userName"];
            self.userTrueName = [coder decodeObjectForKey:@"userTrueName"];
            self.userType = [coder decodeObjectForKey:@"userType"];
            self.userId = [coder decodeObjectForKey:@"userId"];
            
        }else{
            self.districtName =@"";
            self.isHospital =@"";
            self.orgKey =@"";
            self.orgName =@"";
            self.userKey = @"";
            self.userName = @"";
            self.userTrueName = @"";
            self.userType = @"";
            self.userId = @"";
            NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/data"];
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            [[NSURL fileURLWithPath:path]setResourceValue:[NSNumber numberWithBool: YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
        }
    }
    return self;
}
//编码
- (void)encodeWithCoder: (NSCoder *)coder{
    [coder encodeObject:_districtName forKey:@"districtName"];
    [coder encodeObject:_isHospital forKey:@"isHospital"];
    [coder encodeObject:_orgKey forKey:@"orgKey"];
    [coder encodeObject:_orgName forKey:@"orgName"];
    [coder encodeObject:_userKey forKey:@"userKey"];
    [coder encodeObject:_userName forKey:@"userName"];
    [coder encodeObject:_userTrueName forKey:@"userTrueName"];
    [coder encodeObject:_userType forKey:@"userType"];
    [coder encodeObject:_userId forKey:@"userId"];
    
}

@end
