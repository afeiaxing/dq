//
//  AXMatchLineupRequest.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchLineupRequest.h"
#import "AXMatchLineupApi.h"

@implementation AXMatchLineupRequest

- (void)requestMatchLineupWithMatchId:(NSString *)matchId
                           completion:(void(^)(AXMatchLineupModel *lineupModel))completion{
    AXMatchLineupApi *api = [AXMatchLineupApi new];
    api.matchId = matchId;

    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchLineupModel *model;
        if (api.isRequestSuccess) {
            model = [AXMatchLineupModel yy_modelWithJSON:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
