//
//  QWEIFrameParser.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/11.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QWEIFrameParserConfig;

@interface QWEIFrameParser : NSObject

+ (CTFrameRef)parserContent:(NSString *)content config:(QWEIFrameParserConfig *)config bouds:(CGRect)bouds;

+ (NSDictionary *)attributesWithConfig:(QWEIFrameParserConfig *)config;

@end
