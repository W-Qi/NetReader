//
//  QWEIBookContent.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWEIBookContent : NSObject <NSCoding>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;
@property (nonatomic) NSUInteger pageCount;

+ (instancetype)bookContentModelWithDict:(NSDictionary *)dict;

- (NSString *)stringOfPage:(NSUInteger)index;
- (void)updateContext;

@end
