//
//  SportsViewController.m
//  Train
//
//  Created by 金烨 on 16/11/9.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "SportsViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "BarHostingView.h"

@interface SportsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) CMPedometer *pedometer;//徒步计数器

@property (nonatomic, strong) BarHostingView *barView;          //柱状图
@property (nonatomic, strong) BarHostingView *scatterView;
@property (nonatomic,strong) BarHostingView *pieView;


@end

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"2398",@"5422",@"3234",@"2215",@"8876",@"6728",@"4213"];
    self.titles = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    self.pieView = [[BarHostingView alloc ] initWithFrame:CGRectMake(0,200, self.view.bounds.size.width, 300)];
    [self.view addSubview:self.pieView];
    self.pieView.hidden = YES;
    //此功能只在真机运行
    self.pedometer = [[CMPedometer alloc] init];
    //[self receiveSteps];
    
    //CorePlot
    [self.barView configureUIWithDataSource:self.dataSource titleArray:self.titles isBar:1];
    [self.scatterView configureUIWithDataSource:self.dataSource titleArray:self.titles isBar:2];
    [self.pieView configureUIWithDataSource:self.dataSource titleArray:self.titles isBar:3];
  
    self.scatterView.hidden = YES;
}

- (void)receiveSteps{
    if ([CMPedometer isStepCountingAvailable]) {
        //查找指定时间段内的行走步数
        [self.pedometer queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSince1970:1477280698] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            NSLog(@"%@",pedometerData.numberOfSteps);
        }];
    }
}

- (IBAction)segmentedChangedAction:(id)sender {
    if (0 == self.segmentedControl.selectedSegmentIndex) {
        self.barView.hidden =NO;
        self.scatterView.hidden = YES;
        self.pieView.hidden = YES;
    }else if(1== self.segmentedControl.selectedSegmentIndex){
        self.scatterView.hidden = NO;
        self.barView.hidden = YES;
        self.pieView.hidden = YES;
    }else if (2==self.segmentedControl.selectedSegmentIndex) {
        self.scatterView.hidden = YES;
        self.barView.hidden = YES;
        self.pieView.hidden = NO;
    }
}

#pragma mark - Getter&&Setter
- (BarHostingView *)barView{
    if (!_barView) {
        _barView = [[BarHostingView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 300)];
        _barView.hidden = YES;
        [self.view addSubview:_barView];
    }
    return _barView;
}

- (BarHostingView *)scatterView{
    if (!_scatterView) {
        _scatterView = [[BarHostingView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 300)];
        _scatterView.hidden = YES;
        [self.view addSubview:_scatterView];
    }
    return _scatterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
