//
//  QWEIBookSource.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIBookSource.h"
#import <objc/runtime.h>

@interface QWEIBookSource ()

@property (strong, nonatomic) NSArray *properties;

@end

@implementation QWEIBookSource

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        self._id = [coder decodeObjectForKey:@"_id"];
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

- (NSArray *)properties {
    
    if (_properties == nil) {
        
        unsigned int count = 0;
        
        objc_property_t *pts = class_copyPropertyList([QWEIBookSource class], &count);
        
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

+ (instancetype)bookSourceModelWithDict:(NSDictionary *)dict {
    
    QWEIBookSource *bookSource = [[self alloc] init];
    
    NSArray *properties = bookSource.properties;
    
    for (NSString *propertyName in properties) {
        
        if (dict[propertyName] != nil) {
            
            [bookSource setValue:dict[propertyName] forKey:propertyName];
        }
    }
    
    return bookSource;
}

@end
