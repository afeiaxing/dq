//
//  QYZYMatchSubViewController.h
//  QYZY
//
//  Created by jspollo on 2022/10/12.
//

#import "QYZYBaseViewController.h"
#import "AXMatchListModel.h"
#import "AXMatchListDateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZYMatchSubViewController : QYZYBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic ,strong) NSArray <NSArray *> *matches;
@property (nonatomic ,strong) void(^requestBlock)(void);
@property (nonatomic, assign) AXMatchStatus status;

- (void)handleFilterDataWithLeagues: (nullable NSString *)leagues;

// 当设置筛选条件，切换其他tab，切换回来时，清空筛选条件
- (void)tryToClearFilterLeagues;

@end

NS_ASSUME_NONNULL_END
