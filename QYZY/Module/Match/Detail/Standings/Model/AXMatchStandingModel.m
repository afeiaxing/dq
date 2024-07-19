//
//  AXMatchStandingModel.m
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import "AXMatchStandingModel.h"

@implementation AXMatchStandingTextLiveModel

@end

@implementation AXMatchStandingAllStatsModel

@end

@implementation AXMatchStandingTeamStatsModel

@end

@implementation AXMatchStandingModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"statistics":[AXMatchStandingAllStatsModel class],
//        @"tlive":[AXMatchStandingTextLiveModel class],
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"hostTeamStats":@"homeTeam.teamStats",
        @"awayTeamStats": @"awayTeam.teamStats",
        @"scoreDiff": @"trendDetail.scoreDiff",
        @"statistics": @"statistics",
//        @"tlive": @"tlive",
    };
}

@end
