//
//  QWEIBookContent.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIBookContent.h"
#import <objc/runtime.h>
#import "QWEIFrameParser.h"
#import "QWEIFrameParserConfig.h"

@interface QWEIBookContent ()

@property (strong, nonatomic) NSArray *properties;
@property (strong, nonatomic) NSMutableArray *pageArray;

@end

@implementation QWEIBookContent

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.body forKey:@"body"];
    [aCoder encodeInteger:self.pageCount forKey:@"pageCount"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.body = [aDecoder decodeObjectForKey:@"body"];
        self.pageCount = [aDecoder decodeIntegerForKey:@"pageCount"];
    }
    
    return self;
}

- (NSArray *)properties {
    
    if (_properties == nil) {
        
        unsigned int count = 0;
        
        objc_property_t *pts = class_copyPropertyList([QWEIBookContent class], &count);
        
        NSMutableArray *propertyNames = [NSMutableArray arrayWithCapacity:count];
        
        for (int i = 0; i < count; i++) {
            
            objc_property_t opt = pts[i];
            
            const char *cPropertyName = property_getName(opt);
            
            NSString *propertyName = [NSString stringWithCString:cPropertyName encoding:NSUTF8StringEncoding];
            
            [propertyNames addObject:propertyName];
        }
        
        free(pts);
        
        _properties = propertyNames.copy;
    }
    
    return _properties;
}

+ (instancetype)bookContentModelWithDict:(NSDictionary *)dict {
    
    QWEIBookContent *bookContent = [[self alloc] init];
    
    NSArray *properties = bookContent.properties;
    
    for (NSString *propertyName in properties) {
        
        if (dict[propertyName] != nil) {
            
            [bookContent setValue:dict[propertyName] forKey:propertyName];
        }
    }
    
    return bookContent;
}

- (void)setBody:(NSString *)body {
    
//    _body = [NSString stringWithFormat:@"%@\n\n%@", self.title, body];
    
    _body = body;
    
    [self updateContext];
}

- (void)updateContext {
    
    [self paginateWithBounds:CGRectMake(LEFT_SPACING, TOP_SPACING, [UIScreen mainScreen].bounds.size.width - LEFT_SPACING - RIGHT_SPACING, [UIScreen mainScreen].bounds.size.height - TOP_SPACING - BOTTOM_SPACING)];
}

- (void)paginateWithBounds:(CGRect)bounds {
    
    [self.pageArray removeAllObjects];
    
    NSDictionary *attrDict = [QWEIFrameParser attributesWithConfig:[QWEIFrameParserConfig shareInstance]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.body];
    [attrStr setAttributes:attrDict range:NSMakeRange(0, attrStr.length)];
    
    NSAttributedString *attributeString = attrStr.copy;
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributeString);
    
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    
    int currentOffset = 0;
    int currentInnerOffset = 0;
    BOOL hasMorePages = YES;
    
    int preventDeadLoopSign = currentOffset;
    int samePlaceRepeatCount = 0;
    
    while (hasMorePages) {
        
        if (preventDeadLoopSign == currentOffset) {
            
            ++samePlaceRepeatCount;
        } else {
            
            samePlaceRepeatCount = 0;
        }
        
        if (samePlaceRepeatCount > 1) {
            
            if (self.pageArray.count == 0) {
                
                [self.pageArray addObject:@(currentOffset)];
            } else {
                
                NSInteger lastOffset = [[self.pageArray lastObject] integerValue];
                
                if (lastOffset != currentOffset) {
                    
                    [self.pageArray addObject:@(currentOffset)];
                }
            }
            
            break;
        }
        
        [self.pageArray addObject:@(currentOffset)];
        
        CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentOffset, 0), path, NULL);
        CFRange range = CTFrameGetVisibleStringRange(frameRef);
        
        if ((range.location + range.length) != attributeString.length) {
            
            currentOffset += range.length;
            currentInnerOffset += range.length;
        } else {
            
            hasMorePages = NO;
        }
        
        if (frameRef) {
            
            CFRelease(frameRef);
        }
    }
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    
    self.pageCount = self.pageArray.count;
}

- (NSString *)stringOfPage:(NSUInteger)index {
    
    NSInteger local = [self.pageArray[index] integerValue];
    NSInteger length;
    
    if (index < self.pageCount - 1) {
        
        length = [self.pageArray[index + 1] integerValue] - [self.pageArray[index] integerValue];
    } else {
        
        length = self.body.length - [self.pageArray[index] integerValue];
    }
    
    return [self.body substringWithRange:NSMakeRange(local, length)];
}

- (NSMutableArray *)pageArray {
    
    if (!_pageArray) {
        
        _pageArray = [NSMutableArray array];
    }
    
    return _pageArray;
}

@end
