//
//  QWEIBook.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIBook.h"

#import <objc/runtime.h>

@interface QWEIBook()

@property (nonatomic, strong) NSArray *properties;

@end

@implementation QWEIBook

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.shortIntro forKey:@"shortIntro"];
    [aCoder encodeObject:self.latelyFollower forKey:@"latelyFollower"];
    [aCoder encodeObject:self.retentionRatio forKey:@"retentionRatio"];
    [aCoder encodeObject:self.coverImage forKey:@"coverImage"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        self._id = [aDecoder decodeObjectForKey:@"_id"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.cover = [aDecoder decodeObjectForKey:@"cover"];
        self.shortIntro = [aDecoder decodeObjectForKey:@"shortIntro"];
        self.latelyFollower = [aDecoder decodeObjectForKey:@"latelyFollower"];
        self.retentionRatio = [aDecoder decodeObjectForKey:@"retentionRatio"];
        self.coverImage = [aDecoder decodeObjectForKey:@"coverImage"];
    }
    
    return self;
}

- (NSArray *)properties {
    
    if (_properties == nil) {
        
        unsigned int count = 0;
        
        objc_property_t *pts = class_copyPropertyList([QWEIBook class], &count);
        
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

+ (instancetype)booksModelWithDict:(NSDictionary *)dict {
    
    QWEIBook *book = [[self alloc]init];
    
    NSArray *properties = book.properties;
    
    for (NSString *propertyName in properties) {
        
        if (dict[propertyName] != nil) {
            
            [book setValue:dict[propertyName] forKey:propertyName];
        }
    }
    
    return book;
}

@end
