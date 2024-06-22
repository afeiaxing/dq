//
//  AXMatchStandingRequest.h
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import <Foundation/Foundation.h>
#import "AXMatchStandingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingRequest : NSObject

- (void)requestMatchStandingWithMatchId:(NSString *)matchId
                             completion:(void(^)(AXMatchStandingModel *matchModel))completion;

- (void)requestMatchTextLiveWithMatchId:(NSString *)matchId
                             completion:(void(^)(NSDictionary *textLives))completion;

@end

NS_ASSUME_NONNULL_END
