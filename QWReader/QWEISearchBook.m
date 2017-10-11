//
//  QWEISearchBook.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEISearchBook.h"
#import "QWEINetWorkManager.h"


#import "QWEIBook.h"

@implementation QWEISearchBook

+ (NSURLSessionDataTask *)searchBook:(void (^)(NSArray<QWEIBook *> *books, NSError *error))block andUrl:(NSString *)url {
    
    return [[QWEINetWorkManager sharedClient] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *result = responseObject[@"books"];
        
        NSMutableArray *books = [NSMutableArray arrayWithCapacity:result.count];
        
        for (NSDictionary *bookDic in result) {
            
            QWEIBook *book = [QWEIBook booksModelWithDict:bookDic];
            
            [books addObject:book];
        }
        
        if (block) {
            block(books.copy, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (block) {
            block(nil, error);
        }
    }];
}

@end
