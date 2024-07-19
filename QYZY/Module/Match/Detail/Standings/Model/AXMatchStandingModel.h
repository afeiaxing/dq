//
//  AXMatchStandingModel.h
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingTextLiveModel : NSObject

/// 状态
@property (nonatomic, strong) NSString *statusName;
/// 时间
@property (nonatomic, strong) NSString *time;
/// 阶段
@property (nonatomic, strong) NSString *stage;
/// 描述
@property (nonatomic, strong) NSString *explain;
/// 主队比分
@property (nonatomic, strong) NSString *homeScore;
/// 客队比分
@property (nonatomic, strong) NSString *awayScore;
/// 比分，格式：客队-主队
@property (nonatomic, strong) NSString *score;
/// 单次得分
@property (nonatomic, strong) NSString *singleScore;
/// 得分球队(1-主队，2-客队)
@property (nonatomic, strong) NSString *pointTeam;
/// 得分球队(1-主队，2-客队)
@property (nonatomic, strong) NSString *teamType;

@end

@interface AXMatchStandingAllStatsModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *homeScore;
@property (nonatomic, strong) NSString *awayScore;

@end

@interface AXMatchStandingTeamStatsModel : NSObject

@property (nonatomic, strong) NSString *threePoints;
@property (nonatomic, strong) NSString *twoPoints;
@property (nonatomic, strong) NSString *freeThrow;
@property (nonatomic, strong) NSString *freeThrowAccuracy;
@property (nonatomic, strong) NSString *currentFouls;
@property (nonatomic, strong) NSString *timeouts;

@end

@interface AXMatchStandingModel : NSObject

@property (nonatomic, strong) NSArray *scoreDiff;
@property (nonatomic, strong) AXMatchStandingTeamStatsModel *hostTeamStats;
@property (nonatomic, strong) AXMatchStandingTeamStatsModel *awayTeamStats;
@property (nonatomic, strong) NSArray *statistics;
//@property (nonatomic, strong) NSArray *tlive;


@end

NS_ASSUME_NONNULL_END
