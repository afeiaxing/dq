//
//  AXMatchLineupPerformersCell.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchLineupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchLineupPerformersCell : UITableViewCell

@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong) AXMatchLineupModel *lineupModel;

@end

NS_ASSUME_NONNULL_END
