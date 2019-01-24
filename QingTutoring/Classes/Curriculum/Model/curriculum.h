//
//  curriculum.h
//  QingTutoring
//
//  Created by Charles on 2019/1/23.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface curriculum : NSObject
@property (nonatomic, copy) NSString *curriculumId;//课程ID
@property (nonatomic, copy) NSString *teacherPic;//老师头像
@property (nonatomic, copy) NSString *teacherName;//课程名称
@property (nonatomic, copy) NSString *curriculumName;//课程名称
@property (nonatomic, copy) NSString *subject;//科目
@property (nonatomic, copy) NSString* grade;//年级
@property (nonatomic, copy) NSString *beiginDate;//开始时间
@property (nonatomic, copy) NSString *endDate;//开始时间
@property (nonatomic, copy) NSString *description;//上课描述

+(instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
