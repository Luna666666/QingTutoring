//
//  AppMacro.h
//  QingTutoring
//
//  Created by ZSPLAT-UI on 2018/5/28.
//  Copyright © 2018年 ZSPLAT-UI. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#pragma mark -----日志输出-----
#ifdef DEBUG
#define DEBUGLOG(...) printf("[文件名:%s] [函数名:%s] [行号:%d] %s\n",__FILE__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String])
#define DDLOG_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
//#define DEBUGLOG(...) NSLog(__VA_ARGS__)
#define DEBUGLOG_FUNC DEBUGLOG(@"%s", __func__);
#define DEBUGLOG_REWRITE_FUNC DEBUGLOG(@"子类需要重写：%s", __FUNCTION__)
#else
#define DEBUGLOG(...)
#define DDLOG_CURRENT_METHOD
#define DEBUGLOG_FUNC
#define DEBUGLOG_REWRITE_FUNC
#endif

#define kWS(weakSelf) __weak typeof(self) weakSelf = self
//首页接口-------------------------------------------
#define HeaderURL @"http://192.168.0.3:8080/"
#define kImageServer         @"http://192.168.0.195:8080/imagePath/"
#define kWeatherServer @"http://api.avatardata.cn/Weather/Query?"

#define kWebsiteADDRESS @"http://www.zsplat.com/"

#define USER_ACCOUNT [[NSUserDefaults standardUserDefaults] objectForKey:@"account"]
#define USER_PASSWORD [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
#define SVPERROR @"你的网络在路上..."
#define SVPLOADING @"拼命加载中..."


#endif /* AppMacro_h */
