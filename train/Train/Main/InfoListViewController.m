//
//  InfoListViewController.m
//  Train
//
//  Created by 金烨 on 16/11/8.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "InfoListViewController.h"
#import "InfoListCell.h"
#import "NetworkManager.h"
#import "mylist.h"
#import "DetailListModel.h"
#import "infolist.h"

@interface InfoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) NSArray *titles;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property(nonatomic, strong) NSMutableArray *lists;
@property(nonatomic, strong) NSMutableArray *titles;
@property(nonatomic,strong)mylist *mylist;
@property(nonatomic,strong)infolist *imylist;
@end

@implementation InfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.titles=@[@"通讯业务",@"电信业务"];
//   [[NetworkManager shared] requestWithMethod:GET
//                                           url:@"api/v1/infoList"
//                                     parametes:@{
//                                                 @"access_token" : [[NSUserDefaults standardUserDefaults] objectForKey:@"AccessToken"]
//                                                 }
//                                  successBlock:^(NSDictionary *value) {
//                                      self.imylist =
//                                      [[infolist alloc] initWithDictionary:value error:nil];
//                                      self.lists =
//                                      [NSMutableArray arrayWithArray:self.imylist.list];
//                                      //[self.titles removeAllObjects];
//     
//                                      for (mylist *model in self.imylist.list) {
//                                          [self.titles addObject:model.title];
//                                      }
//                                      [self.tableView reloadData];
//                                  }
//                                     failBlock:^(NSError *error) {
//                                         
//                                     }];
  
    //隐藏多余的分割线

    
    
    
    
   
    self.tableView.tableFooterView = [[UIView alloc] init];
}


    



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoListCell"];
    cell.titleLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.row) {
        //跳转到通用详情页面
        UIViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CommonDetailViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }else if (0 == indexPath.row){
        UIViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportDetailViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//- (NSMutableArray *) titles {
//    if(!_titles) {_titles =[[NSMutableArray alloc] init];
//    }
//    return _titles;}
@end
