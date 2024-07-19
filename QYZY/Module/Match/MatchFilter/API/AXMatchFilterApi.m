//
//  AXMatchFilterApi.m
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import "AXMatchFilterApi.h"

@implementation AXMatchFilterApi

- (NSString *)requestUrl {
    return @"/app-api/score/matchList/getLeaguesNameForFilter";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:self.title forKey:@"title"];
    [dict setValue:self.sign forKey:@"sign"];
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end
