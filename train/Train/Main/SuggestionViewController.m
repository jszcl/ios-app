//
//  SuggestionViewController.m
//  Train
//
//  Created by 金烨 on 16/11/9.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "SuggestionViewController.h"
#import "NetworkManager.h"

@interface SuggestionViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitBarButtonItem;

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.cornerRadius = 4;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.borderWidth = 1;
    self.submitBarButtonItem.enabled = NO;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length < 1) {
        self.submitBarButtonItem.enabled = NO;
    }else{
        self.submitBarButtonItem.enabled = YES;
    }
}

- (IBAction)submitAction:(id)sender {
    [[NetworkManager shared] requestWithMethod:POST url:@"api/v1/users/suggestion" parametes:@{@"content":self.textView.text} successBlock:^(NSDictionary *value) {
        [self.navigationController popViewControllerAnimated:YES];
    } failBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
