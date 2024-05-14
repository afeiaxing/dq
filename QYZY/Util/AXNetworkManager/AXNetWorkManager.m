//
//  AXNetWorkManager.m
//  QYZY
//
//  Created by 22 on 2024/5/14.
//

#import "AXNetWorkManager.h"

@implementation AXNetWorkManager

+ (instancetype)shareInstace {
    static dispatch_once_t onceToken;
    static AXNetWorkManager *shared;
    dispatch_once(&onceToken, ^{
        shared = [[AXNetWorkManager alloc] init];
    });
    return shared;
}

- (void)startWithCompletionBlockWithApi:(YTKRequest *)api
                                Success:(YTKRequestCompletionBlock)success
                                failure:(YTKRequestCompletionBlock)failure {
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        // TODO: 统一处理返回数据
        success(request);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        // TODO: 统一处理返回数据
        failure(request);
    }];
}

@end
