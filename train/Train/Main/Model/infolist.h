//
//  infolist.h
//  Train
//
//  Created by zhu changle on 16/11/11.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol mylist <NSObject>
@end
@interface infolist : JSONModel
@property (nonatomic, strong) NSArray *list;
@end
