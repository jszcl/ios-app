//
//  HUDView.m
//  Train
//
//  Created by 金烨 on 16/11/8.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "HUDView.h"

@interface HUDView ()

@property(nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;

@end

@implementation HUDView

- (void)showHUD{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.activityIndicatorView.center = [UIApplication sharedApplication].keyWindow.center;
    self.activityIndicatorView.backgroundColor = [UIColor grayColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.activityIndicatorView];
    self.activityIndicatorView.hidden =NO;
    [self.activityIndicatorView startAnimating];
    
}

- (void)hiddenHUD{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
}

@end
