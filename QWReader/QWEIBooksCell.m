//
//  QWEIBooksCell.m
//  QWReader
//
//  Created by Nil.Q_Crackpot on 2017/8/20.
//  Copyright © 2017年 Wei.Chyi. All rights reserved.
//

#import "QWEIBooksCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation QWEIBooksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBookModel:(QWEIBook *)bookModel {
    
    _bookModel = bookModel;
    
    [self loadBook];
}

- (void)loadBook {
    
    [self addImageWithFrame:CGRectMake(5, 5, 90, 90) andUrl:[self.bookModel.cover stringByRemovingPercentEncoding]];
    [self addTitleLabelWithFrame:CGRectMake(100, 0, [UIScreen mainScreen].bounds.size.width - 100, 24)];
    [self addAuthorLabelWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width - 100, 24)];
    [self addShortIntroLabelWithFrame:CGRectMake(100, 50, [UIScreen mainScreen].bounds.size.width - 100, 24)];
}

- (void)addImageWithFrame:(CGRect)frame andUrl:(NSString *)cover{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];

    NSString *url = [NSString stringWithFormat:@"http://statics.zhuishushenqi.com%@", cover];
    
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.contentView addSubview:imageView];    
//    NSRange range;
//    range = [cover rangeOfString:@"/agent/"];
//    if (range.location != NSNotFound) {
//        NSString *imgSrc = [cover substringFromIndex:range.length];
//        NSURL *imaUrl = [NSURL URLWithString:imgSrc];
//        
//        [imageView setImageWithURL:imaUrl placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        
//        [self.contentView addSubview:imageView];
//    }else{
//        NSLog(@"Not Found");
//    }
}

- (UILabel *)addTitleLabelWithFrame:(CGRect)frame {
    
    UILabel *title = [[UILabel alloc] initWithFrame:frame];
    title.numberOfLines = 0;
    title.text = self.bookModel.title;
    title.textAlignment = NSTextAlignmentCenter;
    [title sizeToFit];
    
    [self.contentView addSubview:title];
    
    return title;
}

- (UILabel *)addAuthorLabelWithFrame:(CGRect)frame {
    
    UILabel *title = [[UILabel alloc] initWithFrame:frame];
    title.numberOfLines = 0;
    title.text = self.bookModel.author;
    title.textAlignment = NSTextAlignmentLeft;
    UIFont *font = [UIFont systemFontOfSize:12];
    
    title.font = font;
    
    [title sizeToFit];
    
    [self.contentView addSubview:title];
    
    return title;
}

- (UILabel *)addShortIntroLabelWithFrame:(CGRect)frame {
    
    UILabel *title = [[UILabel alloc] initWithFrame:frame];
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    title.text = self.bookModel.shortIntro;
    title.textAlignment = NSTextAlignmentLeft;
    UIFont *font = [UIFont systemFontOfSize:14];
    
    title.font = font;
    
    [self.contentView addSubview:title];
    
    return title;
}

@end
