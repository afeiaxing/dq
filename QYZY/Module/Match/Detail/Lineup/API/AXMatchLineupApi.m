//
//  AXMatchLineupApi.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchLineupApi.h"

@implementation AXMatchLineupApi

- (NSString *)requestUrl {
    return @"/app-api/score/lineup";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:self.matchId forKey:@"matchId"];
    [dict setValue:AXProductTypeKey forKey:@"productType"];
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end
