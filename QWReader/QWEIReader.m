//
//  QWEIReader.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIReader.h"
#import "QWEIGetBookDetail.h"
#import "QWEIPage.h"
#import "QWEIBookLinkController.h"
#import "QWEIBookDetail.h"
#import "QWEIBookChapterController.h"
#import "QWEIReadViewController.h"
#import "QWEIMenu.h"
#import "QWEISettingView.h"
#import "QWEIFrameParserConfig.h"

#import <AVFoundation/AVFoundation.h>

@interface QWEIReader () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIWebViewDelegate, UIGestureRecognizerDelegate, QWEIMenuDelegate, QWEISettingViewDelegate, AVSpeechSynthesizerDelegate>
{
    NSUInteger _page;
    NSUInteger _beforePageCount;
    BOOL _isReading;
    BOOL _isChapterBegin;
    BOOL _isCam;
    UIColor *_currentColor;
}

@property (strong, nonatomic) QWEIBookDetail *bookDetail;

@property (strong, nonatomic) QWEIBookContent *beforeBookContent;
@property (strong, nonatomic) QWEIBookContent *bookContent;

@property (assign, nonatomic) NSUInteger pageNo;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) QWEIMenu *menuView;
@property (strong, nonatomic) QWEISettingView *settingView;

@property (copy, nonatomic) NSString *linkSourceID;

@property (strong, nonatomic) AVSpeechSynthesizer *speechSynthesizer;
@property (strong, nonatomic) AVSpeechUtterance *speechUtterance;

@property (strong, nonatomic) AVCaptureSession *camSession;

@end

@implementation QWEIReader



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
