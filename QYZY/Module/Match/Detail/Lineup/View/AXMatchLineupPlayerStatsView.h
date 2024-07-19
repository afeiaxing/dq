//
//  AXMatchLineupPlayerStatsView.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchLineupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchLineupPlayerStatsView : UIView<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) NSArray *playerStats;

@end

NS_ASSUME_NONNULL_END
