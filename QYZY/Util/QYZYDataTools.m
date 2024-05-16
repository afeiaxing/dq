//
//  QYZYDataTools.m
//  QYZY
//
//  Created by 11 on 5/14/24.
//

#import "QYZYDataTools.h"

@implementation QYZYDataTools

+ (QYZYSubMatchModel *)getQYZYSubMatchModel{
    QYZYSubMatchModel *model = [QYZYSubMatchModel new];
    QYZYMatchDetailModel *match = [QYZYMatchDetailModel new];
    model.matches = @[match, match, match];
    model.count = @"3";
    model.hostWinNum = @"1";
    model.hostLoseNum = @"2";
    model.hostDrawNum = @"4";
    model.hostScore = @"5";
    model.guestScore = @"6";
    model.sportId = @"1";
    model.pointsLostPerGame = @"7";
    model.pointsGetPerGame = @"8";
    
    return model;
}

+ (QYZYMatchAnalyzeRankModel *)getQYZYMatchAnalyzeRankModel{
    QYZYMatchAnalyzeRankModel * model = [QYZYMatchAnalyzeRankModel new];
    /**
     @interface QYZYMatchAnalyzeRankSubModel : NSObject
     @property (nonatomic ,strong) NSString *teamId;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *logo;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *leagueName;
     @property (nonatomic ,strong) NSString *depart;
     @property (nonatomic ,assign) NSInteger continuousStatus;
     @property (nonatomic ,strong) NSString *goal;
     @property (nonatomic ,strong) NSString *lostGoal;
     @property (nonatomic ,strong) NSString *point;
     @property (nonatomic ,strong) NSString *promotionId;
     @property (nonatomic ,strong) NSString *promotionCnName;
     @property (nonatomic ,strong) NSString *promotionEnName;
     @end

     @interface QYZYMatchAnalyzeRankModel : NSObject
     @property (nonatomic ,strong) NSArray <QYZYMatchAnalyzeRankSubModel *> *all;
     @property (nonatomic ,strong) NSArray <QYZYMatchAnalyzeRankSubModel *> *;
     @property (nonatomic ,strong) NSArray <QYZYMatchAnalyzeRankSubModel *> *;
     @property (nonatomic ,strong) NSArray <QYZYMatchAnalyzeRankSubModel *> *sameHostGuest;
     @end
     */
    QYZYMatchAnalyzeRankSubModel *rank = [QYZYMatchAnalyzeRankSubModel new];
    rank.teamName = @"aaa";
    rank.teamRank = @"8";
    rank.matchCount = @"11";
    rank.win = @"1";
    rank.draw = @"2";
    rank.lost = @"3";
    rank.points = @"33";
    rank.lostPoints = @"133";
    model.all = @[rank, rank, rank, rank];
    model.host = @[rank, rank, rank];
    model.guest = @[rank, rank];
    model.sameHostGuest = @[rank, rank, rank, rank, rank, rank, rank];
    
    return model;
}

+ (NSArray <QYZYMatchMainModel *>*)getQYZYMatchMainModels{
    QYZYMatchMainModel *model = [QYZYMatchMainModel new];
    /**
     @property (nonatomic ,strong) NSString *trendAnim;
     @property (nonatomic ,strong) NSString *animUrl;
     @property (nonatomic ,strong) NSString *obliqueAnimUrl;
     @property (nonatomic ,strong) NSString *matchId;
     @property (nonatomic ,strong) NSString *hostTeamId;
     @property (nonatomic ,strong) NSString *hostTeamLogo;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *guestTeamId;
     @property (nonatomic ,strong) NSString *guestTeamLogo;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *sportId;
     @property (nonatomic ,strong) NSString *leagueId;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic ,strong) NSString *round;
     @property (nonatomic ,strong) NSString *matchTime;
     @property (nonatomic ,strong) NSString *;
     @property (nonatomic, strong) NSString *;
     @property (nonatomic, strong) NSString *;
     @property (nonatomic, strong) NSString *;
     @property (nonatomic, strong) NSString *;
     @property (nonatomic, strong) NSString *timeInterval;
     @property (nonatomic, strong) NSNumber *matchStatusCode;
     @property (nonatomic ,strong) NSNumber *timePlayed;
     @property (nonatomic ,strong) NSNumber *matchStatus;
     */
    model.hostTeamName = @"皇马";
    model.guestTeamName = @"巴萨";
    model.leagueNick = @"世界杯";
    model.leagueName = @"欧冠";
    model.groupName = @"ASD";
    model.hostTeamScore = @"22";
    model.guestTeamScore = @"33";
    model.hostTeamHalfScore = @"7";
    model.guestTeamHalfScore = @"6";
    
    return @[model, model ,model, model, model];
}

@end
