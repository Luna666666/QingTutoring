//
//  UserManager.h
//  IFlyMFVDemo
//
//  Created by JzProl.m.Qiezi on 16/3/31.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"


extern NSString* const kcAuthID;
extern NSString* const kcImage;
extern NSString* const kcUsers;


@class GroupManager;

#pragma mark - User
@interface User: NSObject

@property(strong)NSString* authID;
@property(strong)UIImage*  image;
@property(strong)GroupManager* groupManager;

+ (instancetype) fromDic:(NSDictionary*)dic;
- (NSDictionary*) toDic;

@end


#pragma mark - UserManager
@interface UserManager : NSObject

DECLARE_SINGLETON(UserManager)

@property(strong)NSMutableArray* users;

-(User*)userForAuthID:(NSString*)authID;
+(User*)currentUser;
+(void)setCurrentUserForAuthID:(NSString*)authID;

-(BOOL)add:(User*)aUser;
-(BOOL)del:(User*)aUser;
-(BOOL)empty;

-(NSArray*) toArray;

-(BOOL)save;

@end
