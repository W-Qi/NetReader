//
//  QWEIBookDetail.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIBookDetail.h"
#import <objc/runtime.h>

@interface QWEIBookDetail ()

@end

@implementation QWEIBookDetail

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.bookSources forKey:@"bookSources"];
    [aCoder encodeObject:self.bookChapters forKey:@"bookChapters"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        self.bookSources = [aDecoder decodeObjectForKey:@"bookSources"];
        self.bookChapters = [aDecoder decodeObjectForKey:@"bookChapters"];
    }
    
    return self;
}


@end
