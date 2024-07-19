//
//  AXMatchStandingPBPCell.h
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import <UIKit/UIKit.h>
#import "AXMatchStandingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingPBPCell : UITableViewCell

@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong) AXMatchStandingModel *standingModel;
@property (nonatomic, strong) NSDictionary *textLives;

@end

NS_ASSUME_NONNULL_END
