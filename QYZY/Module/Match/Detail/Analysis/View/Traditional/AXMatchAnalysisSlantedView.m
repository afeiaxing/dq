//
//  AXMatchAnalysisSlantedView.m
//  QYZY
//
//  Created by 22 on 2024/6/28.
//

#import "AXMatchAnalysisSlantedView.h"

@interface AXMatchAnalysisSlantedView()

@property (nonatomic, assign) BOOL isHost;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AXMatchAnalysisSlantedView

// MARK: lifecycle
- (instancetype)initWithIsHost: (BOOL)isHost{
    if (self = [super init]) {
        self.isHost = isHost;
        [self setupSubviews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (self.isHost) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(width, 0)];
        [path addLineToPoint:CGPointMake(width - 10, height)];
        [path addLineToPoint:CGPointMake(0, height)];
        [path addLineToPoint:CGPointMake(0, 0)];
        [path closePath];
        self.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMinXMaxYCorner;
    } else {
        [path moveToPoint:CGPointMake(10, 0)];
        [path addLineToPoint:CGPointMake(width, 0)];
        [path addLineToPoint:CGPointMake(width, height)];
        [path addLineToPoint:CGPointMake(0, height)];
        [path addLineToPoint:CGPointMake(10, 0)];
        self.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner;
        [path closePath];
    }

    // 设置填充颜色
    UIColor *color = self.isHost ? rgb(29, 209, 0) : rgb(209, 0, 0);
    [color setFill];
    [path fill];
}

// MARK: private
- (void)setupSubviews{
    self.backgroundColor = UIColor.clearColor;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = true;
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

// MARK: setter & getter
- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = AX_PingFangSemibold_Font(12);
    }
    return _titleLabel;
}

@end
