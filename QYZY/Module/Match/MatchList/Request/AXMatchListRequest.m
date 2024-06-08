//
//  AXMatchListRequest.m
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "AXMatchListRequest.h"
#import "AXMatchListApi.h"

@implementation AXMatchListRequest

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

- (AXMatchListModel *)handleMatchListWithArray: (NSArray *)array{
    AXMatchListModel *model = [AXMatchListModel new];
    
    NSMutableArray *schedule = [NSMutableArray array];
    NSMutableArray *live = [NSMutableArray array];
    NSMutableArray *result = [NSMutableArray array];
    
    for (AXMatchListItemModel *match in array) {
        if (match.leaguesStatus.intValue == 10) {
            [result addObject:match];
        } else if (match.leaguesStatus.intValue == 1) {
            [schedule addObject:match];
        } else {
            [live addObject:match];
        }
    }
    
    model.schedule = schedule.copy;
    model.live = live.copy;
    model.result = result.copy;
    
    return model;
}

@end
