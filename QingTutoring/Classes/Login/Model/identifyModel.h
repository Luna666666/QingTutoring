//
//  identifyModel.h
//  QingTutoring
//
//  Created by Charles on 2019/1/18.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface identifyModel : NSObject
@property (nonatomic,strong) NSString *gradeName;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
