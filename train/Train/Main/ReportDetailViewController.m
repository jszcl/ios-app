//
//  ReportDetailViewController.m
//  Train
//
//  Created by 金烨 on 16/11/9.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "ReportDetailViewController.h"
#import "NetworkManager.h"
#import "RightTableViewCell.h"
#import "HeadView.h"
#import "DetailCell.h"
#import "DetailLineChartCell.h"
#import "DetailListModel.h"
#import "DetailModel.h"

@interface ReportDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) DetailListModel *listModel;
@property(nonatomic, strong) NSMutableArray *lists;
@property(nonatomic, strong) NSMutableArray *titles;
@property(nonatomic, strong) NSMutableArray *percentageArray;
@property(nonatomic, strong) UIView *rightView;
@property(nonatomic, strong) UITableView *rightTableView;
@property(nonatomic, strong) NSArray *types;
@property(weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(weak, nonatomic) IBOutlet UIView *dateView;
@property(nonatomic, strong) UIButton *dateButton;
@property(nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) HeadView *headView;
@end

@implementation ReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray array];
    self.percentageArray = [NSMutableArray array];
    if (self.isNextLevel) {
        [self clickNextRequest];
    }else{
        [self requestList];
    }
    self.dateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [self.dateButton setTitle:[self trunTimeStampWithDate:[NSDate date]]
                     forState:UIControlStateNormal];
    self.dateButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.dateButton setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
    self.navigationItem.titleView = self.dateButton;
    [self.dateButton addTarget:self
                        action:@selector(datePickAction)
              forControlEvents:UIControlEventTouchUpInside];
    self.datePicker.maximumDate = [NSDate date];
}

- (void)requestList {
    [[NetworkManager shared] requestWithMethod:GET
                                           url:@"api/v1/detail"
                                    parametes:@{
                                                 @"access_token" : [[NSUserDefaults standardUserDefaults] objectForKey:@"AccessToken"],
                                                 @"type" : @"1",
                                                 @"date" : @"1477299625",
                                                 @"city" : @"江苏"
                                                 }
                                  successBlock:^(NSDictionary *value) {
                                      self.listModel =
                                      [[DetailListModel alloc] initWithDictionary:value error:nil];
                                      self.lists =
                                      [NSMutableArray arrayWithArray:self.listModel.list];
                                      [self.titles removeAllObjects];
                                      [self.percentageArray removeAllObjects];
                                      for (DetailModel *model in self.listModel.list) {
                                          [self.titles addObject:model.city];
                                          [self.percentageArray
                                           addObject:[NSString
                                                      stringWithFormat:@"%.0lf", model.percentage * 100]];
                                      }
                                      [self.tableView reloadData];
                                  }
                                     failBlock:^(NSError *error) {
                                         NSLog(@"%@", error.description);
                                     }];
}

- (void)clickDateRequest{
    __weak typeof(self) weakself = self;
    [[NetworkManager shared] requestWithMethod:GET
                                           url:@"api/v1/detail_date"
                                    parametes:@{
                                                 @"access_token" : [[NSUserDefaults standardUserDefaults] objectForKey:@"AccessToken"],
                                                 @"type" : @"1",
                                                 @"date" : @"1477299625",
                                                 @"city" : @"江苏"
                                                 }
                                  successBlock:^(NSDictionary *value) {
                                      self.listModel =
                                      [[DetailListModel alloc] initWithDictionary:value error:nil];
                                      self.lists =
                                      [NSMutableArray arrayWithArray:weakself.listModel.list];
                                      [self.titles removeAllObjects];
                                      [self.percentageArray removeAllObjects];
                                      for (DetailModel *model in self.listModel.list) {
                                          [self.titles addObject:model.city];
                                          [self.percentageArray
                                           addObject:[NSString
                                                      stringWithFormat:@"%.0lf", model.percentage * 100]];
                                      }
                                      [self.tableView reloadData];
                                  }
                                     failBlock:^(NSError *error) {
                                         NSLog(@"%@", error.description);
                                     }];
}

