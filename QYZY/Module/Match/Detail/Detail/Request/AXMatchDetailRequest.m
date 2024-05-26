//
//  AXMatchDetailRequest.m
//  QYZY
//
//  Created by 22 on 2024/5/25.
//

#import "AXMatchDetailRequest.h"
#import "AXMatchDetailApi.h"

@implementation AXMatchDetailRequest

- (void)requestMatchDetailWithMatchId: (NSString *)matchId
                           completion:(void(^)(AXMatchDetailModel *matchModel))completion{
    AXMatchDetailApi *api = [AXMatchDetailApi new];
    api.matchId = matchId;
    AXNetWorkManager *manager = [AXNetWorkManager new];
    [manager startWithCompletionBlockWithApi:api Success:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchDetailModel *model = [AXMatchDetailModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
