//
//  AXMatchListRequest.h
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchListRequest : NSObject

- (void)requestMatchListWithcompletion:(void(^)(NSDictionary *matchModel))completion;

@end

NS_ASSUME_NONNULL_END
