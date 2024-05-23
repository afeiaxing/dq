//
//  AXMatchListApi.m
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "AXMatchListApi.h"

@implementation AXMatchListApi

- (NSString *)requestUrl {
    return @"/app-api/score/matchList/page";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

@end
