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
//    matchId = @"3788364";
    AXMatchStandingApi *api = [AXMatchStandingApi new];
    api.matchId = matchId;

    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchStandingModel *model;
        if (api.isRequestSuccess) {
            model = [AXMatchStandingModel yy_modelWithJSON:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}


- (void)requestMatchTextLiveWithMatchId:(NSString *)matchId
                             completion:(void(^)(NSArray <AXMatchStandingTextLiveModel *>*textLives))completion{
    AXMatchStandingTextLiveApi *api = [AXMatchStandingTextLiveApi new];
    api.matchId = matchId;

    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray *model;
        if (api.isRequestSuccess) {
            model = [NSArray yy_modelArrayWithClass:AXMatchStandingTextLiveModel.class json:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
