//
//  HttpManager.h
//  FavoriteLimit
//
//  Created by mac on 15/11/30.
//  Copyright © 2015年 shihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^ConstructingBodyBlock)(id<AFMultipartFormData> formData);
typedef void(^SuccessBlock)(NSURLSessionDataTask *operation, id responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask *operation, NSError *error);

@interface HttpManager : NSObject

+ (HttpManager *)shareManager;

/**
 *  GET请求
 */
- (void)requestWithUrlString:(NSString *)urlString parameters:(NSDictionary *)dict successBlock:(SuccessBlock)sucBlock failureBlock:(FailureBlock)failBlock;

/**
 *  POST请求(带Token验证)
 */
- (void)requestWithPostUrlString:(NSString *)urlString parameters:(NSDictionary *)dict successBlock:(SuccessBlock)sucBlock failureBlock:(FailureBlock)failBlock;
/**
 *  返回字符串的post
 */
- (void)requestReturnStringWithPostUrlString:(NSString *)urlString parameters:(NSDictionary *)dict successBlock:(SuccessBlock)sucBlock failureBlock:(FailureBlock)failBlock;


/**
 *  上传图片imageView
 */
//- (HYBURLSessionTask *)uploadWithImageView:(FSUploadImageView *)imageView
//                                       url:(NSString *)url
//                                  filename:(NSString *)filename
//                                      name:(NSString *)name
//                                parameters:(NSDictionary *)param
//                                  progress:(HYBUploadProgress)progress
//                                   success:(HYBResponseSuccess)success
//                                      fail:(HYBResponseFail)fail;
///**
// *  上传图片image
// **/
//- (HYBURLSessionTask *)uploadWithImage:(UIImage *)image
//                                   url:(NSString *)url
//                              filename:(NSString *)filename
//                                  name:(NSString *)name
//                            parameters:(NSDictionary *)param
//                              progress:(HYBUploadProgress)progress
//                               success:(HYBResponseSuccess)success
//                                  fail:(HYBResponseFail)fail;

- (void)cancelAllRequest;



@end
