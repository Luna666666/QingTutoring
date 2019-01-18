//
//  identifyModel.m
//  QingTutoring
//
//  Created by Charles on 2019/1/18.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import "identifyModel.h"

@implementation identifyModel
- (instancetype)initWith:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWith:dict];
}
@end
