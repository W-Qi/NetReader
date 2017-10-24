//
//  QWEIFrameParserConfig.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/11.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIFrameParserConfig.h"

@implementation QWEIFrameParserConfig

+ (instancetype)shareInstance {
    
    static QWEIFrameParserConfig *parserConfig = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        parserConfig = [[self alloc] init];
    });
    
    return parserConfig;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        NSData *configData = [[NSUserDefaults standardUserDefaults] objectForKey:CONFIG_KEY];
        
        if (configData) {
            
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:configData];
            
            QWEIFrameParserConfig *parserConfig = [unarchiver decodeObjectForKey:CONFIG_KEY];
            [parserConfig addObserver:parserConfig forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
            [parserConfig addObserver:parserConfig forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
            [parserConfig addObserver:parserConfig forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:NULL];
            [parserConfig addObserver:parserConfig forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
            
            return parserConfig;
        }
        
        _fontSize = 24.f;
        _lineSpace = 20.f;
        _textColor = [UIColor blackColor];
        _theme = [UIColor colorWithRed:199/255.f green:237/255.f blue:204/255.f alpha:1.f];
        
        [self addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
        
        [QWEIFrameParserConfig updateConfig:self];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [QWEIFrameParserConfig updateConfig:self];
}

+ (void)updateConfig:(QWEIFrameParserConfig *)config {
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:config forKey:CONFIG_KEY];
    [archiver finishEncoding];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:CONFIG_KEY];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeDouble:self.fontSize forKey:@"fontSize"];
    [aCoder encodeDouble:self.lineSpace forKey:@"lineSpace"];
    [aCoder encodeObject:self.textColor forKey:@"textColor"];
    [aCoder encodeObject:self.theme forKey:@"theme"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        self.fontSize = [aDecoder decodeDoubleForKey:@"fontSize"];
        self.lineSpace = [aDecoder decodeDoubleForKey:@"lineSpace"];
        self.textColor = [aDecoder decodeObjectForKey:@"textColor"];
        self.theme = [aDecoder decodeObjectForKey:@"theme"];
    }
    
    return self;
}

@end
