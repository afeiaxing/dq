//
//  AXMatchStandingApi.m
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import "AXMatchStandingApi.h"

@implementation AXMatchStandingTextLiveApi

- (NSString *)requestUrl {
    return @"/app-api/score/live";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:self.matchId forKey:@"matchId"];
    [dict setValue:AXProductTypeKey forKey:@"productType"];
    [dict setValue:@1 forKey:@"page"];
    [dict setValue:@1000 forKey:@"pageSize"];
    [dict setValue:self.statusId forKey:@"statusId"];
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end

@implementation AXMatchStandingApi

- (NSString *)requestUrl {
    return @"/app-api/score/standings";
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
