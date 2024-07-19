//
//  AXMatchAnalysisAdvancedTeamStatsCell.h
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import <UIKit/UIKit.h>
#import "AXMatchAnalysisAdvancedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisAdvancedTeamStatsCell : UITableViewCell

@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong)NSArray <AXMatchAnalysisAdvancedStatsModel *> *teamStatistics;

@end

NS_ASSUME_NONNULL_END
