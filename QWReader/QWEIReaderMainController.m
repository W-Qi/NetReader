//
//  QWEIReaderMainController.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/19.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIReaderMainController.h"
#import "QWEISearchBookController.h"
#import "QWEIBook.h"
#import "QWEIReader.h"

@interface QWEIReaderMainController ()

@property (strong, nonatomic) NSMutableArray<QWEIBook *> *books;

@end

@implementation QWEIReaderMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"书架";
    self.tableView.rowHeight = 100;
    
    UIBarButtonItem *addBookBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBook)];
    
    self.navigationItem.rightBarButtonItem = addBookBtn;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.hidesBarsOnTap = NO;
    
    [self loadBook];
}

- (void)loadBook {
    
    self.books = [NSMutableArray array];
    
    NSString *appDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:appDocPath error:nil];
    
    for (NSString *fileName in files) {
        
        QWEIBook *book = [NSKeyedUnarchiver unarchiveObjectWithFile:[appDocPath stringByAppendingPathComponent:fileName]];
        
        if (book) {
            
            [self.books addObject:book];
        }
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBook {
    
    QWEISearchBookController *searchBookController = [[QWEISearchBookController alloc] init];
    
    [self.navigationController pushViewController:searchBookController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"MainBookCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    } else {
        
        NSArray *cellSubviews = cell.contentView.subviews;
        
        for (UIView *cacheView in cellSubviews) {
            
            [cacheView removeFromSuperview];
        }
    }
    
    if (self.books.count != 0) {
        
        cell.textLabel.text = self.books[indexPath.row].title;
        cell.imageView.image = [UIImage imageWithData:self.books[indexPath.row].coverImage];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QWEIBook *book = self.books[indexPath.row];
    QWEIReader *reader = [[QWEIReader alloc] init];
    reader.bookID = book._id;
    
    [self presentViewController:reader animated:YES completion:nil];
    
//    [self.navigationController pushViewController:reader animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSString *appDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        [[NSFileManager defaultManager] removeItemAtPath:[appDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", self.books[indexPath.row]._id]] error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:[appDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", self.books[indexPath.row]._id]] error:nil];
        
        [self.books removeObject:self.books[indexPath.row]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