- (void)clickMoreRequest{
    [[NetworkManager shared] requestWithMethod:GET
                                           url:@"api/v1/detail_more"
                                    parametes:@{
                                                 @"access_token" : [[NSUserDefaults standardUserDefaults] objectForKey:@"AccessToken"],
                                                 @"type" : @"1",
                                                 @"date" : @"1477299625",
                                                 @"city" : @"江苏"
                                                 }
                                  successBlock:^(NSDictionary *value) {
                                      self.listModel =
                                      [[DetailListModel alloc] initWithDictionary:value error:nil];
                                      self.lists =
                                      [NSMutableArray arrayWithArray:self.listModel.list];
                                      [self.titles removeAllObjects];
                                      [self.percentageArray removeAllObjects];
                                      for (DetailModel *model in self.listModel.list) {
                                          [self.titles addObject:model.city];
                                          [self.percentageArray
                                           addObject:[NSString
                                                      stringWithFormat:@"%.0lf", model.percentage * 100]];
                                      }
                                      [self.tableView reloadData];
                                  }
                                     failBlock:^(NSError *error) {
                                         NSLog(@"%@", error.description);
                                     }];
}

- (void)clickNextRequest{
    [[NetworkManager shared] requestWithMethod:GET
                                           url:@"api/v1/detail_level"
                                    parametes:@{
                                                 @"access_token" : [[NSUserDefaults standardUserDefaults] objectForKey:@"AccessToken"],
                                                 @"type" : @"1",
                                                 @"date" : @"1477299625",
                                                 @"city" : @"江苏"
                                                 }
                                  successBlock:^(NSDictionary *value) {
                                      self.listModel =
                                      [[DetailListModel alloc] initWithDictionary:value error:nil];
                                      self.lists =
                                      [NSMutableArray arrayWithArray:self.listModel.list];
                                      [self.titles removeAllObjects];
                                      [self.percentageArray removeAllObjects];
                                      for (DetailModel *model in self.listModel.list) {
                                          [self.titles addObject:model.city];
                                          [self.percentageArray
                                           addObject:[NSString
                                                      stringWithFormat:@"%.0lf", model.percentage * 100]];
                                      }
                                      [self.tableView reloadData];
                                  }
                                     failBlock:^(NSError *error) {
                                         NSLog(@"%@", error.description);
                                     }];
}

