//
//  AXMatchAnalysisTraditionalMatchCell.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchAnalysisRivalryRecordModel.h"
#import "AXMatchAnalysisTeamRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisTraditionalMatchCell : UITableViewCell

@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong) AXMatchAnalysisRivalryRecordModel *rivalryRecordModel;
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *hostTeamRecordModel;
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *awayTeamRecordModel;
@property (nonatomic, assign) BOOL isRequest10;
@property (nonatomic, copy) AXIntBlock block;

@end

NS_ASSUME_NONNULL_END
