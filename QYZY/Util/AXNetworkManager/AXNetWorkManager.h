//
//  AXNetWorkManager.h
//  QYZY
//
//  Created by 22 on 2024/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXNetWorkManager : NSObject

+ (instancetype)shareInstace;

- (void)startWithCompletionBlockWithApi:(YTKRequest *)api
                                Success:(YTKRequestCompletionBlock)success
                                failure:(YTKRequestCompletionBlock)failure;

@end

NS_ASSUME_NONNULL_END
