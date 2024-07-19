//
//  AXMatchStandingPBPSubCell.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchStandingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingPBPSubCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) AXMatchStandingTextLiveModel *model;

@end

NS_ASSUME_NONNULL_END
