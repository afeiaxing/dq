//
//  UIColor+AXGradient.h
//  QYZY
//
//  Created by 22 on 2024/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AXGradient)

+ (UIColor *)colorWithGradientFromColor:(UIColor *)startColor toColor:(UIColor *)endColor withHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
