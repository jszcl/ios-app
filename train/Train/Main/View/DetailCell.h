//
//  DetailCell.h
//  HelloTrain
//
//  Created by 金烨 on 16/10/24.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface DetailCell : UITableViewCell

- (void)configureUIWithModel:(DetailModel *)model;

@end
