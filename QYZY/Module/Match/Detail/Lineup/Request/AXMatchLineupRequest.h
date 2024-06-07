//
//  AXMatchLineupRequest.h
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import <Foundation/Foundation.h>
#import "AXMatchLineupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchLineupRequest : NSObject

- (void)requestMatchLineupWithMatchId:(NSString *)matchId
                           completion:(void(^)(AXMatchLineupModel *lineupModel))completion;

@end

NS_ASSUME_NONNULL_END
