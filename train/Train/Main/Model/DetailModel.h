//
//  DetailModel.h
//  HelloTrain
//
//  Created by 金烨 on 16/10/24.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DetailModel : JSONModel
//@property (nonatomic, strong) NSString *list;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) NSInteger totalNumberOfUser;
@property (nonatomic, assign) NSInteger numberOfNewUser;
@property (nonatomic, assign) NSInteger isHaveNext;
@property (nonatomic, assign) float percentage;
@property(nonatomic, strong) NSArray *list;

@end