#pragma mark - UITableViewDelegate&DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.row < self.lists.count) {
            DetailCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
            [cell configureUIWithModel:self.lists[indexPath.row]];
            return cell;
        } else {
            DetailLineChartCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"DetailLineChartCell"];
            [cell configureUIWithTitleArray:self.titles
                                  dataArray:self.percentageArray];
            return cell;
        }
    } else {
        RightTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"RightTableViewCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"RightTableViewCell"
                                                 owner:nil
                                               options:nil]
            .lastObject;
        }
        cell.titleLabel.text = self.types[indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (self.lists.count == 0) {
            return 0;
        }
        return self.lists.count + 1;
    }
    return self.types.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.headView;
    }else{
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
        imageView.image = [UIImage imageNamed:@"logo"];
        [view addSubview:imageView];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return 40;
    }
    return 64.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.row == self.lists.count) {
            return 200;
        }
        return 40;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dateView.hidden = YES;
    if (tableView == self.rightTableView) {
        [self leaveAction];
        if (0 == indexPath.row) {
        
            [self requestList];
        }else{
            [self clickMoreRequest];
        }
    } else {
        if (indexPath.row == self.lists.count) {
            return;
        }
        DetailModel *model = self.lists[indexPath.row];
        if (model.isHaveNext == 1) {
            UIAlertController *controller = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"提示"
                                             preferredStyle:UIAlertControllerStyleAlert];
            [controller addTextFieldWithConfigurationHandler:^(
                                                               UITextField *_Nonnull textField) {
                textField.placeholder = @"请输入您想说的话";
            }];
            UIAlertAction *commentAction = [UIAlertAction
                                            actionWithTitle:@"评论"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                NSString *comment = controller.textFields.firstObject.text;
                                                if (comment.length > 0) {
                                                    NSDictionary *dic = @{
                                                                          @"comment" : comment,
                                                                          @"createdDate" : [NSString
                                                                                            stringWithFormat:@"%0f",
                                                                                            [[NSDate date]
                                                                                             timeIntervalSince1970]],
                                                                          @"source" : [NSString
                                                                                       stringWithFormat:@"%@的市场占比为%.0lf%%",
                                                                                       model.city, model.percentage * 100]
                                                                          };
                                                    [self saveDataWithDictionary:dic];
                                                }
                                            }];
            UIAlertAction *nextAction = [UIAlertAction
                                         actionWithTitle:@"下一级"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *_Nonnull action) {
                                             [self.view endEditing:YES];
                                             ReportDetailViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportDetailViewController"];
                                             viewController.isNextLevel = YES;
                                             [self.navigationController pushViewController:viewController
                                                                                  animated:YES];
                                         }];
            UIAlertAction *cancelAction =
            [UIAlertAction actionWithTitle:@"取消"
                                     style:UIAlertActionStyleCancel
                                   handler:nil];
            [controller addAction:commentAction];
            [controller addAction:nextAction];
            [controller addAction:cancelAction];
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            UIAlertController *controller = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"提示"
                                             preferredStyle:UIAlertControllerStyleAlert];
            [controller addTextFieldWithConfigurationHandler:^(
                                                               UITextField *_Nonnull textField) {
                textField.placeholder = @"请输入您想说的话";
            }];
            UIAlertAction *commentAction = [UIAlertAction
                                            actionWithTitle:@"评论"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                NSString *comment = controller.textFields.firstObject.text;
                                                if (comment.length > 0) {
                                                    NSDictionary *dic = @{
                                                                          @"comment" : comment,
                                                                          @"createdDate" : [NSString
                                                                                            stringWithFormat:@"%0f",
                                                                                            [[NSDate date]
                                                                                             timeIntervalSince1970]],
                                                                          @"source" : [NSString
                                                                                       stringWithFormat:@"%@的市场占比为%.0lf%%",
                                                                                       model.city, model.percentage * 100]
                                                                          };
                                                    [self saveDataWithDictionary:dic];
                                                }
                                            }];
            UIAlertAction *cancelAction =
            [UIAlertAction actionWithTitle:@"取消"
                                     style:UIAlertActionStyleCancel
                                   handler:nil];
            [controller addAction:commentAction];
            [controller addAction:cancelAction];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

#pragma mark - Event
- (void)percentageOrderWithOrderType:(PercentageSortingType)type {
    if (type == PercentageSortingTypeOfUp) {
        [self.lists sortUsingComparator:^NSComparisonResult(DetailModel *model1,
                                                            DetailModel *model2) {
            if (model1.percentage > model2.percentage) {
                return NSOrderedAscending;
            } else if (model1.percentage < model2.percentage) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }];
    }else if (type == PercentageSortingTypeOfDown){
        [self.lists sortUsingComparator:^NSComparisonResult(DetailModel *model1,
                                                            DetailModel *model2) {
            if (model1.percentage > model2.percentage) {
                return NSOrderedDescending;
            } else if (model1.percentage < model2.percentage) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }];
    }
    [self.tableView reloadData];
}

- (void)totalUserOrderWithOrderType:(TotalSortingType)type{
    if (type == TotalSortingTypeOfUp) {
        [self.lists sortUsingComparator:^NSComparisonResult(DetailModel *model1,
                                                            DetailModel *model2) {
            if (model1.totalNumberOfUser > model2.totalNumberOfUser) {
                return NSOrderedAscending;
            } else if (model1.totalNumberOfUser < model2.totalNumberOfUser) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }];
    }else if (type == TotalSortingTypeOfDown){
        [self.lists sortUsingComparator:^NSComparisonResult(DetailModel *model1,
                                                            DetailModel *model2) {
            if (model1.totalNumberOfUser > model2.totalNumberOfUser) {
                return NSOrderedDescending;
            } else if (model1.totalNumberOfUser < model2.totalNumberOfUser) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }];
    }
    [self.tableView reloadData];
}

