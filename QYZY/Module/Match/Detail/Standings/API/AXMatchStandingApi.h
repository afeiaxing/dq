//
//  AXMatchStandingApi.h
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import "YTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingTextLiveApi : AXRequest

@property (nonatomic, strong) NSString *matchId;
@property (nonatomic, strong) NSString *statusId;

@end

@interface AXMatchStandingApi : AXRequest

@property (nonatomic, strong) NSString *matchId;

@end

NS_ASSUME_NONNULL_END
