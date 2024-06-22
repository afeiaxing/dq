//
//  AXMatchAnalysisTeamRankApi.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchAnalysisTeamRankApi.h"

@implementation AXMatchAnalysisTeamRankApi

- (NSString *)requestUrl {
    return @"/app-api/score/analysis/traditional/teamRanking";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:self.matchId forKey:@"matchId"];
    [dict setValue:AXProductTypeKey forKey:@"productType"];
    [dict setValue:@(self.limit) forKey:@"limit"];
    [dict setValue:self.type forKey:@"type"];
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end
