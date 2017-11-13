//
//  AppDelegate.h
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/19.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

