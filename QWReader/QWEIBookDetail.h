//
//  QWEIBookDetail.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QWEIBookSource.h"
#import "QWEIBookChapter.h"

@interface QWEIBookDetail : NSObject

@property (strong, nonatomic) NSArray<QWEIBookSource *> *bookSources;
@property (strong, nonatomic) NSArray<QWEIBookChapter *> *bookChapters;

@end
