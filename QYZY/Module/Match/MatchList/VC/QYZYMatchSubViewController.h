//
//  QYZYMatchSubViewController.h
//  QYZY
//
//  Created by jspollo on 2022/10/12.
//

#import "QYZYBaseViewController.h"
#import "AXMatchListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AXMatchStatusAll,
    AXMatchStatusSchedule,
    AXMatchStatusLive,
    AXMatchStatusResult,
} AXMatchStatus;

@interface QYZYMatchSubViewController : QYZYBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic ,strong) NSArray <NSArray *> *matches;
@property (nonatomic ,strong) void(^requestBlock)(void);
@property (nonatomic, assign) AXMatchStatus status;

- (void)endRefresh;
@end

NS_ASSUME_NONNULL_END
