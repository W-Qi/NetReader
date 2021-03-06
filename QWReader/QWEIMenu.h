//
//  QWEIMenu.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/10/6.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QWEIMenuDelegate <NSObject>

- (void)dismissCurrentController;
- (void)showLinkView;
- (void)showChapterView;
- (void)showSettingView;
- (void)readContext;
- (void)downloadBook;

@end

@interface QWEIMenu : UIView

@property (assign, nonatomic) id<QWEIMenuDelegate> delegate;
@property (copy, nonatomic) NSString *bookName;

@end
