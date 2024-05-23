//
//  AXMatchListRequest.m
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "AXMatchListRequest.h"
#import "AXMatchListApi.h"

@implementation AXMatchListRequest

/**
 - (void)requestMatchDataWithDateString:(NSString *)dateString completion:(void(^)(QYZYMatchModel *matchModel))completion{
     QYZYMatchApi *api = [[QYZYMatchApi alloc] init];
     api.currentDateString = dateString;
     api.matchType = self.matchType;
     [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
         QYZYMatchModel *matchModel = [QYZYMatchModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
         !completion ? : completion(matchModel);
     } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         !completion ? : completion(nil);
     }];
 }
 */

- (void)requestMatchListWithcompletion:(void(^)(NSDictionary *matchModel))completion{
    AXMatchListApi *api = [AXMatchListApi new];
    AXNetWorkManager *manager = [AXNetWorkManager new];
    [manager startWithCompletionBlockWithApi:api Success:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject[@"data"];
        NSLog(@"%@", dict);
        !completion ? : completion(dict);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil);
    }];
}

@end
