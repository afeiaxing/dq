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
                        completion:(void(^)(NSArray < AXMatchAnalysisTeamRankModel *>*teamRankModel))completion{
    AXMatchAnalysisTeamRankApi *api = [AXMatchAnalysisTeamRankApi new];
    api.matchId = matchId;
    api.limit = limit;
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray *array;
        if (api.isRequestSuccess) {
            array = [NSArray yy_modelArrayWithClass:AXMatchAnalysisTeamRankModel.class json:api.bizData[@"teamRankings"]];
        }
        !completion ? : completion(array);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
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
