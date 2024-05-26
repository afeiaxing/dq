//
//  AXMatchStandingRequest.m
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import "AXMatchStandingRequest.h"
#import "AXMatchStandingApi.h"

@implementation AXMatchStandingRequest

- (void)requestMatchStandingWithMatchId: (NSString *)matchId
                             completion:(void(^)(AXMatchStandingModel *matchModel))completion{
    matchId = @"3788364";
    AXMatchStandingApi *api = [AXMatchStandingApi new];
    api.matchId = matchId;
    AXNetWorkManager *manager = [AXNetWorkManager new];
    [manager startWithCompletionBlockWithApi:api Success:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchStandingModel *model = [AXMatchStandingModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
