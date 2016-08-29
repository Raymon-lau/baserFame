//
//  RMRequestManger.m
//  Raymon
//
//  Created by Raymon on 15/12/16.
//  Copyright (c) 2015年 Raymon. All rights reserved.
//

#import "RMRequestManger.h"
#import "AFNetworking.h"
#import "UploadParam.h"

#define serverUrl @"http://192.168.1.1:8080/jiekou"

@implementation RMRequestManger

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    //    manager.requestSerializer.timeoutInterval = 5;
    NSString *getString = URLString;
    if (![URLString hasPrefix:@"http"]) {
        getString = [NSString stringWithFormat:@"%@%@", serverUrl,URLString] ;
    }

    [manager GET:getString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    [RMUtils hudShow];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 申明返回的数据是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    // 转xml格式
//    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    if ([RMNetWork shareInstance].rechability) {
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
            [RMUtils hudSuccessHidden];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [RMUtils showMessage:STR_ALERT_SYSTEMRESPOSE];
            [RMUtils hudFailHidden];
        }];
    }else{
        [RMUtils hudFailHidden:STR_ALERT_CHECKNETSTATUS];
    }
    
}

#pragma mark -- POST/GET网络请求 --
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *string = URLString;
    if (![URLString hasPrefix:@"http"]) {
        
        string = [NSString stringWithFormat:@"%@%@", serverUrl,URLString] ;
    }
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:string parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
}

#pragma mark -- 上传图片 --
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(UploadParam *)uploadParam
                    success:(void (^)(id response))success
                    failure:(void (^)(NSError *))failure {
    [RMUtils hudShow];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *string = URLString;
    if (![URLString hasPrefix:@"http"]) {
        
        string = [NSString stringWithFormat:@"%@%@", kRequestLoadImageURL,URLString];
    }

    [manager POST:string parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (success) {
            success(dic);
        }
        [RMUtils hudSuccessHidden];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [RMUtils hudFailHidden];
    }];
}

#pragma mark - 请求Appstore获取版本信息
+ (void)getAppstoreMessageWithAppId:(NSString *)appId
                            success:(void (^)(id response))success
                            failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end