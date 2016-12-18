//
//  MyMessageViewController.m
//  HelloTrain
//
//  Created by 金烨 on 16/10/25.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "MessageCell.h"
#import "MyMessageViewController.h"

@interface MyMessageViewController () <UITableViewDelegate,
                                       UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *comments;
@property(weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.comments = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"CommentList"]];
    [self.comments sortUsingComparator:^NSComparisonResult(NSDictionary * _Nonnull obj1, NSDictionary *  _Nonnull obj2) {
        if ([obj1[@"createdDate"] integerValue] > [obj2[@"createdDate"] integerValue]) {
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
  self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.estimatedRowHeight = 67.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - UITableViewDelegate && DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MessageCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
  [cell configureUIWithDic:self.comments[indexPath.row]];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.comments.count;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
