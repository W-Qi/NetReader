//
//  QWEISearchBook.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QWEIBook.h"

@interface QWEISearchBook : NSObject

+ (NSURLSessionDataTask *)searchBook:(void (^)(NSArray<QWEIBook *> *books, NSError *error))block andUrl:(NSString *)url;

@end
