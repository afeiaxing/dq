//
//  AXMatchDetailRequest.h
//  QYZY
//
//  Created by 22 on 2024/5/25.
//

#import <Foundation/Foundation.h>
#import "AXMatchDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchDetailRequest : NSObject

- (void)requestMatchDetailWithMatchId: (NSString *)matchId
                           completion:(void(^)(AXMatchDetailModel *matchModel))completion;

@end

NS_ASSUME_NONNULL_END
