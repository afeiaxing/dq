//
//  AXMatchFilterViewController.h
//  QYZY
//
//  Created by 22 on 2024/5/16.
//

#import "QYZYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AXMatchFilterBlock) (BOOL isSelectAll, NSArray *selectLeagues);

@interface AXMatchFilterViewController : QYZYBaseViewController

@property (nonatomic, copy) AXMatchFilterBlock block;

@end

NS_ASSUME_NONNULL_END
