//
//  DetailLineChartCell.m
//  HelloTrain
//
//  Created by 金烨 on 16/10/24.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "DetailLineChartCell.h"
#import <CorePlot.h>

@interface DetailLineChartCell ()<CPTPlotDataSource>
@property (nonatomic, strong) NSArray *dataSoure;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) CPTXYGraph *graph;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTMutableTextStyle *whiteTextStyle;

@end

@implementation DetailLineChartCell

- (void)configureUIWithTitleArray:(NSArray *)titleArray dataArray:(NSArray *)dataArray{
    self.dataSoure = dataArray;
    self.titleArray = titleArray;
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit = 1.0;
    lineStyle.lineWidth = 1.0f;
    lineStyle.lineColor = [CPTColor blackColor];
    
    _graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [_graph applyTheme:theme];
    
    self.hostView.hostedGraph = _graph;
    
    CPTXYPlotSpace*plotSpace = (CPTXYPlotSpace *)_graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithFloat:0] length:[NSNumber numberWithFloat:self.dataSoure.count]];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInt:0] length:[NSNumber numberWithInt:100]];
    
    _graph.paddingTop = 0.0f;
    _graph.paddingLeft = 0.0f;
    _graph.paddingBottom = 0.0f;
    _graph.paddingRight = 0.0f;
    
    _graph.plotAreaFrame.paddingTop = 20.0f;
    _graph.plotAreaFrame.paddingLeft = 50.0f;
    _graph.plotAreaFrame.paddingBottom = 40.0f;
    _graph.plotAreaFrame.paddingRight = 5.0f;
    
    CPTXYAxisSet * axisSet = (CPTXYAxisSet *)_graph.axisSet;
    
    CPTXYAxis * x = axisSet.xAxis;
    x.labelingPolicy = NO;
    x.minorTickLineStyle = lineStyle;
    NSMutableArray * xlabels = [NSMutableArray array];
    static CPTMutableTextStyle * xlabelTextStyle = nil;
    xlabelTextStyle = [[CPTMutableTextStyle alloc] init];
    xlabelTextStyle.color = [CPTColor whiteColor];
    xlabelTextStyle.fontSize = 10;
    for (int i = 0; i < self.titleArray.count; i ++) {
        CPTAxisLabel * label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%@",self.titleArray[i]] textStyle:xlabelTextStyle];
        label.tickLocation = [NSNumber numberWithFloat:i];
        label.offset = x.labelOffset + x.majorTickLength;
        [xlabels addObject:label];
    }
    x.axisLabels = [NSSet setWithArray:xlabels];
    
    CPTXYAxis * y = axisSet.yAxis;
    y.minorTickLineStyle = nil;
    y.majorIntervalLength = [NSNumber numberWithInt:20];
    y.orthogonalPosition = [NSNumber numberWithInt:0];
    y.titleLocation = [NSNumber numberWithInt:100];
    
    lineStyle.lineColor = [CPTColor whiteColor];
    
    CPTScatterPlot * scatterPlot = [[CPTScatterPlot alloc] initWithFrame:_graph.bounds];
    scatterPlot.dataLineStyle = lineStyle;
    scatterPlot.dataSource = self;
    [_graph addPlot:scatterPlot];
}

#pragma mark - CPTPlotDataSource
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return self.dataSoure.count;
}

- (id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx{
    if(fieldEnum == CPTScatterPlotFieldY){
        return[self.dataSoure objectAtIndex:idx];
    }else{
        return [NSNumber numberWithInteger:idx];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
