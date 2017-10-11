//
//  QWEIBookChapter.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWEIBookChapter : NSObject <NSCoding>

@property (copy, nonatomic) NSString *link;
@property (copy, nonatomic) NSString *title;

+ (instancetype)bookChapterModelWithDict:(NSDictionary *)dict;

@end
