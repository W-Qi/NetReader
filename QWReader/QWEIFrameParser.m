//
//  QWEIFrameParser.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/11.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIFrameParser.h"
#import "QWEIFrameParserConfig.h"

@implementation QWEIFrameParser

+ (CTFrameRef)parserContent:(NSString *)content config:(QWEIFrameParserConfig *)config bouds:(CGRect)bouds {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSDictionary *attribute = [self attributesWithConfig:config];
    [attributedString addAttributes:attribute range:NSMakeRange(0, content.length)];
    
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    
    CGPathRef pathRef = CGPathCreateWithRect(bouds, NULL);
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    
    CFRelease(setterRef);
    CFRelease(pathRef);
    
    return frameRef;
}

+ (NSDictionary *)attributesWithConfig:(QWEIFrameParserConfig *)config {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[NSForegroundColorAttributeName] = config.textColor;
//    dict[NSFontAttributeName] = [UIFont systemFontOfSize:config.fontSize];
    dict[NSFontAttributeName] = [UIFont fontWithName:@"FZShaoEr-M11" size:config.fontSize];
//    [dict setObject:(id)CFBridgingRelease(CTFontCreateWithName(CFSTR("FZShaoEr-M11"), config.fontSize, NULL)) forKey:(id)kCTFontAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.alignment = NSTextAlignmentJustified;
//    paragraphStyle.firstLineHeadIndent = config.fontSize * 2;
    
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    
    return dict.copy;
}

@end
