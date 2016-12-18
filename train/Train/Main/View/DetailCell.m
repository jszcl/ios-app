//
//  DetailCell.m
//  HelloTrain
//
//  Created by 金烨 on 16/10/24.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfNewUserLabel;

@end

@implementation DetailCell

- (void)configureUIWithModel:(DetailModel *)model{
    self.cityLabel.text = model.city;
    self.percentageLabel.text = [@(model.percentage*100) stringValue];
    self.totalLabel.text = [@(model.totalNumberOfUser) stringValue];
    self.numberOfNewUserLabel.text = [@(model.numberOfNewUser) stringValue];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
