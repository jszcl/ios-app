//
//  HeadView.m
//  HelloTrain
//
//  Created by 金烨 on 16/10/27.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "HeadView.h"

@interface HeadView ()
@property (weak, nonatomic) IBOutlet UIButton *percentageButton;
@property (weak, nonatomic) IBOutlet UIButton *totalButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, assign) PercentageSortingType percentageType;
@property (nonatomic, assign) TotalSortingType totalType;
@property (nonatomic, assign) AddSortingType addType;
@end

@implementation HeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.percentageType = PercentageSortingTypeOfDefault;
    self.totalType = TotalSortingTypeOfDefault;
    self.addType = AddSortingTypeOfDefault;
}

- (IBAction)percentageAction:(id)sender {
    switch (self.percentageType) {
        case PercentageSortingTypeOfDefault:
            self.percentageType = PercentageSortingTypeOfUp;
            break;
        case PercentageSortingTypeOfUp:
            self.percentageType = PercentageSortingTypeOfDown;
            break;
        case PercentageSortingTypeOfDown:
            self.percentageType = PercentageSortingTypeOfUp;
            break;
        default:
            break;
    }
    if (self.clickPercentageBlock) {
        self.clickPercentageBlock(self.percentageType);
    }
    self.totalType = TotalSortingTypeOfDefault;
    self.addType = AddSortingTypeOfDefault;
    [self updateUI];
}

- (IBAction)clickTotalAction:(id)sender {
    switch (self.totalType) {
        case TotalSortingTypeOfDefault:
            self.totalType = TotalSortingTypeOfUp;
            break;
        case TotalSortingTypeOfUp:
            self.totalType = TotalSortingTypeOfDown;
            break;
        case TotalSortingTypeOfDown:
            self.totalType = TotalSortingTypeOfUp;
            break;
        default:
            break;
    }
    if (self.clickTotalUserBlock) {
        self.clickTotalUserBlock(self.totalType);
    }
    self.percentageType = PercentageSortingTypeOfDefault;
    self.addType = AddSortingTypeOfDefault;
    [self updateUI];
}

- (IBAction)clickNewAction:(id)sender {
    switch (self.addType) {
        case AddSortingTypeOfDefault:
            self.addType = AddSortingTypeOfUp;
            break;
        case PercentageSortingTypeOfUp:
            self.addType = AddSortingTypeOfDown;
            break;
        case PercentageSortingTypeOfDown:
            self.addType = AddSortingTypeOfUp;
            break;
        default:
            break;
    }
    if (self.clickNewUserBlock) {
        self.clickNewUserBlock(self.addType);
    }
    self.percentageType = PercentageSortingTypeOfDefault;
    self.totalType = TotalSortingTypeOfDefault;
    [self updateUI];
}

- (void)updateUI{
    switch (_percentageType) {
        case PercentageSortingTypeOfDefault:
            [self.percentageButton setImage:[UIImage imageNamed:@"common_point"] forState:UIControlStateNormal];
            break;
        case PercentageSortingTypeOfUp:
            [self.percentageButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            break;
        case PercentageSortingTypeOfDown:
            [self.percentageButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    switch (_totalType) {
        case TotalSortingTypeOfDefault:
            [self.totalButton setImage:[UIImage imageNamed:@"common_point"] forState:UIControlStateNormal];
            break;
        case TotalSortingTypeOfUp:
            [self.totalButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            break;
        case TotalSortingTypeOfDown:
            [self.totalButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    switch (_addType) {
        case AddSortingTypeOfDefault:
            [self.addButton setImage:[UIImage imageNamed:@"common_point"] forState:UIControlStateNormal];
            break;
        case AddSortingTypeOfUp:
            [self.addButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            break;
        case AddSortingTypeOfDown:
            [self.addButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
}

@end
