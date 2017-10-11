//
//  QWEISearchBookController.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEISearchBookController.h"
#import "QWEISearchBook.h"
#import "QWEIBooksCell.h"
#import "QWEIReader.h"

@interface QWEISearchBookController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *booksView;
@property (strong, nonatomic) NSArray<QWEIBook *> *books;

@end

@implementation QWEISearchBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.hidesBarsOnTap = NO;
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    [self initialization];
}

- (void)initialization {
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [searchBar sizeToFit];
    [searchBar becomeFirstResponder];
    
    UITableView *booksView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    booksView.delegate = self;
    booksView.dataSource = self;
    booksView.rowHeight = 100;
    
    self.booksView = booksView;
    
    self.view = booksView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"BookCell";
    
    QWEIBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[QWEIBooksCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    } else {
        
        NSArray *cellSubviews = cell.contentView.subviews;
        
        for (UIView *cacheView in cellSubviews) {
            
            [cacheView removeFromSuperview];
        }
    }
    
    cell.bookModel = self.books[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QWEIBook *book = self.books[indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:[NSString stringWithFormat:@"是否添加《%@》到书架", book.title]
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        QWEIBooksCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSArray *cellSubviews = cell.contentView.subviews;
        
        for (UIView *cacheView in cellSubviews) {
            
            if ([cacheView isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView = (UIImageView *)cacheView;
                book.coverImage = UIImageJPEGRepresentation(imageView.image, 0.5);
            }
        }
        
        NSString *appDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        NSData  *bookData = [NSKeyedArchiver archivedDataWithRootObject:book];
        [bookData writeToFile:[appDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", book._id]] atomically:YES];
        
        NSLog(@"%@", appDocPath);
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    NSString *bookName = searchBar.text;
    
    NSString *searchBookUrl = [NSString stringWithFormat:@"book/fuzzy-search?query=%@&start=0&limit=100", bookName];
    searchBookUrl = [searchBookUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [QWEISearchBook searchBook:^(NSArray<QWEIBook *> *books, NSError *error) {
        
        self.books = books;
        
        [self.booksView reloadData];
    } andUrl:searchBookUrl];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
        
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.books = nil;
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
