//
//  AXMatchAnalysisTraditionalPerformanceView.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisTraditionalPerformanceView.h"

@interface AXMatchAnalysisTraditionalPerformanceView()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *winLabel;
@property (nonatomic, strong) UILabel *loseLabel;
@property (nonatomic, strong) UILabel *aveLabel;
@property (nonatomic, strong) UILabel *lLabel;
@property (nonatomic, strong) UILabel *moneylineLabel;
@property (nonatomic, strong) UILabel *ouLabel;

@end

@implementation AXMatchAnalysisTraditionalPerformanceView

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
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.bottom.offset(0);
    }];
    
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(22);
    }];
    
    [self.containerView addSubview:self.winLabel];
    [self.winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.width.mas_equalTo(187);
        make.height.mas_equalTo(30);
    }];
    
    [self.containerView addSubview:self.loseLabel];
    [self.loseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.centerY.height.equalTo(self.winLabel);
        make.left.equalTo(self.winLabel.mas_right).offset(5);
    }];
    
    [self.containerView addSubview:self.aveLabel];
    [self.containerView addSubview:self.lLabel];
    [self.containerView addSubview:self.moneylineLabel];
    [self.containerView addSubview:self.ouLabel];
    NSArray *labels = @[self.aveLabel, self.lLabel, self.moneylineLabel, _ouLabel];
    [labels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:20 tailSpacing:20];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.winLabel.mas_bottom).offset(29);
    }];
}

// MARK: setter & getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.layer.cornerRadius = 8;
        _containerView.layer.borderColor = rgb(234, 241, 245).CGColor;
        _containerView.layer.borderWidth = 1;
    }
    return _containerView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"HOME-led performance from the last 6 matches";
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UILabel *)winLabel{
    if (!_winLabel) {
        _winLabel = [UILabel new];
        _winLabel.backgroundColor = rgb(29, 209, 0);
        _winLabel.text = @"4 Win";
        _winLabel.textColor = UIColor.whiteColor;
        _winLabel.textAlignment = NSTextAlignmentCenter;
        _winLabel.layer.cornerRadius = 8;
        _winLabel.layer.masksToBounds = true;
    }
    return _winLabel;
}

- (UILabel *)loseLabel{
    if (!_loseLabel) {
        _loseLabel = [UILabel new];
        _loseLabel.backgroundColor = rgb(209, 0, 0);
        _loseLabel.text = @"2 Lose";
        _loseLabel.textColor = UIColor.whiteColor;
        _loseLabel.textAlignment = NSTextAlignmentCenter;
        _loseLabel.layer.cornerRadius = 8;
        _loseLabel.layer.masksToBounds = true;
    }
    return _loseLabel;
}

- (UILabel *)aveLabel{
    if (!_aveLabel) {
        _aveLabel = [UILabel new];
        _aveLabel.numberOfLines = 10;
        _aveLabel.font = [UIFont systemFontOfSize:12];
        _aveLabel.textAlignment = NSTextAlignmentCenter;
        _aveLabel.text = @"AVE \n\n 99.5 \n\n points";
    }
    return _aveLabel;
}

- (UILabel *)lLabel{
    if (!_lLabel) {
        _lLabel = [UILabel new];
        _lLabel.numberOfLines = 10;
        _lLabel.font = [UIFont systemFontOfSize:12];
        _lLabel.textAlignment = NSTextAlignmentCenter;
        _lLabel.text = @"L \n\n 122.5 \n\n points";
    }
    return _lLabel;
}

- (UILabel *)moneylineLabel{
    if (!_moneylineLabel) {
        _moneylineLabel = [UILabel new];
        _moneylineLabel.numberOfLines = 10;
        _moneylineLabel.font = [UIFont systemFontOfSize:12];
        _moneylineLabel.textAlignment = NSTextAlignmentCenter;
        _moneylineLabel.text = @"Moneyline \n\n 50.3% \n\n home win";
    }
    return _moneylineLabel;
}

- (UILabel *)ouLabel{
    if (!_ouLabel) {
        _ouLabel = [UILabel new];
        _ouLabel.numberOfLines = 10;
        _ouLabel.font = [UIFont systemFontOfSize:12];
        _ouLabel.textAlignment = NSTextAlignmentCenter;
        _ouLabel.text = @"O/U \n\n 14.2% \n\n Over";
    }
    return _ouLabel;
}

@end
