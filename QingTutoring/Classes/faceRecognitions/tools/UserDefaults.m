//
//  UserDefaults.m
//  IFlyMFVDemo
//
//  Created by 张剑 on 15/5/12.
//
//

#import "UserDefaults.h"

@implementation UserDefaults

+(id)objectForKey:(NSString*)key{
    
    if(!key || [key length]<1){
        return nil;
    }

    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void)setObject:(id)object forKey:(NSString*)key{
    
    if(!key || [key length]<1){
        return ;
    }
    
    if(! object){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        return ;
    }

    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];

}

@end
