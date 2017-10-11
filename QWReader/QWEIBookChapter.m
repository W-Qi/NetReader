//
//  QWEIBookChapter.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIBookChapter.h"
#import <objc/runtime.h>

@interface QWEIBookChapter ()

@property (strong, nonatomic) NSArray *properties;

@end

@implementation QWEIBookChapter

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        self.link = [aDecoder decodeObjectForKey:@"link"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.link forKey:@"link"];
    [aCoder encodeObject:self.title forKey:@"title"];
}

- (NSArray *)properties {
    
    if (_properties == nil) {
        
        unsigned int count = 0;
        
        objc_property_t *pts = class_copyPropertyList([QWEIBookChapter class], &count);
        
        NSMutableArray *propertyNames = [NSMutableArray arrayWithCapacity:count];
        
        for (int i = 0; i < count; i++) {
            
            objc_property_t opt = pts[i];
            
            const char *cPropertyName = property_getName(opt);
            
            NSString *propertyName = [[NSString alloc] initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
            
            [propertyNames addObject:propertyName];
        }
        
        free(pts);
        
        _properties = propertyNames.copy;
    }
    
    return _properties;
}

+ (instancetype)bookChapterModelWithDict:(NSDictionary *)dict {
    
    QWEIBookChapter *bookChapter = [[self alloc] init];
    
    NSArray *properties = bookChapter.properties;
    
    for (NSString *propertyName in properties) {
        
        if (dict[propertyName] != nil) {
            
            [bookChapter setValue:dict[propertyName] forKey:propertyName];
        }
    }
    
    return bookChapter;
}

@end
