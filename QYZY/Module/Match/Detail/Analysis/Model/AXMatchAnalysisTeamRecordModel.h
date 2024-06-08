//
//  AXMatchAnalysisTeamRecordModel.h
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import <Foundation/Foundation.h>
#import "AXMatchAnalysisRivalryRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisTeamRecordItemModel : NSObject

@property (nonatomic, strong) NSString *matchId;
/// 比赛日期
@property (nonatomic, strong) NSString *matchDate;
/// 赛事名称
@property (nonatomic, strong) NSString *competitionName;
/// 对阵 主队VS客队
@property (nonatomic, strong) NSString *games;
/// 距离现在的天数
@property (nonatomic, strong) NSString *interval;

@end

@interface AXMatchAnalysisTeamRecordModel : NSObject

@property (nonatomic, strong) NSString *ave;
@property (nonatomic, strong) NSString *l;
@property (nonatomic, strong) NSString *games;
@property (nonatomic, strong) NSString *point;
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *lose;
@property (nonatomic, strong) NSArray <AXMatchAnalysisRivalryRecordItemModel *>*matchRecords;
@property (nonatomic, strong) NSArray <AXMatchAnalysisTeamRecordItemModel *>*homeSchedule;
@property (nonatomic, strong) NSArray <AXMatchAnalysisTeamRecordItemModel *>*awaySchedule;

@end

NS_ASSUME_NONNULL_END
