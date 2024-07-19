//
//  UIView+AXToast.h
//  QYZY
//
//  Created by 22 on 2024/6/1.
//

#import <UIKit/UIKit.h>
#import "AXToastView.h"

NS_ASSUME_NONNULL_BEGIN

static CGFloat AXLoadingDuration = 30.0;
static CGFloat AXToastDuration = 2.0;

@interface UIView (AXToast)

+ (NSString *)ax_viewId;

/// 显示loading
- (void)ax_showLoading;

/// 显示loading与自定义toast
/// @param toast toast文本
- (void)ax_showLoadingToast:(NSString *)toast;

/// 显示loading与自定义toast, 自定loading样式
/// @param toast toast文本
/// @param type 弹窗样式
/// @param offset 偏移量
/// @param duration 持续时间
- (void)ax_showLoadingToast:(NSString *_Nullable)toast
                       type:(AXToastType)type
                     offset:(CGFloat)offset
                   duration:(CGFloat)duration;

/// 隐藏loading
- (void)ax_hideLoading;

/// 显示toast
/// @param toast toast文本
- (void)ax_showToast:(NSString *)toast;

/// 显示无背景的loading
- (void)ax_showNoBGLoading;

@end

NS_ASSUME_NONNULL_END
