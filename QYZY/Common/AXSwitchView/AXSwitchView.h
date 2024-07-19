//
//  AXSwitchView.h
//  QYZY
//
//  Created by 22 on 2024/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXSwitchView : UIView

@property (nonatomic, copy) AXBoolBlock block;

+ (CGFloat)viewWidth;

+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
