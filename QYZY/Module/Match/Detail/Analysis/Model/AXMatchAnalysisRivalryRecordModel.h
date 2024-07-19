//
//  AXMatchAnalysisRivalryRecordModel.h
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisRivalryRecordItemModel : NSObject

@property (nonatomic, strong) NSString *matchId;
@property (nonatomic, strong) NSString *matchDate;
@property (nonatomic, strong) NSString *homeTeamName;
@property (nonatomic, strong) NSString *awayTeamName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *handicap;
@property (nonatomic, strong) NSString *handicapResult;
@property (nonatomic, strong) NSString *ou;
@property (nonatomic, strong) NSString *ouResult;

@end

@interface AXMatchAnalysisRivalryRecordModel : NSObject

@property (nonatomic, strong) NSString *ave;
@property (nonatomic, strong) NSString *l;
@property (nonatomic, strong) NSString *games;
@property (nonatomic, strong) NSString *point;
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *lose;
@property (nonatomic, strong) NSArray <AXMatchAnalysisRivalryRecordItemModel *>*matchRecords;

@end

NS_ASSUME_NONNULL_END
