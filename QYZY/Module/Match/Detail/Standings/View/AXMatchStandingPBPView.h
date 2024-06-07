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

@property (nonatomic, strong) NSArray <AXMatchStandingTextLiveModel *> *textLives;

@end

NS_ASSUME_NONNULL_END
