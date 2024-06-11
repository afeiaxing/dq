//
//  AXSlantedView.m
//  QYZY
//
//  Created by 22 on 2024/6/11.
//

#import "AXSlantedView.h"

@interface AXSlantedView()

@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

@end

@implementation AXSlantedView

- (instancetype)initWithFillColor:(UIColor *)fillColor
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font {
    self = [super init];
    if (self) {
        _fillColor = fillColor;
        _text = @"test";
        _textColor = textColor;
        _font = font;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat slantWidth = 20.0; // 斜面的宽度

    // 创建带有斜面的路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(width - slantWidth, 0)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(slantWidth, height)];
    [path closePath];

    // 设置填充颜色
    [self.fillColor setFill];
    [path fill];

    // 绘制文本
    NSDictionary *attributes = @{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.textColor};
    CGSize textSize = [self.text sizeWithAttributes:attributes];
    CGFloat textX = (rect.size.width - textSize.width) / 2;
    CGFloat textY = (rect.size.height - textSize.height) / 2;
    [self.text drawAtPoint:CGPointMake(textX, textY) withAttributes:attributes];
}

@end
