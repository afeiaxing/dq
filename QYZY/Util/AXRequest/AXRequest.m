//
//  AXRequest.m
//  QYZY
//
//  Created by 22 on 2024/6/2.
//

#import "AXRequest.h"

@interface AXRequest()

@property (nonatomic, assign) BOOL isRequestSuccess;
@property (nonatomic, strong) id bizData;

@end

#define kAXHttpRequestSuccessCode 0

@implementation AXRequest

- (void)ax_startWithCompletionSuccess:(YTKRequestCompletionBlock)success
                              failure:(YTKRequestCompletionBlock)failure{
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSNumber *responseCode = request.responseJSONObject[@"code"];
        self.isRequestSuccess = responseCode.intValue == kAXHttpRequestSuccessCode;
        self.bizData = request.responseJSONObject[@"data"];
        // TODO: 统一处理返回数据
        if (responseCode.intValue == 403) {
            
        }
        success(request);
        AXLog(@"==========RequestSuccess============");
        AXLog(@"ReuqestURL: %@", request.requestUrl);
        
//        AXLog(@"ResponseData: %@", request.responseJSONObject);
        
        // json数据或者NSDictionary转为NSData，responseObject为json数据或者NSDictionary
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request.responseJSONObject options:NSJSONWritingPrettyPrinted error:nil];
        // NSData转为NSString
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        AXLog(@"ResponseData: %@", jsonStr);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        long httpCode = request.responseStatusCode;
        // TODO: 统一处理返回数据
        if (httpCode == 403) {
            
        }
        self.isRequestSuccess = false;
        AXLog(@"==========RequestFail============");
        AXLog(@"ReuqestURL: %@", request.requestUrl);
        AXLog(@"ResponseCode: %ld", httpCode);
        failure(request);
    }];
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSMutableDictionary *header = @{}.mutableCopy;
    [header setValue:@"1234" forKey:@"axing"];
    return header;
}

@end
