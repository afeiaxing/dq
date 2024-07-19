//
//  AXMatchAnalysisTeamRecordModel.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchAnalysisTeamRecordModel.h"

@implementation AXMatchAnalysisTeamRecordItemModel

@end

@implementation AXMatchAnalysisTeamRecordModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"matchRecords":[AXMatchAnalysisRivalryRecordItemModel class],
        @"homeSchedule":[AXMatchAnalysisTeamRecordItemModel class],
        @"awaySchedule":[AXMatchAnalysisTeamRecordItemModel class],
    };
}

@end
