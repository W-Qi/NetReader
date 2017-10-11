//
//  QWEIBookChapterController.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIBookChapterController.h"

@interface QWEIBookChapterController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation QWEIBookChapterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 160, 0, 150, 44)];
    [btn setTitle:@"倒序" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(reverse) forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 150, 44)];
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [headView addSubview:btn];
    [headView addSubview:backBtn];
    
    [self.view addSubview:headView];
 
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chapterNo inSection:0];
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];

    self.tableView = tableView;
}

- (void)backView {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reverse {
    
    self.bookChapters = [[self.bookChapters reverseObjectEnumerator] allObjects];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bookChapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"BookChapterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    } else {
        
        NSArray *cellSubviews = cell.contentView.subviews;

        for (UIView *cacheView in cellSubviews) {

            [cacheView removeFromSuperview];
        }
    }
    
    cell.textLabel.text = self.bookChapters[indexPath.row].title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bookChapterChange" object:self.bookChapters[indexPath.row]];

    [self dismissViewControllerAnimated:YES completion:^{}];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
