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

@interface QWEIReader () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIWebViewDelegate, UIGestureRecognizerDelegate, QWEIMenuDelegate, QWEISettingViewDelegate>
{
    NSUInteger _page;
    NSUInteger _beforePageCount;
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

@end

@implementation QWEIReader

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (_page == 0 && self.pageNo == 0) {
        
        return nil;
    }
    
    if (_page == 0 && self.pageNo > 0) {
        
        self.pageNo--;
        _page = _beforePageCount;
        
        QWEIReadViewController *readViewController = [[QWEIReadViewController alloc] init];
        readViewController.content =  [self.beforeBookContent stringOfPage:_page];
        
        return readViewController;
    } else {
        
        _page--;
    }
    
    return [self readViewWithChapter:0 page:_page];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    _page++;
    
    if (_page == self.bookContent.pageCount) {
        _beforePageCount = self.bookContent.pageCount - 1;
        self.pageNo++;
        _page = 0;
        [self showContent:self.bookDetail.bookChapters[self.pageNo].link];
        
        return nil;
    }
    
    return [self readViewWithChapter:0 page:_page];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    
    return self.menuView.hidden;
}

- (void)loadBookDetail {
    NSString *url = [NSString stringWithFormat:@"toc?view=summary&book=%@", self.bookID];
    
    [QWEIGetBookDetail getBookSources:^(NSArray<QWEIBookSource *> *bookSources, NSError *error) {
        
        self.bookDetail.bookSources = bookSources;
        
        if(bookSources.count != 0) {
            
            if (!self.linkSourceID) {
                
                self.linkSourceID = bookSources[0]._id;
            }
            [self loadBook:self.linkSourceID];
        }
    } andUrl:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
}

- (void)loadBook:(NSString *)linkID {
    
    self.pageNo = self.pageNo == 0 ? 0 : self.pageNo--;
    
    NSString *baseURL = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/toc/%@?view=chapters", linkID];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:baseURL]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSData *contextData = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.innerText"] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:contextData options:0 error:nil];
    
    NSArray *chaptersResult = responseObject[@"chapters"];
    NSMutableArray <QWEIBookChapter *> *chapters = [NSMutableArray arrayWithCapacity:chaptersResult.count];
    
    for (NSDictionary *chapterDic in chaptersResult) {
        
        QWEIBookChapter *bookChapter = [QWEIBookChapter bookChapterModelWithDict:chapterDic];
        [chapters addObject:bookChapter];
    }
    
    self.bookDetail.bookChapters = chapters;
    
    [self showContent:self.bookDetail.bookChapters[self.pageNo].link];
}

