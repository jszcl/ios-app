//
//  SportsPieChart.m
//  Train
//
//  Created by zhu changle on 16/11/11.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "SportsPieChart.h"

@implementation SportsPieChart


-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    //返回图表里面有几个点
    return self.dataForChart.count;
}
-(id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{
    //返回每个点所占的比例
    NSNumber *num = nil;
    if (idx >= [self.dataForChart count]) {
        return nil;
    }
    
    num = (self.dataForChart)[idx];
    return num;
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx
{
    //设置该点所对应的标注
    static CPTMutableTextStyle *whiteText = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        whiteText = [[CPTMutableTextStyle alloc] init];
        whiteText.color = [CPTColor whiteColor];
    });
    
    CPTTextLayer *newLayer = nil;
    newLayer = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@",self.titlesForChart[idx]] style:whiteText];
    return newLayer;
}
-(CGFloat)radialOffsetForPieChart:(CPTPieChart*)piePlot recordIndex:(NSUInteger)index{
    
    //设置某一个分饼远离其他分饼
    return (index==1?10:0);
    
}
@end
