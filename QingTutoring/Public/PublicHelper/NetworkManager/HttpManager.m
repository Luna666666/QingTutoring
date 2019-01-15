//
//  HttpManager.m
//  FavoriteLimit
//
//  Created by mac on 15/11/30.
//  Copyright © 2015年 shihang. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager
NS_ASSUME_NONNULL_BEGIN

+ (HttpManager *)shareManager {
    static HttpManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!manager) {
            manager = [[HttpManager alloc] init];
        }
    });
    return manager;
}

- (void)requestWithUrlString:(NSString *)urlString parameters:(NSDictionary *)dict successBlock:(SuccessBlock)sucBlock failureBlock:(FailureBlock)failBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    AFSecurityPolicy *securityPolicy = [self createCer];
//    manager.securityPolicy = securityPolicy;
//    [self createP12WithManager:manager];
//    manager.securityPolicy = [self getCustomHttpsPolicy:manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    [manager GET:urlString parameters:dict success:^(NSURLSessionDataTask *operation, id responseObject) {
        DEBUGLOG(@"%@", responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        sucBlock(operation, responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        DEBUGLOG(@"RequestError%@", error);
        failBlock(operation, error);
        //TODO: 网络错误提示
    }];
}

- (void)requestWithPostUrlString:(NSString *)urlString parameters:(NSDictionary *)dict successBlock:(SuccessBlock)sucBlock failureBlock:(FailureBlock)failBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.securityPolicy = [self getCustomHttpsPolicy:manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    // 设置请求参数为json格式（java后台要求）
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:urlString parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DEBUGLOG(@"%@", responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        DEBUGLOG(@"%@", responseObject);
        sucBlock(task, responseObject);
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        DEBUGLOG(@"RequestError%@", error);
        failBlock(task, error);
        //TODO: 网络错误提示
    }];
}

- (void)requestReturnStringWithPostUrlString:(NSString *)urlString parameters:(NSDictionary *)dict successBlock:(SuccessBlock)sucBlock failureBlock:(FailureBlock)failBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
//    AFSecurityPolicy *securityPolicy = [self createCer];
//    manager.securityPolicy = securityPolicy;
//    [self createP12WithManager:manager];
//    manager.securityPolicy = [self getCustomHttpsPolicy:manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DEBUGLOG(@"%@", responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        sucBlock(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        DEBUGLOG(@"RequestError%@", error);
        failBlock(task, error);
        //TODO: 网络错误提示
    }];
}

//- (HYBURLSessionTask *)uploadWithImageView:(FSUploadImageView *)imageView
//                                       url:(NSString *)url
//                                  filename:(NSString *)filename
//                                      name:(NSString *)name
//                                parameters:(NSDictionary *)param
//                                  progress:(HYBUploadProgress)progress
//                                   success:(HYBResponseSuccess)success
//                                      fail:(HYBResponseFail)fail {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [imageView createProgressView];
//    
//    return [HYBNetworking uploadWithImage:[LYHControl scaleImageTo500Size:imageView.image] url:url filename:filename name:@"file" mimeType:@"image/jpeg" parameters:param progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
//        progress(bytesWritten, totalBytesWritten);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            imageView.progressView.hidden = NO;
//            [imageView.progressView setProgress:(float)bytesWritten / totalBytesWritten animated:YES];
//        });
//        DEBUGLOG(@"%lld, %lld, %.2f", bytesWritten, totalBytesWritten, (float)bytesWritten / totalBytesWritten);
//    } success:^(id response) {
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        DEBUGLOG(@"%@", response);
//        success(response);
//        
//        
//        
//    } fail:^(NSError *error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        imageView.progressView.hidden = YES;
//        DEBUGLOG(@"%@", error);
//        fail(error);
//        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"] || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"已取消"]) {
//            
//        } else {
//            //TODO: 网络错误提示
//        }
//    }];
//}
//
//- (HYBURLSessionTask *)uploadWithImage:(UIImage *)image
//                                       url:(NSString *)url
//                                  filename:(NSString *)filename
//                                      name:(NSString *)name
//                                parameters:(NSDictionary *)param
//                                  progress:(HYBUploadProgress)progress
//                                   success:(HYBResponseSuccess)success
//                                      fail:(HYBResponseFail)fail {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    return [HYBNetworking uploadWithImage:[LYHControl scaleImageTo500Size:image] url:url filename:filename name:name mimeType:@"image/jpeg" parameters:param progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
//        progress(bytesWritten, totalBytesWritten);
//        
//    } success:^(id response) {
//        
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        DEBUGLOG(@"%@", response);
//        success(response);
//        
//        
//        
//    } fail:^(NSError *error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        DEBUGLOG(@"%@", error);
//        fail(error);
//        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"] || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"已取消"]) {
//            
//        } else {
//            //TODO: 网络错误提示
//        }
//    }];
//}

- (void)cancelAllRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // manager.operationQueue 请求数据的队列，只有一个，和上面请求数据中的是一个，所有请求的线程都是放在同一个manager.operationQueue中
    // manager.operationQueue.operationCount 拿到队列中request操作的个数
    if (manager.operationQueue.operationCount > 0) {
        // 取消队列所有的操作
        [manager.operationQueue cancelAllOperations];
    }
}

///**错误提示*/
//- (void)errorTip:(NSString *)string {
//    UILabel *label = [[UILabel alloc] init];
//    label.text = string;
//    label.backgroundColor = [UIColor blackColor];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:13];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.layer.cornerRadius = 5;
//    label.layer.masksToBounds = YES;
//    label.alpha = 1;
//    [[UIApplication sharedApplication].keyWindow addSubview:label];
//    CGSize lableSize = [LYHControl labelAutoCalculateRectWith:label.text Font:label.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo([UIApplication sharedApplication].keyWindow).offset(-40);
//        make.centerX.equalTo([UIApplication sharedApplication].keyWindow);
//        make.height.mas_equalTo(lableSize.height + 20);
//        make.width.mas_equalTo(lableSize.width + 20);
//    }];
//    
//    [UIView animateWithDuration:1.5 delay:0 options:0 animations:^{
//        label.alpha = 0;
//    } completion:^(BOOL finished) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [label removeFromSuperview];
//        });
//    }];
//}

- (AFSecurityPolicy*)getCustomHttpsPolicy:(AFHTTPSessionManager*)manager{
    
    //https 公钥证书配置
    
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"der"];
    
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    
    NSSet *certSet = [NSSet setWithObject:certData];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    
    policy.allowInvalidCertificates = YES;// 是否允许自建证书或无效证书（重要！！！）
    
    policy.validatesDomainName = NO;//是否校验证书上域名与请求域名一致
    
    return policy;
    
}

+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityError = errSecSuccess;
    
    //client certificate password
    
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"111111"
                                      
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        
        const void*tempIdentity =NULL;
        
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        
        *outIdentity = (SecIdentityRef)tempIdentity;
        
        const void*tempTrust =NULL;
        
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        
        *outTrust = (SecTrustRef)tempTrust;
        
    } else {
        
        NSLog(@"Failedwith error code %d",(int)securityError);
        
        return NO;
        
    }
    
    return YES;
    
}
NS_ASSUME_NONNULL_END

@end
