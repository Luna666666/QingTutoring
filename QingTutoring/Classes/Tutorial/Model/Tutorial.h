//
//  Tutorial.h
//  QingTutoring
//
//  Created by Charles on 2019/1/23.
//  Copyright © 2019年 Shensu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tutorial : NSObject
@property (nonatomic, copy) NSString *tutorialId;//
@property (nonatomic, copy) NSString *tutorialPicture;//辅导班图片
@property (nonatomic, copy) NSString *subjectName;//课程名称
@property (nonatomic, copy) NSString *tutorialName;//机构名称
@property (nonatomic, copy) NSString* shiziCount;//师资规模
@property (nonatomic, copy) NSString *phone;//手机号码
@property (nonatomic, copy) NSString *locatation;//地点
@property (nonatomic, copy) NSString *tutorialCount;//辅导人数

+(instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
