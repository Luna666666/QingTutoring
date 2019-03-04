//
//  UserDefaults.h
//  IFlyMFVDemo
//
//  Created by 张剑 on 15/5/12.
//
//

#import <Foundation/Foundation.h>

/**
 *  MFV用户存储封装
 */
@interface UserDefaults : NSObject

/**
 *  获取存储项
 *
 *  @param key 存储项key
 *
 *  @return 存储项值
 */
+(id)objectForKey:(NSString*)key;


/**
 *  设置存储项
 *
 *  @param object 存储项值
 *  @param key    存储项key
 */
+(void)setObject:(id)object forKey:(NSString*)key;

@end
