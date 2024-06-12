//
//  AXMatchAnalysisTeamRecordApi.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchAnalysisTeamRecordApi.h"

@implementation AXMatchAnalysisTeamRecordApi

- (NSString *)requestUrl {
    return self.isHostTeam ? @"/app-api/score/analysis/traditional/homeRecord" : @"app-api/score/analysis/traditional/awayRecord";
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
