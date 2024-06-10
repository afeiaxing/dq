//
//  UIColor+AXGradient.m
//  QYZY
//
//  Created by 22 on 2024/6/10.
//

#import "UIColor+AXGradient.h"

@implementation UIColor (AXGradient)

+ (UIColor *)colorWithGradientFromColor:(UIColor *)startColor toColor:(UIColor *)endColor withHeight:(CGFloat)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    CGFloat locations[] = {0.0, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, height);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    return [UIColor colorWithPatternImage:image];
}

@end
