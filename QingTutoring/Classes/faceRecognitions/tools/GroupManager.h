//
//  GroupManager.h
//  IFlyMFVDemo
//
//  Created by JzProl.m.Qiezi on 16/3/31.
//
//

#import <Foundation/Foundation.h>


extern NSString* const kcGroupID;
extern NSString* const kcGroupName;
extern NSString* const kcGroupList;
extern NSString* const kcGroups;

#pragma mark - Group
@interface Group : NSObject

@property (nonatomic,strong)NSString* groupName;
@property (nonatomic,strong)NSString* groupID;


+(instancetype) fromDic:(NSDictionary*)dic;
-(NSDictionary*) toDic;

@end

#pragma mark - GroupManager
@interface GroupManager : NSObject

@property(strong)NSMutableArray* groups;

+(GroupManager*)defaultManager;
+(BOOL)saveDefaultManager;

-(BOOL)join:(Group*)aGroup;
-(BOOL)quit:(Group*)aGroup;
-(BOOL)quitWithGroupID:(NSString*)aGroupID;
-(BOOL)empty;

-(Group*)groupWithGroupID:(NSString*)groupID;

+(instancetype) fromArray:(NSArray*)array;
-(NSArray*) toArray;

@end
