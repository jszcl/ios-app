//
//  LoginViewController.m
//  Train
//
//  Created by 金烨 on 16/11/7.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkManager.h"
#import "MainViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

//只执行一次
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phoneTextField addTarget:self action:@selector(phoneChangedAction) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(passwordChangedAction) forControlEvents:UIControlEventEditingChanged];
    self.loginButton.enabled = NO;//设为不可点击状态
    NSString *phone =[[NSUserDefaults standardUserDefaults] objectForKey:@"Phone"];
    if (phone) {
        [self pushAction];
    }
}

//会多次执行(视图将要出现时)
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - PrivateMethod
//手机号码有更改时调用此方法
- (void)phoneChangedAction{
    if (self.phoneTextField.text.length >= 11 && self.passwordTextField.text.length >= 6) {
        //截取十一位手机号码
        self.phoneTextField.text = [self.phoneTextField.text substringToIndex:11];
        self.loginButton.enabled = YES;
    }else{
        self.loginButton.enabled = NO;
    }
}

//密码有更改时调用此方法
- (void)passwordChangedAction{
    if (self.passwordTextField.text.length >= 6 && self.phoneTextField.text.length == 11) {
        self.loginButton.enabled = YES;
    }else{
        self.loginButton.enabled = NO;
    }
}

#pragma mark - Event
- (IBAction)loginAction:(id)sender {
    [[NetworkManager shared] requestWithMethod:POST url:@"api/v1/users/login" parametes:@{@"phone":self.phoneTextField.text,@"password":self.passwordTextField.text} successBlock:^(NSDictionary *value) {
        [self saveLoginInfo:value];
        [self pushAction];
    } failBlock:^(NSError *error) {
        
    }];
}

//保存登录信息
- (void)saveLoginInfo:(NSDictionary *)value{
    [[NSUserDefaults standardUserDefaults] setObject:value[@"phone"] forKey:@"Phone"];
    [[NSUserDefaults standardUserDefaults] setObject:value[@"age"] forKey:@"Age"];
    [[NSUserDefaults standardUserDefaults] setObject:value[@"avatar"] forKey:@"Avatar"];
    [[NSUserDefaults standardUserDefaults] setObject:value[@"name"] forKey:@"Name"];
    [[NSUserDefaults standardUserDefaults] setObject:value[@"accessToken"] forKey:@"AccessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)pushAction{
    MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
