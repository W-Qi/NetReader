//
//  QWEIBook.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWEIBook : NSObject<NSCoding>

@property (copy, nonatomic) NSString *_id;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *author;
@property (copy, nonatomic) NSString *cover;
@property (copy, nonatomic) NSString *shortIntro;
@property (copy, nonatomic) NSString *latelyFollower;
@property (copy, nonatomic) NSString *retentionRatio;
@property (strong, nonatomic) NSData *coverImage;

+ (instancetype)booksModelWithDict:(NSDictionary *)dict;

@end
