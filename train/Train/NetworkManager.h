//
//  NetworkManager.h
//  Train
//
//  Created by 金烨 on 16/11/8.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define API @"http://192.168.1.107:12306/"

typedef NS_ENUM(NSUInteger, Method) {
    POST,
    GET
};

typedef void(^SuccessBlock)(NSDictionary *value);
typedef void(^FailBlock)(NSError *error);

@interface NetworkManager : NSObject

+ (instancetype)shared;
//数据请求接口
- (void)requestWithMethod:(Method)method url:(NSString *)url parametes:(NSDictionary *)parametes successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

@end
