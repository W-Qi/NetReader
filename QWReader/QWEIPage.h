//
//  QWEIPage.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QWEIBookContent.h"

@interface QWEIPage : NSObject

+ (NSURLSessionDataTask *)getBookContent:(void (^)(QWEIBookContent *bookContent, NSError *error))block andUrl:(NSString *)url;

@end
