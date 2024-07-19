//
//  AXMatchAnalysisRequest.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchAnalysisRequest.h"
#import "AXMatchAnalysisTeamRankApi.h"
#import "AXMatchAnalysisRivalryRecordApi.h"
#import "AXMatchAnalysisTeamRecordApi.h"
#import "AXMatchAnalysisAdvancedApi.h"

@implementation AXMatchAnalysisRequest

- (void)requestTeamRankWithMatchId:(NSString *)matchId
                             limit:(int)limit
                        completion:(void(^)(NSDictionary *teamRankModel))completion{
    AXMatchAnalysisTeamRankApi *hostApi = [AXMatchAnalysisTeamRankApi new];
    hostApi.matchId = matchId;
    hostApi.limit = limit;
    hostApi.type = @"home";
    
    AXMatchAnalysisTeamRankApi *awayApi = [AXMatchAnalysisTeamRankApi new];
    awayApi.matchId = matchId;
    awayApi.limit = limit;
    awayApi.type = @"away";
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[hostApi, awayApi]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        AXMatchAnalysisTeamRankApi *hostRequest = (AXMatchAnalysisTeamRankApi *)requests[0];
        AXMatchAnalysisTeamRankApi *awayRequest = (AXMatchAnalysisTeamRankApi *)requests[1];
        
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        
        NSDictionary *hostData = hostRequest.responseJSONObject[@"data"];
        NSArray *hostArray;
        if ([hostData isKindOfClass:[NSDictionary class]] && [hostData count]) {
            hostArray = hostData[@"teamRankings"];
        }
        
        NSDictionary *awayData = awayRequest.responseJSONObject[@"data"];
        NSArray *awayArray;
        if ([awayData isKindOfClass:[NSDictionary class]] && [awayData count]) {
            awayArray = awayData[@"teamRankings"];
        }
        
        if (hostArray.count) {
            AXMatchAnalysisTeamRankModel *model = [AXMatchAnalysisTeamRankModel yy_modelWithJSON:hostArray.firstObject];
            if (model) {[temp setValue:model forKey:@"hostModel"];}
        }
        if (awayArray.count) {
            AXMatchAnalysisTeamRankModel *model = [AXMatchAnalysisTeamRankModel yy_modelWithJSON:awayArray.firstObject];
            if (model) {[temp setValue:model forKey:@"awayModel"];}
        }
        !completion ? : completion(temp.copy);
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        !completion ? : completion(nil);
    }];
}

- (void)requestRivalryRecordWithMatchId:(NSString *)matchId
                                  limit:(int)limit
                             completion:(void(^)(AXMatchAnalysisRivalryRecordModel *rivalryRecordModel))completion{
    AXMatchAnalysisRivalryRecordApi *api = [AXMatchAnalysisRivalryRecordApi new];
    api.matchId = matchId;
    api.limit = limit;
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchAnalysisRivalryRecordModel *model;
        if (api.isRequestSuccess) {
            model = [AXMatchAnalysisRivalryRecordModel yy_modelWithJSON:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

- (void)requestTeamRecordWithMatchId:(NSString *)matchId
                          isHostTeam: (BOOL)isHostTeam
                               limit:(int)limit
                          completion:(void(^)(AXMatchAnalysisTeamRecordModel *teamRecordModel))completion{
    AXMatchAnalysisTeamRecordApi *api = [AXMatchAnalysisTeamRecordApi new];
    api.matchId = matchId;
    api.limit = limit;
    api.isHostTeam = isHostTeam;
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchAnalysisTeamRecordModel *model;
        if (api.isRequestSuccess) {
            model = [AXMatchAnalysisTeamRecordModel yy_modelWithJSON:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

- (void)requestTeamAdvancedWithMatchId:(NSString *)matchId
                                 limit:(int)limit
                            completion:(void(^)(AXMatchAnalysisAdvancedModel *advancedModel))completion{
    AXMatchAnalysisAdvancedApi *api = [AXMatchAnalysisAdvancedApi new];
    api.matchId = matchId;
    api.limit = limit;
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchAnalysisAdvancedModel *model;
        if (api.isRequestSuccess) {
            model = [AXMatchAnalysisAdvancedModel yy_modelWithJSON:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
