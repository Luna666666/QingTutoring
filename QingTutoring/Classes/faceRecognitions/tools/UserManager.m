//
//  UserManager.m
//  IFlyMFVDemo
//
//  Created by JzProl.m.Qiezi on 16/3/31.
//
//

#import "UserManager.h"
#import "GroupManager.h"


NSString* const kcAuthID = @"auth_id";
NSString* const kcImage=@"user_img";

NSString* const kcUsers=@"users";

#pragma mark - User

@interface User ()

@end

@implementation User

-(instancetype)init{
    if(self=[super init]){
        _authID=nil;
        _image=nil;
        _groupManager=[[GroupManager alloc] init];
    }
    return self;
}

-(void)dealloc{
    if(self.groupManager){
        self.groupManager=nil;
    }
}

+ (instancetype) fromDic:(NSDictionary*)dic{
    if(!dic){
        return nil;
    }
    
    User* user=[[User alloc] init];
    user.authID =[dic objectForKey:kcAuthID];
    NSData* imageData=[dic objectForKey:kcImage];
    if(imageData){
        user.image=[NSKeyedUnarchiver unarchiveObjectWithData: imageData];
    }
    user.groupManager = [GroupManager fromArray:[dic objectForKey:kcGroupList]];
    return user;
}

- (NSDictionary*) toDic{
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithCapacity:10];
    if(self.authID){
        [dic setObject:self.authID forKey:kcAuthID];
    }
    if(self.image){
        NSData* imageData=[NSKeyedArchiver archivedDataWithRootObject:self.image];
        [dic setObject:imageData forKey:kcImage];
    }
    if(self.groupManager){
        NSArray* groups=[self.groupManager toArray];
        [dic setObject:groups forKey:kcGroupList];
    }
    return dic;
}

@end


#pragma mark- UserManager
@interface UserManager ()

@property(strong)User* user;

@end

@implementation UserManager

-(instancetype)init{
    if(self=[super init]){
        
        _user=nil;
        _users=[[NSMutableArray alloc] initWithCapacity:10];
//        NSArray* users=[UserDefaults objectForKey:kcUsers];
//        if(!users){
//            return self;
//        }
//
//        for (NSDictionary* userDic in users) {
//            User* user=[User fromDic:userDic];
//            if(user){
//                [self.users addObject:user];
//            }
//        }
    }
    return self;
}


IMPLEMENT_SINGLETON(UserManager)


-(void)dealloc{
    if(self.users){
        [self save];
        [self.users removeAllObjects];
        self.users=nil;
    }
    
    if(self.user){
        self.user=nil;
    }
}


-(User*)userForAuthID:(NSString*)authID{
    if(!authID){
        return nil;
    }
    
    for (User* user in self.users) {
        if([authID isEqualToString:user.authID]){
            return user;
        }
    }
    
    User* user=[[User alloc] init];
    user.authID=authID;
    [self add:user];
    
    return user;
}

+(User*)currentUser{
    return [[UserManager sharedInstance] user];
}

+(void)setCurrentUserForAuthID:(NSString*)authID{
    User* user=[[UserManager sharedInstance] userForAuthID:authID];
    [[UserManager sharedInstance] setUser:user];
}

-(BOOL)add:(User*)aUser{
    if(!aUser){
        return NO;
    }
    if(!self.users){
        _users =[[NSMutableArray alloc] init];
    }
    
    [self del:aUser];
    
    [self.users addObject:aUser];
    return YES;
}

-(BOOL)del:(User*)aUser{
    if(!aUser){
        return NO;
    }
    
    if(!self.users){
        return YES;
    }
    
    NSMutableArray* indexArray=[NSMutableArray arrayWithCapacity:0];
    for (int i=0 ;i<[self.users count];++i) {
        User* user=[self.users objectAtIndex:i];
        if([user.authID isEqualToString:aUser.authID]){
            [indexArray addObject:[NSNumber numberWithInt:i]];
        }
    }
    for (NSNumber* index in indexArray) {
        [self.users removeObjectAtIndex:[index intValue]];
    }
    return YES;
}

-(BOOL)empty{
    [self.users removeAllObjects];
    return YES;
}

- (NSArray*) toArray{
    NSMutableArray* array=[NSMutableArray arrayWithCapacity:[self.users count]];
    for (User* user in self.users) {
        NSDictionary* userDic=[user toDic];
        if (userDic) {
            [array addObject:userDic];
        }
    }
    return array;
}

-(BOOL)save{
//    NSArray* usersArray=[self toArray];
//    [UserDefaults setObject:usersArray forKey:kcUsers];
    return YES;
}

@end
