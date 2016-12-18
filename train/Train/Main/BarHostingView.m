//
//  BarHostingView.m
//  HelloTrain
//
//  Created by 金烨 on 16/11/1.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "BarHostingView.h"
#import "SportsPieChart.h"

@interface BarHostingView ()<CPTPlotDataSource>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic, strong) CPTXYGraph *graph;
@property (nonatomic, strong) CPTXYPlotSpace*plotSpace;
@property (nonatomic, strong) CPTMutableLineStyle *lineStyle;
@property (nonatomic, strong) CPTMutableTextStyle *whiteTextStyle;
@property (nonatomic, strong) CPTBarPlot *barPlot;                                  /** 柱状*/
@property (nonatomic, strong) CPTScatterPlot *scatterPlot;
@property (nonatomic,strong)SportsPieChart *pieChartView;/** 折线*/

@end

@implementation BarHostingView

- (void)configureUIWithDataSource:(NSArray *)dataSource titleArray:(NSArray *)titleArray isBar:(NSInteger) isBar{
    self.dataSource = dataSource;
    self.titles = titleArray;
    _graph = [[CPTXYGraph alloc] initWithFrame:self.bounds];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [_graph applyTheme:theme];
    
    self.hostedGraph = _graph;
    
    self.plotSpace = (CPTXYPlotSpace *)_graph.defaultPlotSpace;
    self.plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithFloat:-0.5] length:[NSNumber numberWithInteger:self.titles.count]];
    self.plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithFloat:0] length:[NSNumber numberWithFloat:10000]];
    _graph.paddingTop = 0.0f;
    _graph.paddingLeft = 0.0f;
    _graph.paddingBottom = 0.0f;
    _graph.paddingRight = 0.0f;
    
    _graph.plotAreaFrame.paddingTop = 40.0f;
    _graph.plotAreaFrame.paddingLeft = 60.0f;
    _graph.plotAreaFrame.paddingBottom = 40.0f;
    _graph.plotAreaFrame.paddingRight = 5.0f;
    
    CPTXYAxisSet * axisSet = (CPTXYAxisSet *)_graph.axisSet;
    
    CPTXYAxis * x = axisSet.xAxis;
    x.labelingPolicy = NO;
    
    _lineStyle.lineColor = [CPTColor blackColor];
    x.minorTickLineStyle = self.lineStyle;
    NSMutableArray * xlabels = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i ++) {
        CPTAxisLabel * label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%@",self.titles[i]] textStyle:self.whiteTextStyle];
        label.tickLocation = [NSNumber numberWithFloat:i];
        label.offset = x.labelOffset + x.majorTickLength;
        [xlabels addObject:label];
    }
    x.axisLabels = [NSSet setWithArray:xlabels];
    
    CPTXYAxis * y = axisSet.yAxis;
    y.minorTickLineStyle = nil;
    y.majorIntervalLength = [NSNumber numberWithInt:2000];
    y.minorTicksPerInterval = 0;
    y.orthogonalPosition = [NSNumber numberWithFloat:-0.5];
    y.titleLocation = [NSNumber numberWithInt:10000];
    if (1==isBar) {
        self.barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor whiteColor] horizontalBars:NO];
        self.barPlot.dataSource = self;
        [_graph addPlot:self.barPlot toPlotSpace:self.plotSpace];
    }else if (2==isBar) {
        self.scatterPlot = [[CPTScatterPlot alloc] initWithFrame:_graph.bounds];
        self.lineStyle.lineColor = [CPTColor whiteColor];
        self.scatterPlot.dataLineStyle = self.lineStyle;
        self.scatterPlot.dataSource = self;
        [_graph addPlot:self.scatterPlot];
    }else {
        self.graph = [[CPTXYGraph alloc] initWithFrame:self.bounds];
        
        //
        CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
        [self.graph applyTheme:theme];
        self.hostedGraph =self.graph;
        self.pieChartView = [[SportsPieChart alloc] initWithFrame:_graph.bounds];
        self.pieChartView.dataForChart = self.dataSource;
        self.pieChartView.titlesForChart = self.titleArray;
        self.pieChartView.dataSource =self;
        self.pieChartView.pieRadius = 100.0;
        
        self.pieChartView.identifier =@"Pie Chart 1";
        
        self.pieChartView.startAngle = M_PI_4;
        
        self.pieChartView.sliceDirection = CPTPieDirectionCounterClockwise;
        
        self.pieChartView.centerAnchor = CGPointMake(0.5, 0.5);
        
        self.pieChartView.borderLineStyle= [CPTLineStyle lineStyle];
        [_graph addPlot:self.pieChartView];
    }
}

#pragma mark - CPTPlotDataSource
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return self.dataSource.count;
}

- (id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx{
        if(fieldEnum == CPTScatterPlotFieldY){
            return[self.dataSource objectAtIndex:idx];
        }else{
            return [NSNumber numberWithInteger:idx];
        }
}


- (CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx{
    CPTTextLayer *textLayer= [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@", self.dataSource[idx]] style:self.whiteTextStyle];
    return textLayer;
}

#pragma mark - Getter&&Setter
- (CPTMutableTextStyle *)whiteTextStyle{
    if (!_whiteTextStyle) {
        _whiteTextStyle = [[CPTMutableTextStyle alloc] init];
        _whiteTextStyle.color = [CPTColor whiteColor];
        _whiteTextStyle.fontSize = 10;
    }
    return _whiteTextStyle;
}

- (CPTMutableLineStyle *)lineStyle{
    if (!_lineStyle) {
        _lineStyle = [CPTMutableLineStyle lineStyle];
        _lineStyle.miterLimit = 1.0;
        _lineStyle.lineWidth = 1.0f;
    }
    return _lineStyle;
}

@end
