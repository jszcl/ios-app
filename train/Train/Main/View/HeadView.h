//
//  HeadView.h
//  HelloTrain
//
//  Created by 金烨 on 16/10/27.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PercentageSortingTypeOfDefault,
    PercentageSortingTypeOfUp,
    PercentageSortingTypeOfDown,
} PercentageSortingType;

typedef enum : NSUInteger {
    TotalSortingTypeOfDefault,
    TotalSortingTypeOfUp,
    TotalSortingTypeOfDown,
} TotalSortingType;

typedef enum : NSUInteger {
    AddSortingTypeOfDefault,
    AddSortingTypeOfUp,
    AddSortingTypeOfDown,
} AddSortingType;


typedef void(^ClickPercentageBlock)(PercentageSortingType type);
typedef void(^ClickTotalUserBlock)(TotalSortingType type);
typedef void(^ClickNewUserBlock)(AddSortingType type);
@interface HeadView : UIView

@property (nonatomic, strong) ClickPercentageBlock clickPercentageBlock;
@property (nonatomic, strong) ClickTotalUserBlock clickTotalUserBlock;
@property (nonatomic, strong) ClickNewUserBlock clickNewUserBlock;

@end
