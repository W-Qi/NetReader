//
//  QWEIBookSource.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWEIBookSource : NSObject <NSCoding>

@property (copy, nonatomic) NSString *_id;
@property (copy, nonatomic) NSString *name;

+ (instancetype)bookSourceModelWithDict:(NSDictionary *)dict;

@end
