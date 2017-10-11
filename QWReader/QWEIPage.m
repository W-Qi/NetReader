//
//  QWEIPage.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIPage.h"
#import "QWEINetWorkManager.h"

@implementation QWEIPage

+ (NSURLSessionDataTask *)getBookContent:(void (^)(QWEIBookContent *bookContent, NSError *error))block andUrl:(NSString *)url {
    
    return [[QWEINetWorkManager sharedChapterClient] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *chapterContentResult = responseObject[@"chapter"];
        QWEIBookContent *bookContent = [QWEIBookContent bookContentModelWithDict:chapterContentResult];
        
        if (block) {
            block(bookContent, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (block) {
            block(nil, error);
        }
    }];
}

@end
