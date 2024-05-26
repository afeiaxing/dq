//
//  AXMatchDetailApi.m
//  QYZY
//
//  Created by 22 on 2024/5/25.
//

#import "AXMatchDetailApi.h"

@implementation AXMatchDetailApi

- (NSString *)requestUrl {
    return @"/app-api/score/matchList/getMatchInfoById";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:self.matchId forKey:@"matchId"];
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end
