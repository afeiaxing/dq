//
//  AXMatchStandingsViewController.h
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "QYZYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingsViewController : QYZYBaseViewController<JXCategoryListContentViewDelegate, JXPagerViewListViewDelegate>

@property (nonatomic, strong) AXMatchListItemModel *matchModel;

@end

NS_ASSUME_NONNULL_END
