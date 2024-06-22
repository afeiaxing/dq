//
//  AXMatchStandingPBPView.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchStandingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingPBPView : UIView<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) NSDictionary *textLives;

@property (nonatomic, strong) AXMatchListItemModel *matchModel;

@end

NS_ASSUME_NONNULL_END
