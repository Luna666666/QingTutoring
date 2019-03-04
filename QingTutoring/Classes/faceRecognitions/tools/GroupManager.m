//
//  GroupManager.m
//  IFlyMFVDemo
//
//  Created by JzProl.m.Qiezi on 16/3/31.
//
//

#import "GroupManager.h"
#import "UserDefaults.h"
NSString* const kcGroupID=@"group_id";
NSString* const kcGroupName=@"group_name";
NSString* const kcGroupList=@"group_list";
NSString* const kcGroups=@"groups";

#pragma mark -
@implementation Group

-(instancetype)init{
    if(self = [super init]){
        _groupName=nil;
        _groupID=nil;
    }
    return self;
}

-(void)dealloc{
    self.groupName=nil;
    self.groupID=nil;
}

+ (instancetype) fromDic:(NSDictionary*)dic{
    if(!dic){
        return nil;
    }
    
    Group* info=[[Group alloc] init];
    info.groupName =[dic objectForKey:kcGroupName];
    info.groupID =[dic objectForKey:kcGroupID];
    return info;
}

- (NSDictionary*) toDic{
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithCapacity:10];
    if(self.groupName){
        [dic setObject:self.groupName forKey:kcGroupName];
    }
    if(self.groupID){
        [dic setObject:self.groupID forKey:kcGroupID];
    }
    return dic;
}

@end


#pragma mark -

@interface GroupManager ()

@end


@implementation GroupManager



-(instancetype)init{
    if(self=[super init]){
        _groups=[[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

-(void)dealloc{
    if(self.groups){
        [self.groups removeAllObjects];
        self.groups=nil;
    }
}

+(GroupManager*)defaultManager{
    static GroupManager *_defaultManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _defaultManager = [[self alloc] init];
        NSArray* groups=[UserDefaults objectForKey:kcGroups];
        for (NSDictionary* dic in groups) {
            Group* group=[Group fromDic:dic];
            [_defaultManager.groups addObject:group];
        }
    });

    return _defaultManager;
}

+(BOOL)saveDefaultManager{
    NSArray* groups=[[GroupManager defaultManager] toArray];
    [UserDefaults setObject:groups forKey:kcGroups];
    return YES;
}

-(BOOL)join:(Group*)aGroup{
    if(!aGroup){
        return NO;
    }
    
    if(!self.groups){
        _groups=[[NSMutableArray alloc] initWithCapacity:10];
        [self.groups addObject:aGroup];
        return YES;
    }
    
    [self quit:aGroup];
    [self.groups addObject:aGroup];
    return YES;
}

-(BOOL)quit:(Group*)aGroup{
    if(!aGroup){
        return NO;
    }
    
    if(!self.groups){
        return YES;
    }
    
    return [self quitWithGroupID:aGroup.groupID];
}

-(BOOL)quitWithGroupID:(NSString*)aGroupID{
    if(!aGroupID){
        return  NO;
    }
    
    NSMutableArray* indexArray=[NSMutableArray arrayWithCapacity:0];
    for (int i=0 ;i<[self.groups count];++i) {
        Group* group=[self.groups objectAtIndex:i];
        if([group.groupID isEqualToString:aGroupID]){
            [indexArray addObject:[NSNumber numberWithInt:i]];
        }
    }
    for (NSNumber* index in indexArray) {
        [self.groups removeObjectAtIndex:[index intValue]];
    }
    
    return YES;
}

-(BOOL)empty{
    if(!self.groups){
         _groups=[[NSMutableArray alloc] initWithCapacity:10];
        return YES;
    }
    
    [self.groups removeAllObjects];
    return YES;
}

-(Group*)groupWithGroupID:(NSString*)groupID{
    if(!groupID){
        return nil;
    }
    
    for(Group* group in self.groups){
        if([groupID isEqualToString:group.groupID]){
            return group;
        }
    }
    return nil;
}

+ (instancetype) fromArray:(NSArray*)array{
    if(!array){
        return nil;
    }
    
    GroupManager* manager=[[GroupManager alloc] init];
    for (NSDictionary* dic in array) {
        Group* group=[Group fromDic:dic];
        [manager.groups addObject:group];
    }
    return manager;
}

- (NSArray*) toArray{
    NSMutableArray* array=[NSMutableArray arrayWithCapacity:[self.groups count]];
    for (Group* group in self.groups) {
        NSDictionary* groupDic=[group toDic];
        [array addObject:groupDic];
    }
    return array;
}

@end

