//
//  AXMatchListRequest.m
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "AXMatchListRequest.h"
#import "AXMatchListApi.h"
#import "AXMatchBatchApi.h"

@implementation AXMatchListRequest

// MARK: Public
- (void)requestMatchListWithType: (AXMatchStatus)type
                          pageNo: (int)pageNo
                       startTime: (NSString *)startTime
                         endTime: (NSString *)endTime
                          filter: (NSString *)filter
                      completion: (void(^)(AXMatchListModel *matchModel, BOOL hasMoreData))completion{
    AXMatchListApi *api = [AXMatchListApi new];
    api.pageNo = pageNo;
    switch (type) {
        case AXMatchStatusSchedule:
            api.type = 2;
            break;
        case AXMatchStatusLive:
            api.type = 1;
            break;
        case AXMatchStatusResult:
            api.type = 3;
            break;
        default:
            break;
    }
    api.startTime = startTime;
    api.endTime = endTime;
    api.filter = filter;
    [api ax_startWithCompletionSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AXMatchListModel *model;
        BOOL hasMoreData = false;
        if (api.isRequestSuccess) {
            NSArray *array = [NSArray yy_modelArrayWithClass:AXMatchListItemModel.class json:api.bizData];
            hasMoreData = array.count == AXMatchListRequestPageSize.intValue;
            model = [self handleMatchListWithArray:array];
        }
        !completion ? : completion(model, hasMoreData);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !completion ? : completion(nil, false);
    }];
}

- (void)requestBatchMatchWithMatchId: (NSString *)matchIds
                          completion: (void(^)(NSArray <AXMatchListItemModel *> *matchArray))completion{
    AXMatchBatchApi *api = [AXMatchBatchApi new];
    api.matchIds = matchIds;
    
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

// MARK: Private
- (AXMatchListModel *)handleMatchListWithArray: (NSArray *)array{
    AXMatchListModel *model = [AXMatchListModel new];
    
    NSMutableArray *schedule = [NSMutableArray array];
    NSMutableArray *live = [NSMutableArray array];
    NSMutableArray *result = [NSMutableArray array];
    
    NSMutableString *temp = [NSMutableString string];
    
    for (AXMatchListItemModel *model in array) {
        if (model.leaguesStatus.intValue == 10) {
            [result addObject:model];
        } else if (model.leaguesStatus.intValue == 1) {
            [schedule addObject:model];
//            [temp appendFormat:@"%@,", model.matchId];
        } else {
            [live addObject:model];
            [temp appendFormat:@"%@,", model.matchId];
        }
    }
    
    model.schedule = schedule.copy;
    model.live = live.copy;
    model.result = result.copy;
    
    if (temp.length > 0) {
        [temp replaceCharactersInRange:NSMakeRange(temp.length - 1, 1) withString:@""];
    }
    self.batchMatchIds = temp.copy;
    
    return model;
}

@end
