//
//  QWEISettingView.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/10/25.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QWEISettingViewDelegate <NSObject>

- (void)updateContext;

@end

@interface QWEISettingView : UIView

@property (assign, nonatomic) id<QWEISettingViewDelegate> delegate;

@end
