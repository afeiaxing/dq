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
                           completion: (void(^)(NSArray <AXMatchListItemModel *> *matchArray))completion{
    AXMatchDetailApi *api = [AXMatchDetailApi new];
    api.matchId = matchId;
    
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray *array;
        if (api.isRequestSuccess) {
            array = [NSArray yy_modelArrayWithClass:AXMatchListItemModel.class json:api.bizData];
        }
        !completion ? : completion(array);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
