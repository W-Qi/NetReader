//
//  QWEISettingView.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/10/25.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEISettingView.h"
#import "QWEIFrameParserConfig.h"

@implementation QWEISettingView

- (void)didMoveToSuperview {
    
    [self setupFontSizeView];
    
    [self setupThemeView];
}

- (void)setupFontSizeView {
    
    [self addSubview:[self setupBtnWithFrame:CGRectMake(0, 0, 80, 80) title:@"A+" action:@selector(fontSizeUp)]];
    [self addSubview:[self setupBtnWithFrame:CGRectMake(85, 0, 80, 80) title:@"A-" action:@selector(fontSizeDown)]];
}

- (void)setupThemeView {
    
    [self addSubview:[self setupBtnWithFrame:CGRectMake(0, 85, 80, 80) title:@"theme" action:@selector(themeCannel)]];
    [self addSubview:[self setupBtnWithFrame:CGRectMake(85, 85, 80, 80) title:@"theme" action:@selector(themeEyeColor)]];
}

- (void)themeCannel {
    
    QWEIFrameParserConfig *config = [QWEIFrameParserConfig shareInstance];

    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    
    config.theme = [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.f];
    
    if ([self.delegate respondsToSelector:@selector(updateContext)]) {
        
        [self.delegate updateContext];
    }
}

- (void)themeEyeColor {
    
    QWEIFrameParserConfig *config = [QWEIFrameParserConfig shareInstance];
    
    config.theme = [UIColor colorWithRed:199/255.f green:237/255.f blue:204/255.f alpha:1.f];
    
    if ([self.delegate respondsToSelector:@selector(updateContext)]) {
        
        [self.delegate updateContext];
    }
}

- (void)fontSizeUp {
    
    QWEIFrameParserConfig *config = [QWEIFrameParserConfig shareInstance];
    
    [config setFontSize:++config.fontSize];
    
    if ([self.delegate respondsToSelector:@selector(updateContext)]) {
        
        [self.delegate updateContext];
    }
}

- (void)fontSizeDown {
    
    QWEIFrameParserConfig *config = [QWEIFrameParserConfig shareInstance];
    
    [config setFontSize:--config.fontSize];
    
    if ([self.delegate respondsToSelector:@selector(updateContext)]) {
        
        [self.delegate updateContext];
    }
}

- (UIButton *)setupBtnWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    
    return btn;
}

@end
