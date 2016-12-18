//
//  SportsPieChart.h
//  Train
//
//  Created by zhu changle on 16/11/11.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <CorePlot.h>

@interface SportsPieChart : CPTPieChart<CPTPieChartDataSource>
@property (nonnull,strong) NSArray *dataForChart;
@property (nonnull,strong) NSArray *titlesForChart;
@end

