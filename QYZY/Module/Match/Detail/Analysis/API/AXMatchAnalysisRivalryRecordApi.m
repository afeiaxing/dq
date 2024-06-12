//
//  AXMatchAnalysis RivalryRecordApi.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchAnalysisRivalryRecordApi.h"

@implementation AXMatchAnalysisRivalryRecordApi

- (NSString *)requestUrl {
    return @"/app-api/score/analysis/traditional/rivalryRecord";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:self.matchId forKey:@"matchId"];
    [dict setValue:AXProductTypeKey forKey:@"productType"];
    [dict setValue:@(self.limit) forKey:@"limit"];
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end
