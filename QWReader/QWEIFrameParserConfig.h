//
//  QWEIFrameParserConfig.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/11.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWEIFrameParserConfig : NSObject <NSCoding>

@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat lineSpace;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *theme;

+ (instancetype)shareInstance;

@end
