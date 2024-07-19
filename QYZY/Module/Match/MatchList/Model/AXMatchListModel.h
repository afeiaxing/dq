//
//  AXMatchListModel.h
//  QYZY
//
//  Created by 22 on 2024/5/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchListItemModel : NSObject

@property (nonatomic, strong) NSString *matchId;
@property (nonatomic, strong) NSString *leaguesName;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *leaguesLogo;
/// 赛事状态：1:未开赛，2:第1节，3:第1节完，4:第2节，5:第2节完，6:第3节，:第3节完，8:第4节，9:加时，10:完
@property (nonatomic, strong) NSString *leaguesStatus;
@property (nonatomic, strong) NSString *matchTime;
/// 让分:正数：主队让客队；负数：客队让主队
@property (nonatomic, strong) NSString *spread;
@property (nonatomic, strong) NSString *homeTeamId;
@property (nonatomic, strong) NSString *homeTeamName;
@property (nonatomic, strong) NSString *homeTeamLogo;
@property (nonatomic, strong) NSArray *homeScoreList;
@property (nonatomic, strong) NSString *homeTotalScore;
@property (nonatomic, strong) NSString *homePosition;
@property (nonatomic, strong) NSString *homeOdds;
@property (nonatomic, strong) NSString *awayTeamId;
@property (nonatomic, strong) NSString *awayTeamName;
@property (nonatomic, strong) NSString *awayTeamLogo;
@property (nonatomic, strong) NSArray *awayscoreList;
@property (nonatomic, strong) NSString *awayTotalScore;
@property (nonatomic, strong) NSString *awayPosition;
@property (nonatomic, strong) NSString *awayOdds;
@property (nonatomic, strong) NSString *ballScore;
@property (nonatomic, strong) NSString *bigBallOdds;
@property (nonatomic, strong) NSString *smallBallOdds;
/// 比赛剩余时长:比赛剩余时长
@property (nonatomic, strong) NSString *residualTime;
/// 比分变化值，自定义属性
@property (nonatomic, assign) int hostScoreChangeValue;
@property (nonatomic, assign) BOOL awayScoreChangeValue;

@end

@interface AXMatchListModel : NSObject

@property (nonatomic, strong) NSArray *schedule;
@property (nonatomic, strong) NSArray *live;
@property (nonatomic, strong) NSArray *result;

@end

NS_ASSUME_NONNULL_END