- (void)newUserOrderWithOrderType:(AddSortingType)type{
    if (type == AddSortingTypeOfUp) {
        [self.lists sortUsingComparator:^NSComparisonResult(DetailModel *model1,
                                                            DetailModel *model2) {
            if (model1.numberOfNewUser > model2.numberOfNewUser) {
                return NSOrderedAscending;
            } else if (model1.numberOfNewUser < model2.numberOfNewUser) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }];
    }else if (type == AddSortingTypeOfDown){
        [self.lists sortUsingComparator:^NSComparisonResult(DetailModel *model1,
                                                            DetailModel *model2) {
            if (model1.numberOfNewUser > model2.numberOfNewUser) {
                return NSOrderedDescending;
            } else if (model1.numberOfNewUser < model2.numberOfNewUser) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }];
    }
    [self.tableView reloadData];
}

- (IBAction)moreAction:(id)sender {
    self.dateView.hidden = YES;
    [UIView animateWithDuration:0
                     animations:^{
                         self.rightView.frame = self.view.bounds;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.rightTableView.frame =
                                              CGRectMake(self.view.bounds.size.width - 160, 0,
                                                         160, self.view.bounds.size.height);
                                          }];
                     }];
}

- (void)leaveAction {
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.rightTableView.frame = CGRectMake(
                                                                self.view.bounds.size.width, 0, 160, self.view.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0
                                          animations:^{
                                              self.rightView.frame =
                                              CGRectMake(self.view.bounds.size.width, 0,
                                                         self.view.bounds.size.width,
                                                         self.view.bounds.size.height);
                                          }];
                     }];
}

- (void)datePickAction {
    self.dateView.hidden = NO;
}

- (IBAction)clickCancelAction:(id)sender {
    self.dateView.hidden = YES;
}

- (IBAction)clickConfirmAction:(id)sender {
    [self clickDateRequest];
    [self.dateButton setTitle:[self trunTimeStampWithDate:self.datePicker.date]
                     forState:UIControlStateNormal];
    self.dateView.hidden = YES;
}

#pragma mark - Private
- (NSString *)trunTimeStampWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    return [formatter stringFromDate:date];
}

- (void)saveDataWithDictionary:(NSDictionary *)dictionary{
    NSArray * tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"CommentList"];
    self.comments = [NSMutableArray arrayWithArray:tempArray];
    [self.comments addObject:dictionary];
    NSArray *array = [NSArray arrayWithArray:self.comments];
    [[NSUserDefaults standardUserDefaults]
     setObject:array
     forKey:@"CommentList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Getter&&Setter
- (UIView *)rightView {
    if (!_rightView) {
        _rightView =
        [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0,
                                                 self.view.bounds.size.width,
                                                 self.view.bounds.size.height)];
        _rightView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        UIButton * clickButton = [[UIButton alloc] initWithFrame:_rightView.bounds];
        clickButton.backgroundColor = [UIColor clearColor];
        [clickButton addTarget:self action:@selector(leaveAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:clickButton];
        [[UIApplication sharedApplication].keyWindow addSubview:_rightView];
        _rightTableView = [[UITableView alloc]
                           initWithFrame:CGRectMake(self.view.bounds.size.width, 0, 160,
                                                    self.view.bounds.size.height)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tableFooterView = [[UIView alloc] init];
        _rightView.userInteractionEnabled = YES;
        [_rightView addSubview:_rightTableView];
    }
    return _rightView;
}

- (NSArray *)types {
    if (!_types) {
        _types = @[ @"移动方面", @"联通方面", @"电信方面" ];
    }
    return _types;
}

- (NSMutableArray *)comments {
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}

- (HeadView *)headView{
    if (!_headView) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil].lastObject;
        __weak typeof(self) weakself = self;
        _headView.clickPercentageBlock = ^(PercentageSortingType type){
            [weakself percentageOrderWithOrderType:type];
        };
        _headView.clickTotalUserBlock = ^(TotalSortingType type){
            [weakself totalUserOrderWithOrderType:type];
        };
        _headView.clickNewUserBlock = ^(AddSortingType type){
            [weakself newUserOrderWithOrderType:type];
        };
    }
    return _headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
