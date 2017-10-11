//
//  QWEIGetBookDetail.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QWEIBookSource.h"
#import "QWEIBookChapter.h"

@interface QWEIGetBookDetail : NSObject

+ (NSURLSessionDataTask *)getBookSources:(void (^)(NSArray<QWEIBookSource *> *bookSources, NSError *error))block andUrl:(NSString *)url;

+ (NSURLSessionDataTask *)getBookChapters:(void (^)(NSArray<QWEIBookChapter *> *bookChapters, NSError *error))block andUrl:(NSString *)url;

@end
