//
//  QWEIReadView.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIReadView.h"

@implementation QWEIReadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];  
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    if (!self.frameRef) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw(self.frameRef, context);
}

- (void)setFrameRef:(CTFrameRef)frameRef {
    
    if (_frameRef != frameRef) {
        
        if (_frameRef) {
            
            CFRelease(_frameRef);
            _frameRef = nil;
        }
        
        _frameRef = frameRef;
    }
}

- (void)dealloc {
    
    if (_frameRef) {
        
        CFRelease(_frameRef);
        _frameRef = nil;
    }
}

@end
