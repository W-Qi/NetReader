//
//  QWEIBookLinkController.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWEIBookSource.h"

@interface QWEIBookLinkController : UITableViewController

@property (strong, nonatomic) NSArray<QWEIBookSource *> *bookSources;

@end
