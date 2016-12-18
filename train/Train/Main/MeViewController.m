//
//  MeViewController.m
//  Train
//
//  Created by 金烨 on 16/11/8.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "MeViewController.h"
#import "UserInfoCell.h"
#import "UserCommonCell.h"
#import "UserSwitchCell.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏多余分割线
    self.titles = @[@"运动统计",@"意见反馈",@"关于我们"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        UserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
        cell.avatarImageView.image = [UIImage imageNamed:@"首页-首页"];
        cell.nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
        cell.ageLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Age"];
        return cell;
    }else if (4 == indexPath.row){
        UserSwitchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserSwitchCell"];
        return cell;
    }else{
        UserCommonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserCommonCell"];
        cell.titleLabel.text = self.titles[indexPath.row - 1];
        return cell;
    }
}

//点击cell的方法回调
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.row) {
        [self pushDetailWithIdentifier:@"SportsViewController"];
    }else if(2 == indexPath.row){
        [self pushDetailWithIdentifier:@"SuggestionViewController"];
    }else if (3 == indexPath.row){
        [self pushDetailWithIdentifier:@"AboutViewController"];
    }else if (0 == indexPath.row){
        [self pushDetailWithIdentifier:@"myinfoViewController"];
    }
}

//每一行的高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        return 90;
    }
    return 50;
}

#pragma mark - Private
- (void)pushDetailWithIdentifier:(NSString *)identifier{
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
