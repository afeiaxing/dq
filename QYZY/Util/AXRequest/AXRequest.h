//
//  AXRequest.h
//  QYZY
//
//  Created by 22 on 2024/6/2.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXRequest : YTKRequest

@property (nonatomic, assign, readonly) BOOL isRequestSuccess;
@property (nonatomic, strong, readonly) id bizData;

- (void)ax_startWithCompletionSuccess:(YTKRequestCompletionBlock)success
                              failure:(YTKRequestCompletionBlock)failure;


@end

NS_ASSUME_NONNULL_END
