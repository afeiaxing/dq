//
//  AXToastView.m
//  QYZY
//
//  Created by 22 on 2024/6/1.
//

#import "AXToastView.h"

@interface AXToastView()

@property (nonatomic, strong) UIImageView * bgView;

@property (nonatomic, strong) UIImageView * loadingIV;

@property (nonatomic, strong) UILabel * toastLabel;

@end

@implementation AXToastView

- (void)dealloc {
    [self stopLoadingAnimation];
}

- (instancetype)initWithToastType:(AXToastType)type
                            toast:(NSString *)toast
                           offset:(CGFloat)offset {
    self = [super init];
    if (self) {
        [self initUIWithType:type toast:toast offset:offset];
        [self beginLoadingAnimation];
    }
    return self;
}

- (void)initUIWithType:(AXToastType)type
                 toast:(NSString *)toast
                offset:(CGFloat)offset {
    if (type != AXToastTypeLoadingWithoutBG) {
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.offset(offset);
        }];
    }
    
    [self addSubview:self.loadingIV];
    if (toast.length > 0) {
        [self.loadingIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-15 + offset);
        }];
        [self addSubview:self.toastLabel];
        [self.toastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.loadingIV.mas_bottom).offset(10 + offset);
        }];
        self.toastLabel.text = toast;
    } else {
        [self.loadingIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.offset(offset);
        }];
    }
}

- (void)beginLoadingAnimation {
    NSTimeInterval animationDuration = 1;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = (id) 0;
    animation.toValue = @(M_PI*2);
    animation.duration = animationDuration;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [self.loadingIV.layer addAnimation:animation forKey:@"IndicatorAnimation"];
}

- (void)stopLoadingAnimation {
    [self.loadingIV.layer removeAnimationForKey:@"IndicatorAnimation"];
}

#pragma mark - Getters

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"common_loading_bg"];
    }
    return _bgView;
}

- (UIImageView *)loadingIV {
    if (!_loadingIV) {
        UIImage *image = [[UIImage imageNamed:@"common_loading"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _loadingIV = [[UIImageView alloc] init];
        _loadingIV.image = image;
        _loadingIV.tintColor = AXSelectColor;
    }
    return _loadingIV;
}

- (UILabel *)toastLabel {
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc] init];
        _toastLabel.textColor = AXSelectColor;
        _toastLabel.font = [UIFont systemFontOfSize:14];
        _toastLabel.text = AXToastText;
    }
    return _toastLabel;
}


@end
