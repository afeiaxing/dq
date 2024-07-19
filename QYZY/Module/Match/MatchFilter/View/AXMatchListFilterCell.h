//
//  AXMatchListFilterCell.h
//  QYZY
//
//  Created by 22 on 2024/6/3.
//

#import <UIKit/UIKit.h>
#import "AXMatchFilterModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AXMatchListFilterCellBlock) (BOOL isSelected, int count);

@interface AXMatchListFilterCell : UITableViewCell

@property (nonatomic, strong) AXMatchFilterItenModel *model;

@property (nonatomic, copy) AXMatchListFilterCellBlock block;

@end

NS_ASSUME_NONNULL_END
