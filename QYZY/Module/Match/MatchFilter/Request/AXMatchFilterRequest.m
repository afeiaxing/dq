//
//  AXMatchFilterRequest.m
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import "AXMatchFilterRequest.h"
#import "AXMatchFilterApi.h"

@implementation AXMatchFilterRequest

- (void)requestMatchListWithTitle: (NSString *)title
                             sign: (NSString *)sign
                       completion: (void(^)(AXMatchFilterModel *filterModel))completion{
    AXMatchFilterApi *api = [AXMatchFilterApi new];
    api.title = title;
    api.sign = sign;
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchFilterModel *model;
        if (api.isRequestSuccess) {
            model = [AXMatchFilterModel yy_modelWithJSON:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
