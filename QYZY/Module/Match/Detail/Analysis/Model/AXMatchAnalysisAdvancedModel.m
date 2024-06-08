//
//  AXMatchAnalysisAdvancedModel.m
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import "AXMatchAnalysisAdvancedModel.h"

@implementation AXMatchAnalysisAdvancedStatsModel

@end

@implementation AXMatchAnalysisAdvancedAlAveModel

@end

@implementation AXMatchAnalysisAdvancedModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"awayAl":[AXMatchAnalysisAdvancedAlAveModel class],
        @"awayAve":[AXMatchAnalysisAdvancedAlAveModel class],
        @"homeAl":[AXMatchAnalysisAdvancedAlAveModel class],
        @"homeAve":[AXMatchAnalysisAdvancedAlAveModel class],
        @"teamStatistics":[AXMatchAnalysisAdvancedStatsModel class],
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"awayAl":@"singleQuarter.awayAl",
        @"awayAve":@"singleQuarter.awayAve",
        @"homeAl":@"singleQuarter.homeAl",
        @"homeAve":@"singleQuarter.homeAve",
    };
}

@end
