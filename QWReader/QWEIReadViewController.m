//
//  QWEIReadViewController.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/9/10.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIReadViewController.h"
#import "QWEIReadView.h"
#import "QWEIFrameParserConfig.h"
#import "QWEIFrameParser.h"

@interface QWEIReadViewController ()

@end

@implementation QWEIReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[QWEIFrameParserConfig shareInstance].theme];
    [self.view addSubview:self.readView];
    
    [self setupLabelView];
}

- (void)setupLabelView {
    
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    
    [self.view addSubview:[self setupLabelWithFrame:CGRectMake(5, 5, self.view.frame.size.width, 24) text:self.chapterTitle textAlignment:NSTextAlignmentLeft]];
    [self.view addSubview:[self setupLabelWithFrame:CGRectMake(10, self.view.frame.size.height - 24, 100, 24) text:[self currentTime] textAlignment:NSTextAlignmentLeft]];
    [self.view addSubview:[self setupLabelWithFrame:CGRectMake(70, self.view.frame.size.height - 24, 200, 24) text:[NSString stringWithFormat:@"电量剩余:%.0f%%", [[UIDevice currentDevice] batteryLevel] * 100] textAlignment:NSTextAlignmentLeft]];
    [self.view addSubview:[self setupLabelWithFrame:CGRectMake(self.view.frame.size.width - 200, self.view.frame.size.height - 24, 200, 24) text:[NSString stringWithFormat:@"第%lu页，共%lu页", (unsigned long)self.page + 1, (unsigned long)self.pageCount] textAlignment:NSTextAlignmentRight]];
}

- (UILabel *)setupLabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont fontWithName:@"FZShaoEr-M11" size:18.f]];
    label.text = text;
    label.textAlignment = textAlignment;
    
    return label;
}

- (NSString *)currentTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    return dateTime;
}

- (QWEIReadView *)readView {
    
    if (!_readView) {
        
        _readView = [[QWEIReadView alloc] initWithFrame:CGRectMake(LEFT_SPACING, TOP_SPACING, self.view.frame.size.width -LEFT_SPACING - RIGHT_SPACING, self.view.frame.size.height - TOP_SPACING - BOTTOM_SPACING)];
        
        QWEIFrameParserConfig *config = [QWEIFrameParserConfig shareInstance];
        _readView.frameRef = [QWEIFrameParser parserContent:self.content config:config bouds:CGRectMake(0, 0, _readView.frame.size.width, _readView.frame.size.height)];
        _readView.content = self.content;
    }
    
    return _readView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
