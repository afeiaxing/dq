//
//  AXMatchLineupPerformersPlayerView.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchLineupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchLineupPerformersPlayerView : UIView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) AXMatchLineupTopPerformerModel *hostModel;
@property (nonatomic, strong) AXMatchLineupTopPerformerModel *awayModel;

@end

NS_ASSUME_NONNULL_END
