//
//  AXSwitchView.m
//  QYZY
//
//  Created by 22 on 2024/6/12.
//

#import "AXSwitchView.h"

@interface AXSwitchView()

@property (nonatomic, strong) UIView *cycleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL status;

@end

@implementation AXSwitchView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: public
+ (CGFloat)viewWidth{
    return 56;
}

+ (CGFloat)viewHeight{
    return 24;
}

// MARK: private
- (void)setupSubviews{
    self.backgroundColor = AXSelectColor;
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = true;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClick)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.cycleView];
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(1);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(33);
        make.centerY.offset(0);
    }];
}

- (void)handleClick{
    self.status = !self.status;
    self.backgroundColor = self.status ? UIColor.blackColor : AXSelectColor;
    self.titleLabel.text = self.status ? @"10" : @"6";
    
    [self.cycleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(self.status ? 33 : 1);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(self.status ? 12 : 33);
    }];
    
    !self.block ? : self.block(self.status);
}

// MARK: setter & getter
- (UIView *)cycleView{
    if (!_cycleView) {
        _cycleView = [UIView new];
        _cycleView.backgroundColor = UIColor.whiteColor;
        _cycleView.layer.cornerRadius = 11;
        _cycleView.layer.masksToBounds = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClick)];
        [_cycleView addGestureRecognizer:tap];
    }
    return _cycleView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"6";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClick)];
        [_titleLabel addGestureRecognizer:tap];
    }
    return _titleLabel;
}

@end
