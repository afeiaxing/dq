//
//  AXMatchAnalysisTraditionalRankCell.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchAnalysisTeamRankModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisTraditionalRankCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *teamRankModel;
@property (nonatomic, copy) AXBoolBlock block;

@end

NS_ASSUME_NONNULL_END
