//
//  AXMatchStandingModel.h
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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


@end

NS_ASSUME_NONNULL_END
