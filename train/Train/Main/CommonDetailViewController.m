//
//  CommonDetailViewController.m
//  Train
//
//  Created by 金烨 on 16/11/9.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "CommonDetailViewController.h"

@interface CommonDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (nonatomic, strong) NSArray *pictures;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end

@implementation CommonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"这个是标题";
    self.sourceLabel.text = @"来源于中行培训中心";
    self.bodyLabel.text = @"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz";
    self.dateLabel.text = [self turnTimeStamp:1477280698];
    
    self.pictures = @[[UIImage imageNamed:@"common_me"],[UIImage imageNamed:@"logo"],[UIImage imageNamed:@"首页-首页"]];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.pictures.count, 200);
    self.scrollView.pagingEnabled = YES;
    for (int i = 0; i < self.pictures.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithImage:self.pictures[i]];
        imageView.frame = CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, 200);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = self.pictures.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.view.bounds.size.width;
    self.pageControl.currentPage = page;
}

//时间戳转换
- (NSString *)turnTimeStamp:(NSInteger)timeStamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    return [formatter stringFromDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