- (void)showContent:(NSString *)link {
    
    self.beforeBookContent = self.bookContent;
    
    [QWEIPage getBookContent:^(QWEIBookContent *bookContent, NSError *error) {
        
        self.bookContent = bookContent;
        
    } andUrl:[link stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.pageViewController];
    
    [self addObserver:self forKeyPath:@"bookContent" options:NSKeyValueObservingOptionNew context:NULL];
  
    [self.view addGestureRecognizer:({
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolViewController)];
        tapGestureRecognizer.delegate = self;
        tapGestureRecognizer;
    })];
    
    [self.view addSubview:self.menuView];
    self.bookDetail = [[QWEIBookDetail alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkSourceChange:) name:@"linkSourceChange" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bookChapterChange:) name:@"bookChapterChange" object:nil];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    webView.delegate = self;
    
    self.webView = webView;
    
    [self.view addSubview:webView];
    
    NSString *appDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    appDocPath = [appDocPath stringByAppendingPathComponent:self.bookID];
    NSString *filePath = [appDocPath stringByAppendingPathComponent:@"pageMessage.plist"];
    
    NSDictionary *pageMessage = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    if (pageMessage) {
        
        self.pageNo = [[pageMessage valueForKey:@"pageNo"] integerValue];
        _page = [[pageMessage valueForKey:@"page"] integerValue];
        self.linkSourceID = [pageMessage valueForKey:@"linkSourceID"];
    } else {

        self.pageNo = 0;
        _page = 0;
    }
    
    [self loadBookDetail];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self.pageViewController setViewControllers:@[[self readViewWithChapter:0 page:_page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)showToolViewController {
    
    self.menuView.hidden = !self.menuView.hidden;
    self.settingView.hidden = YES;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (QWEIReadViewController *)readViewWithChapter:(NSUInteger)chapter page:(NSUInteger)page {
    
    QWEIReadViewController *readViewController = [[QWEIReadViewController alloc] init];
    readViewController.chapterTitle = self.bookDetail.bookChapters[self.pageNo].title;
    readViewController.content =  [self.bookContent stringOfPage:page];
    readViewController.page = _page;
    readViewController.pageCount = self.bookContent.pageCount;
    
    [self saveMessage];
    
    return readViewController;
}

- (void)showChapterView {
    
    QWEIBookChapterController *bookChapter = [[QWEIBookChapterController alloc] init];
    bookChapter.bookChapters = self.bookDetail.bookChapters;
    bookChapter.chapterNo = self.pageNo;
    [self presentViewController:bookChapter animated:YES completion:^{}];
}

- (void)bookChapterChange:(NSNotification *)notification {
    
    _page = 0;
    
    QWEIBookChapter *selectBookChapter = [notification object];
    
    self.pageNo = [self.bookDetail.bookChapters indexOfObject:selectBookChapter];
    
    [self showContent:selectBookChapter.link];
}

- (void)linkSourceChange:(NSNotification *)notification {
    
    NSString *message = notification.object;
    self.linkSourceID = message;
    
    [self loadBook:self.linkSourceID];
}

- (void)showLinkView {
    
    QWEIBookLinkController *bookLink = [[QWEIBookLinkController alloc] init];
    bookLink.bookSources = self.bookDetail.bookSources;
    [self presentViewController:bookLink animated:YES completion:^{}];
}

#warning 设置页面
- (void)showSettingView {
    
    //设置页面
    self.settingView.hidden = !self.settingView.hidden;
}

- (void)updateContext {
    
    double local = _page * 1.00/self.bookContent.pageCount;
    
    [self.bookContent updateContext];
    _page = local * self.bookContent.pageCount;
    
    [self.pageViewController setViewControllers:@[[self readViewWithChapter:0 page:_page]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
    }
    
    return _pageViewController;
}

- (QWEIMenu *)menuView {
    
    if (!_menuView) {
        
        _menuView = [[QWEIMenu alloc] initWithFrame:self.view.frame];
        _menuView.delegate = self;
        _menuView.hidden = YES;
    }
    
    return _menuView;
}

- (QWEISettingView *)settingView {
    
    if (!_settingView) {
        
        _settingView = [[QWEISettingView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 264, self.view.frame.size.width, 200)];
        _settingView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
        _settingView.delegate = self;
        _settingView.hidden = YES;
        [self.view addSubview:_settingView];
    }
    
    return _settingView;
}

- (void)dismissCurrentController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self removeObserver:self forKeyPath:@"bookContent"];
    
    [self saveMessage];
}

- (void)saveMessage {
    
    NSString *appDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    appDocPath = [appDocPath stringByAppendingPathComponent:self.bookID];
    
    NSLog(@"文件路径%@", appDocPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:appDocPath isDirectory:&isDir];
    
    if (!(isDirExist && isDir)) {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:appDocPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件夹失败！");
        }
        NSLog(@"创建文件夹成功，文件路径%@", appDocPath);
    }
    NSString *filePath = [appDocPath stringByAppendingPathComponent:@"pageMessage.plist"];
    NSMutableDictionary *pageMessage = [[NSMutableDictionary alloc] init];
    [pageMessage setValue:@(self.pageNo) forKey:@"pageNo"];
    [pageMessage setValue:@(_page) forKey:@"page"];
    [pageMessage setValue:self.linkSourceID forKey:@"linkSourceID"];
    [pageMessage writeToFile:filePath atomically:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
