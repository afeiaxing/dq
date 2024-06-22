//
//  AXMatchFilterBottomView.h
//  QYZY
//
//  Created by 22 on 2024/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AXMatchFilterBottomEventType) {
    AXMatchFilterBottomEvent_selectall,
    AXMatchFilterBottomEvent_reverse,
    AXMatchFilterBottomEvent_confirm
};

typedef void(^AXMatchFilterBottomViewBlock) (AXMatchFilterBottomEventType eventType);

@interface AXMatchFilterBottomView : UIView

@property (nonatomic, copy) AXMatchFilterBottomViewBlock block;
@property (nonatomic, assign) int totalMatchCount;

- (void)handleUpdateCount: (int)count
               isIncrease: (BOOL)isIncrease;

@end

NS_ASSUME_NONNULL_END
