//
//  AXMatchAnalysisAdvancedQuaterCell.h
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import <UIKit/UIKit.h>
#import "AXMatchAnalysisAdvancedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisAdvancedQuaterCell : UITableViewCell

@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong) AXMatchAnalysisAdvancedModel *advancedModel;
@property (nonatomic, copy) AXBoolBlock block;

@end

NS_ASSUME_NONNULL_END
