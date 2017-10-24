//
//  QWEIMenu.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/10/6.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIMenu.h"

@implementation QWEIMenu

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addTopView];
        [self addBottomView];
    }
    
    return self;
}

- (void)addTopView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    topView.backgroundColor = [UIColor blackColor];
    
    UIButton *backBtn = [self buttonInitWithTitle:nil frame:CGRectMake(10, 20, 150, 44) action:@selector(cannelView)];
    [backBtn setImage:[[UIImage imageNamed:@"bg_back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIButton *linkBtn = [self buttonInitWithTitle:nil frame:CGRectMake(self.frame.size.width - 160, 20, 150, 44) action:@selector(linkView)];
    [linkBtn setImage:[[UIImage imageNamed:@"reader_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    linkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    linkBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  
    [topView addSubview:linkBtn];
    [topView addSubview:backBtn];
    
    [self addSubview:topView];
}

- (void)addBottomView {
    
    CGFloat mainWidth = self.frame.size.width;
    CGFloat btnWidth = (mainWidth - 40)/3;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 64, mainWidth, 64)];
    bottomView.backgroundColor = [UIColor blackColor];
    
    [bottomView addSubview:[self buttonInitWithTitle:@"目录" frame:CGRectMake(10, 0, btnWidth, 64) action:@selector(chapterView)]];
    [bottomView addSubview:[self buttonInitWithTitle:@"夜间" frame:CGRectMake(20 + btnWidth, 0, btnWidth, 64) action:nil]];
    [bottomView addSubview:[self buttonInitWithTitle:@"设置" frame:CGRectMake(30 + 2 * btnWidth, 0, btnWidth, 64) action:@selector(settingView)]];
    
    [self addSubview:bottomView];
}

- (void)cannelView {
    
    if ([self.delegate respondsToSelector:@selector(dismissCurrentController)]) {
        
        [self.delegate dismissCurrentController];
    }
}

- (void)linkView {
    
    if ([self.delegate respondsToSelector:@selector(showLinkView)]) {
        
        [self.delegate showLinkView];
    }
}

- (void)chapterView {
    
    if ([self.delegate respondsToSelector:@selector(showChapterView)]) {
        
        [self.delegate showChapterView];
    }
}

- (void)settingView {
    
    if ([self.delegate respondsToSelector:@selector(showSettingView)]) {
        
        [self.delegate showSettingView];
    }
}

- (UIButton *)buttonInitWithTitle:(NSString *)title frame:(CGRect)rect action:(SEL)sel {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
