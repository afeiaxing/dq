//
//  AXMatchListRequest.m
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "AXMatchListRequest.h"
#import "AXMatchListApi.h"

@implementation AXMatchListRequest

- (void)requestMatchListWithcompletion:(void(^)(AXMatchListModel *matchModel))completion{
    AXMatchListApi *api = [AXMatchListApi new];
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchListModel *model = [AXMatchListModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
