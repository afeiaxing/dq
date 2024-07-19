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
                             completion:(void(^)(NSDictionary *textLives))completion{
    AXMatchStandingTextLiveApi *api1 = [AXMatchStandingTextLiveApi new];
    api1.matchId = matchId;
    api1.statusId = @"1";
    
    AXMatchStandingTextLiveApi *api2 = [AXMatchStandingTextLiveApi new];
    api2.matchId = matchId;
    api2.statusId = @"2";
    
    AXMatchStandingTextLiveApi *api3 = [AXMatchStandingTextLiveApi new];
    api3.matchId = matchId;
    api3.statusId = @"3";
    
    AXMatchStandingTextLiveApi *api4 = [AXMatchStandingTextLiveApi new];
    api4.matchId = matchId;
    api4.statusId = @"4";
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[api1, api2, api3, api4]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        AXMatchStandingTextLiveApi *api1 = (AXMatchStandingTextLiveApi *)requests[0];
        AXMatchStandingTextLiveApi *api2 = (AXMatchStandingTextLiveApi *)requests[1];
        AXMatchStandingTextLiveApi *api3 = (AXMatchStandingTextLiveApi *)requests[2];
        AXMatchStandingTextLiveApi *api4 = (AXMatchStandingTextLiveApi *)requests[3];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *array1 = [NSArray yy_modelArrayWithClass:AXMatchStandingTextLiveModel.class json:api1.responseJSONObject[@"data"]];
        NSArray *array2 = [NSArray yy_modelArrayWithClass:AXMatchStandingTextLiveModel.class json:api2.responseJSONObject[@"data"]];
        NSArray *array3 = [NSArray yy_modelArrayWithClass:AXMatchStandingTextLiveModel.class json:api3.responseJSONObject[@"data"]];
        NSArray *array4 = [NSArray yy_modelArrayWithClass:AXMatchStandingTextLiveModel.class json:api4.responseJSONObject[@"data"]];
        
        if (array1.count) {
            [dict setValue:array1 forKey:@"Q1"];
        }
        if (array2.count) {
            [dict setValue:array2 forKey:@"Q2"];
        }
        if (array3.count) {
            [dict setValue:array3 forKey:@"Q3"];
        }
        if (array4.count) {
            [dict setValue:array4 forKey:@"Q4"];
        }
        !completion ? : completion(dict.copy);
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        !completion ? : completion(nil);
    }];
}

@end
