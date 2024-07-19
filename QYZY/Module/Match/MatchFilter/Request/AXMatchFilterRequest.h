//
//  AXMatchFilterRequest.h
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import <Foundation/Foundation.h>
#import "AXMatchFilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchFilterRequest : NSObject

- (void)requestMatchListWithTitle: (NSString *)title
                             sign: (NSString *)sign
                       completion: (void(^)(AXMatchFilterModel *filterModel))completion;

@end

NS_ASSUME_NONNULL_END
