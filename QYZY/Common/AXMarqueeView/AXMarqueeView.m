//
//  AXMarqueeView.m
//  QYZY
//
//  Created by 11 on 6/9/24.
//

#import "AXMarqueeView.h"

@interface AXMarqueeView()

@property (nonatomic, strong) UILabel *marqueeLabel;

@end

@implementation AXMarqueeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    self.clipsToBounds = YES;
    [self addSubview:self.marqueeLabel];
}

- (void)setText:(NSString *)text{
    self.marqueeLabel.text = text;
    [self.marqueeLabel sizeToFit]; // 根据文本内容调整UILabel的大小
    [self startMarquee];
}

- (void)startMarquee {
    // 获取UILabel的宽度和容器视图的宽度
    CGFloat labelWidth = self.marqueeLabel.frame.size.width;
    CGFloat containerWidth = self.bounds.size.width;
    
    if (containerWidth > labelWidth) {
        // 设置UILabel的初始位置
        self.marqueeLabel.frame = CGRectMake(0, 0, labelWidth, self.bounds.size.height);
        // 如果Label长度没有超出，不执行动画
        return;
    } else {
        // 设置UILabel的初始位置
        self.marqueeLabel.frame = CGRectMake(containerWidth, 0, labelWidth, self.bounds.size.height);
    }
    
    // 计算动画持续时间（根据文本长度和需要的速度进行调整）
    CGFloat duration = labelWidth / 15.0;
    
    // 执行动画
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
        self.marqueeLabel.frame = CGRectMake(-labelWidth, 0, labelWidth, self.bounds.size.height);
    }
                     completion:nil];
}

- (UILabel *)marqueeLabel{
    if (!_marqueeLabel) {
        _marqueeLabel = [UILabel new];
        _marqueeLabel.font = AX_PingFangMedium_Font(14);
        self.marqueeLabel.textColor = UIColor.whiteColor;
    }
    return _marqueeLabel;
}

@end
