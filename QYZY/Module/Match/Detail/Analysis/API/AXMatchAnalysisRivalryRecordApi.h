//
//  AXMatchAnalysis RivalryRecordApi.h
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisRivalryRecordApi : AXRequest

@property (nonatomic, strong) NSString *matchId;
@property (nonatomic, assign) int limit;

@end

NS_ASSUME_NONNULL_END
