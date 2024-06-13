//
//  AXMatchBatchApi.m
//  QYZY
//
//  Created by 22 on 2024/6/13.
//

#import "AXMatchBatchApi.h"

@implementation AXMatchBatchApi

- (NSString *)requestUrl {
    return @"/app-api/score/matchList/getMatchInfoById";
}

- (id)requestArgument {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:self.matchIds forKey:@"matchIds"];
    return dict;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}


@end
