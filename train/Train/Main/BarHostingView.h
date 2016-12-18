//
//  BarHostingView.h
//  HelloTrain
//
//  Created by 金烨 on 16/11/1.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <CorePlot.h>

@interface BarHostingView : CPTGraphHostingView

- (void)configureUIWithDataSource:(NSArray *)dataSource titleArray:(NSArray *)titleArray isBar:(NSInteger)isBar;

@end
