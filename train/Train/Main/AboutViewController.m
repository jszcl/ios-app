//
//  AboutViewController.m
//  Train
//
//  Created by 金烨 on 16/11/9.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "AboutViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface AboutViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Html/index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"backToMain"] = ^(){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
