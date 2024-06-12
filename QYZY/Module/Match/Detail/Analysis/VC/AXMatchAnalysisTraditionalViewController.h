//
//  AXMatchAnalysisTraditionalViewController.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "QYZYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisTraditionalViewController : QYZYBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) AXMatchListItemModel *matchModel;

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
