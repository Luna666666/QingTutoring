#ifndef __SINGLETON_FOR_CLASS__
#define __SINGLETON_FOR_CLASS__

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#pragma mark -
#pragma mark Singleton

#define DECLARE_SINGLETON(className) \
+(instancetype) sharedInstance; \

//+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead"))); \
//-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead"))); \
//+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead"))); \


#define IMPLEMENT_SINGLETON(className) \
static className * _gSharedInstance;\
+ (void)initialize { \
    NSAssert([className class] == self, @"Subclassing is not welcome");\
    _gSharedInstance = [[super alloc] initUniqueInstance];\
}\
+(instancetype)sharedInstance { \
    return _gSharedInstance;\
}\
-(instancetype)initUniqueInstance { \
    return [self init];\
}\
+(instancetype)copyWithZone:(NSZone *)zone { \
    return _gSharedInstance;\
}\
+(instancetype)mutableCopyWithZone:(NSZone *)zone { \
    return _gSharedInstance;\
}\

#endif