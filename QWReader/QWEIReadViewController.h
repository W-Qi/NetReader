//
//  QWEIReadViewController.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QWEIReadView;

@interface QWEIReadViewController : UIViewController

@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger pageCount;

@property (copy, nonatomic) NSString *chapterTitle;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) QWEIReadView *readView;

@end
