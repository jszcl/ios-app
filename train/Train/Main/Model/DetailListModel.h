//
//  DetailListModel.h
//  HelloTrain
//
//  Created by 金烨 on 16/10/24.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DetailModel <NSObject>

@end

@interface DetailListModel : JSONModel

@property(nonatomic, strong) NSArray<DetailModel> *list;

@end
