//
//  AXMatchListApi.m
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "AXMatchListApi.h"

@implementation AXMatchListApi

- (NSString *)requestUrl {
    return @"/app-api/score/matchList2/page";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    if (self.type) {
        [dict setValue:@(self.type) forKey:@"type"];
    }
    [dict setValue:self.startTime forKey:@"startTime"];
    [dict setValue:self.endTime forKey:@"endTime"];
    [dict setValue:self.filter forKey:@"filter"];
    [dict setValue:@(self.pageNo) forKey:@"pageNo"];
    [dict setValue:AXMatchListRequestPageSize forKey:@"pageSize"];
    
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end
