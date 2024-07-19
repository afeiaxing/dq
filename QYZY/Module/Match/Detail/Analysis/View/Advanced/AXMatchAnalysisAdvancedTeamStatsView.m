//
//  AXMatchAnalysisAdvancedTeamStatsView.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisAdvancedTeamStatsView.h"

@interface AXMatchAnalysisAdvancedTeamStatsView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *hostValue;
@property (nonatomic, strong) UILabel *awayValue;
@property (nonatomic, strong) UIView *hostBackView;
@property (nonatomic, strong) UIView *awayBackView;
@property (nonatomic, strong) UIView *hostTintView;
@property (nonatomic, strong) UIView *awayTintView;

@end

@implementation AXMatchAnalysisAdvancedTeamStatsView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.hostValue];
    [self addSubview:self.awayValue];
    [self addSubview:self.hostBackView];
    [self addSubview:self.awayBackView];
    [self addSubview:self.hostTintView];
    [self addSubview:self.awayTintView];
    
    CGFloat backViewW = [self getBackViewWidth];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [self.hostBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel.mas_left).offset(-20);
        make.width.mas_equalTo(backViewW);
        make.height.mas_equalTo(8);
    }];
    
    [self.hostTintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.centerY.equalTo(self.hostBackView);
        make.width.mas_equalTo(100);
    }];
    
    [self.awayBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.hostBackView);
        make.left.equalTo(self.titleLabel.mas_right).offset(20);
        make.width.mas_equalTo(backViewW);
    }];
    
    [self.awayTintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.centerY.equalTo(self.awayBackView);
        make.width.mas_equalTo(70);
    }];
    
    [self.hostValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostTintView);
        make.top.equalTo(self.titleLabel);
    }];
    
    [self.awayValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.awayTintView);
        make.top.equalTo(self.titleLabel);
    }];
}

- (CGFloat)getBackViewWidth {
    return (ScreenWidth - 80 - (20 + 16) * 2) / 2;
}

// MARK: setter & getter
- (void)setModel:(AXMatchAnalysisAdvancedStatsModel *)model{
    self.titleLabel.text = [NSString stringWithFormat:@"%@\n%@", model.name, model.subtitle];
    self.hostValue.text = model.homeScore;
    self.awayValue.text = model.awayScore;
    
    CGFloat totalValue = model.homeScore.floatValue + model.awayScore.floatValue;
    CGFloat hostPrecent = model.homeScore.floatValue / totalValue;
    CGFloat awayPrecent = model.awayScore.floatValue / totalValue;
    
    // 兼容返回异常数据
    hostPrecent = hostPrecent > 0 ? hostPrecent : 0.01;
    awayPrecent = awayPrecent > 0 ? awayPrecent : 0.01;
    
    CGFloat backViewW = [self getBackViewWidth];
    
    [self.hostTintView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(backViewW * hostPrecent);
    }];
    
    [self.awayTintView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(backViewW * awayPrecent);
    }];

    [self.hostValue mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostTintView);
    }];

    [self.awayValue mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.awayTintView);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)hostValue {
    if (!_hostValue) {
        _hostValue = [[UILabel alloc] init];
        _hostValue.font = [UIFont systemFontOfSize:12];
        _hostValue.text = @"-";
    }
    return _hostValue;
}

- (UILabel *)awayValue {
    if (!_awayValue) {
        _awayValue = [[UILabel alloc] init];
        _awayValue.font = [UIFont systemFontOfSize:12];
        _awayValue.text = @"-";
    }
    return _awayValue;
}

- (UIView *)hostBackView {
    if (!_hostBackView) {
        _hostBackView = [[UIView alloc] init];
        _hostBackView.backgroundColor = rgb(255, 247, 239);
        _hostBackView.layer.cornerRadius = 4;
        _hostBackView.layer.masksToBounds = true;
    }
    return _hostBackView;
}

- (UIView *)awayBackView {
    if (!_awayBackView) {
        _awayBackView = [[UIView alloc] init];
        _awayBackView.backgroundColor = rgb(255, 247, 239);
        _awayBackView.layer.cornerRadius = 4;
        _awayBackView.layer.masksToBounds = true;
    }
    return _awayBackView;
}

- (UIView *)hostTintView {
    if (!_hostTintView) {
        _hostTintView = [[UIView alloc] init];
        _hostTintView.backgroundColor = rgb(143, 0, 255);
        _hostTintView.layer.cornerRadius = 4;
        _hostTintView.layer.masksToBounds = true;
    }
    return _hostTintView;
}

- (UIView *)awayTintView {
    if (!_awayTintView) {
        _awayTintView = [[UIView alloc] init];
        _awayTintView.backgroundColor = rgb(0, 162, 36);
        _awayTintView.layer.cornerRadius = 4;
        _awayTintView.layer.masksToBounds = true;
    }
    return _awayTintView;
}

@end
