//
//  QWEINetWorkManager.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface QWEINetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

+ (instancetype)sharedChapterClient;

@end
