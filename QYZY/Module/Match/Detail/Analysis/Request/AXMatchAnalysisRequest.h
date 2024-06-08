//
//  AXMatchAnalysisRequest.h
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import <Foundation/Foundation.h>
#import "AXMatchAnalysisTeamRankModel.h"
#import "AXMatchAnalysisRivalryRecordModel.h"
#import "AXMatchAnalysisTeamRecordModel.h"
#import "AXMatchAnalysisAdvancedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisRequest : NSObject

/// 排名
- (void)requestTeamRankWithMatchId:(NSString *)matchId
                        completion:(void(^)(NSArray < AXMatchAnalysisTeamRankModel *>*teamRankModel))completion;

/// 两队历史交锋
- (void)requestRivalryRecordWithMatchId:(NSString *)matchId
                             completion:(void(^)(AXMatchAnalysisRivalryRecordModel *rivalryRecordModel))completion;

/// 主、客队各自赛过 & 未来赛程
- (void)requestTeamRecordWithMatchId:(NSString *)matchId
                          isHostTeam: (BOOL)isHostTeam
                          completion:(void(^)(AXMatchAnalysisTeamRecordModel *teamRecordModel))completion;

/// Advanced
- (void)requestTeamAdvancedWithMatchId:(NSString *)matchId
                                 limit:(int)limit
                            completion:(void(^)(AXMatchAnalysisAdvancedModel *advancedModel))completion;

@end

NS_ASSUME_NONNULL_END
