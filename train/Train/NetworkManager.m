//
//  NetworkManager.m
//  Train
//
//  Created by 金烨 on 16/11/8.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "NetworkManager.h"
#import "HUDView.h"

@interface NetworkManager ()

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation NetworkManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static NetworkManager *_networkManager;
    dispatch_once(&onceToken, ^{
        _networkManager = [[NetworkManager alloc] init];
    });
    return _networkManager;
}

- (void)requestWithMethod:(Method)method url:(NSString *)url parametes:(NSDictionary *)parametes successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock{
    self.manager = [[AFHTTPSessionManager alloc] init];
    HUDView * hudView = [[HUDView alloc] init];
    [hudView showHUD];
    //设置请求超时为10秒
    self.manager.requestSerializer.timeoutInterval = 10;
    
    if (method == POST) {
        [self.manager POST:[NSString stringWithFormat:@"%@%@",API,url] parameters:parametes progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status_code"] integerValue] == 200) {
                successBlock(responseObject[@"data"]);
            }
            [hudView hiddenHUD];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock(error);
            [hudView hiddenHUD];
        }];
    }else if (method == GET){
        [self.manager GET:[NSString stringWithFormat:@"%@%@",API,url] parameters:parametes progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status_code"] integerValue] == 200) {
                successBlock(responseObject[@"data"]);
            }
            [hudView hiddenHUD];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock(error);
            [hudView hiddenHUD];
        }];
    }
}

@end
