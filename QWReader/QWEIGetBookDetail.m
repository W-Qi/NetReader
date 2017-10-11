//
//  QWEIGetBookDetail.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIGetBookDetail.h"
#import "QWEINetWorkManager.h"
#import "QWEIBookSource.h"
#import "QWEIBookChapter.h"

@implementation QWEIGetBookDetail

+ (NSURLSessionDataTask *)getBookSources:(void (^)(NSArray<QWEIBookSource *> *bookSources, NSError *error))block andUrl:(NSString *)url {
    
    return [[QWEINetWorkManager sharedClient] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray<QWEIBookSource *> *bookSources = [[NSMutableArray alloc] init];
        
        for (NSDictionary *resultDic in responseObject) {
            
            if ([resultDic[@"source"] isEqualToString:@"zhuishuvip"]) {
                
                continue;
            }
            
            QWEIBookSource *bookSource = [QWEIBookSource bookSourceModelWithDict:resultDic];
            [bookSources addObject:bookSource];
        }
        
        if (block) {
            block(bookSources, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (block) {
            block(nil, error);
        }
    }];
}

+ (NSURLSessionDataTask *)getBookChapters:(void (^)(NSArray<QWEIBookChapter *> *bookChapters, NSError *error))block andUrl:(NSString *)url {
    
    return [[QWEINetWorkManager sharedClient] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *chaptersResult = responseObject[@"chapters"];
        NSMutableArray <QWEIBookChapter *> *chapters = [NSMutableArray arrayWithCapacity:chaptersResult.count];
        
        for (NSDictionary *chapterDic in chaptersResult) {
            
            QWEIBookChapter *bookChapter = [QWEIBookChapter bookChapterModelWithDict:chapterDic];
            [chapters addObject:bookChapter];
        }
        
        if (block) {
            block(chapters, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (block) {
            block(nil, error);
        }
    }];
}

@end
