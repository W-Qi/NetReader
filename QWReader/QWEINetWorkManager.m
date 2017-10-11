//
//  QWEINetWorkManager.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEINetWorkManager.h"

static NSString * const QWEINetWorkingBaseURLString = @"http://api.zhuishushenqi.com/";
static NSString * const QWEINetWorkingChapterBaseURLString = @"http://chapterup.zhuishushenqi.com/chapter/";

@implementation QWEINetWorkManager

+ (instancetype)sharedClient {
    
    static QWEINetWorkManager *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[QWEINetWorkManager alloc] initWithBaseURL:[NSURL URLWithString:QWEINetWorkingBaseURLString]];
//        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
//        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

+ (instancetype)sharedChapterClient {
    
    static QWEINetWorkManager *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[QWEINetWorkManager alloc] initWithBaseURL:[NSURL URLWithString:QWEINetWorkingChapterBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
