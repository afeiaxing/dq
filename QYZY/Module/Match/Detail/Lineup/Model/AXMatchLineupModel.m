//
//  AXMatchLineupModel.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchLineupModel.h"

@implementation AXMatchLineupTopPerformerModel

@end

@implementation AXMatchLineupStatsModel

@end

@implementation AXMatchLineupModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
//        @"homePlayerStats":[AXMatchLineupStatsModel class],
//        @"awayPlayerStats":[AXMatchLineupStatsModel class],
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"hostTop1Mpdel":@"homeTopPerformers.top1",
        @"hostTop2Mpdel":@"homeTopPerformers.top2",
        @"hostTop3Mpdel":@"homeTopPerformers.top3",
        @"awayTop1Mpdel":@"awayTopPerformers.top1",
        @"awayTop2Mpdel":@"awayTopPerformers.top2",
        @"awayTop3Mpdel":@"awayTopPerformers.top3",
    };
}

@end
