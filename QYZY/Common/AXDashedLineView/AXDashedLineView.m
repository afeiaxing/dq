//
//  AXDashedLineView.m
//  QYZY
//
//  Created by 22 on 2024/6/10.
//

#import "AXDashedLineView.h"

@implementation AXDashedLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 设置虚线的颜色
    UIColor *lineColor = rgb(130, 134, 163);
    
    // 创建CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.lineWidth = 1.0;
    
    // 设置虚线的线段和间隔
    shapeLayer.lineDashPattern = @[@4, @2]; // 线段长4，间隔长2
    
    CGFloat viewHeight = self.bounds.size.height;
    // 创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 1)]; // 起点
    [path addLineToPoint:CGPointMake(0, viewHeight)]; // 终点
    
    // 将UIBezierPath赋给CAShapeLayer
    shapeLayer.path = path.CGPath;
    
    // 将CAShapeLayer添加到视图的图层中
    [self.layer addSublayer:shapeLayer];
}

@end
