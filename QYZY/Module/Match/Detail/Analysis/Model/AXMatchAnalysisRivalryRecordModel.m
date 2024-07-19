//
//  AXMatchAnalysisRivalryRecordModel.m
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import "AXMatchAnalysisRivalryRecordModel.h"

@implementation AXMatchAnalysisRivalryRecordItemModel

@end

@implementation AXMatchAnalysisRivalryRecordModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"matchRecords":[AXMatchAnalysisRivalryRecordItemModel class],
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
//        @"hostTop1Mpdel":@"homeTopPerformers.top1",
//        @"hostTop2Mpdel":@"homeTopPerformers.top2",
//        @"hostTop3Mpdel":@"homeTopPerformers.top3",
//        @"awayTop1Mpdel":@"awayTopPerformers.top1",
//        @"awayTop2Mpdel":@"awayTopPerformers.top2",
//        @"awayTop3Mpdel":@"awayTopPerformers.top3",
    };
}

@end
