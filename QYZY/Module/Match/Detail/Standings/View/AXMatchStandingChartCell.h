//
//  AXMatchStandingChartCell.h
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import <UIKit/UIKit.h>
#import "AXMatchStandingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingChartCell : UITableViewCell

@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong) AXMatchStandingModel *standingModel;

@end

NS_ASSUME_NONNULL_END
