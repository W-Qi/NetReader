//
//  QWEIBookChapterController.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWEIBookChapter.h"

@interface QWEIBookChapterController : UIViewController

@property (strong, nonatomic) NSArray<QWEIBookChapter *> *bookChapters;
@property (assign, nonatomic) NSUInteger chapterNo;

@end
