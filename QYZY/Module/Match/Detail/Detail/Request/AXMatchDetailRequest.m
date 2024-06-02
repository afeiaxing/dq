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
    
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchDetailModel *model;
        if (api.isRequestSuccess) {
            model = [AXMatchDetailModel yy_modelWithJSON:api.bizData];
        }
        !completion ? : completion(model);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
