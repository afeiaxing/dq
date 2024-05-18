//
//  AXMatchLineupPerformersPlayerView.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchLineupPerformersPlayerView.h"

@interface AXMatchLineupPerformersPlayerView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *hostPlayerLogo;
@property (nonatomic, strong) UILabel *hostPlayerName;
@property (nonatomic, strong) UILabel *hostPlayerNum;
@property (nonatomic, strong) UIImageView *awayPlayerLogo;
@property (nonatomic, strong) UILabel *awayPlayerName;
@property (nonatomic, strong) UILabel *awayPlayerNum;
@property (nonatomic, strong) UILabel *scoreTitle;
@property (nonatomic, strong) UIView *hostScoreView;
@property (nonatomic, strong) UILabel *hostScoreLabel;
@property (nonatomic, strong) UIView *awayScoreView;
@property (nonatomic, strong) UILabel *awayScoreLabel;

@end

@implementation AXMatchLineupPerformersPlayerView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.hostPlayerLogo];
    [self addSubview:self.hostPlayerName];
    [self addSubview:self.hostPlayerNum];
    [self addSubview:self.awayPlayerLogo];
    [self addSubview:self.awayPlayerName];
    [self addSubview:self.awayPlayerNum];
    [self addSubview:self.scoreTitle];
    [self addSubview:self.hostScoreView];
    [self addSubview:self.hostScoreLabel];
    [self addSubview:self.awayScoreView];
    [self addSubview:self.awayScoreLabel];
}

- (void)setupConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.hostPlayerLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.left.equalTo(self.titleLabel.mas_right).offset(20);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.hostPlayerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hostPlayerLogo.mas_bottom).offset(8);
        make.centerX.equalTo(self.hostPlayerLogo);
    }];
    
    [self.hostPlayerNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hostPlayerName.mas_bottom).offset(4);
        make.centerX.equalTo(self.hostPlayerLogo);
    }];
    
    [self.awayPlayerLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-30);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.awayPlayerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostPlayerName);
        make.centerX.equalTo(self.awayPlayerLogo);
    }];
    
    [self.awayPlayerNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostPlayerNum);
        make.centerX.equalTo(self.awayPlayerLogo);
    }];
    
    [self.scoreTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2);
        make.centerX.equalTo(self);
    }];
    
    [self.hostScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreTitle.mas_bottom).offset(5);
        make.centerX.offset(-10);
        make.size.mas_equalTo(CGSizeMake(16, 50));
    }];
    
    [self.hostScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostScoreView);
        make.right.equalTo(self.hostScoreView.mas_left).offset(-3);
    }];
    
    [self.awayScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.hostScoreView);
        make.centerX.offset(10);
        make.size.mas_equalTo(CGSizeMake(16, 30));
    }];
    
    [self.awayScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awayScoreView);
        make.left.equalTo(self.awayScoreView.mas_right).offset(3);
    }];
}

// MARK: setter & getter
- (void)setIndex:(NSInteger)index{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld", index + 1];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = AXSelectColor;
        _titleLabel.backgroundColor = rgb(255, 247, 349);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)hostPlayerLogo {
    if (!_hostPlayerLogo) {
        _hostPlayerLogo = [[UIImageView alloc] init];
        _hostPlayerLogo.backgroundColor = UIColor.blackColor;
    }
    return _hostPlayerLogo;
}

- (UILabel *)hostPlayerName {
    if (!_hostPlayerName) {
        _hostPlayerName = [[UILabel alloc] init];
        _hostPlayerName.font = [UIFont systemFontOfSize:12];
        _hostPlayerName.textColor = rgb(17, 17, 17);
        _hostPlayerName.text = @"Kobe Bryant";
    }
    return _hostPlayerName;
}

- (UILabel *)hostPlayerNum {
    if (!_hostPlayerNum) {
        _hostPlayerNum = [[UILabel alloc] init];
        _hostPlayerNum.font = [UIFont systemFontOfSize:12];
        _hostPlayerNum.textColor = rgb(130, 134, 163);
        _hostPlayerNum.text = @"#24";
    }
    return _hostPlayerNum;
}

- (UIImageView *)awayPlayerLogo {
    if (!_awayPlayerLogo) {
        _awayPlayerLogo = [[UIImageView alloc] init];
        _awayPlayerLogo.backgroundColor = UIColor.blackColor;
    }
    return _awayPlayerLogo;
}

- (UILabel *)awayPlayerName {
    if (!_awayPlayerName) {
        _awayPlayerName = [[UILabel alloc] init];
        _awayPlayerName.font = [UIFont systemFontOfSize:12];
        _awayPlayerName.textColor = rgb(17, 17, 17);
        _awayPlayerName.text = @"Jrue Joliday";
    }
    return _awayPlayerName;
}

- (UILabel *)awayPlayerNum {
    if (!_awayPlayerNum) {
        _awayPlayerNum = [[UILabel alloc] init];
        _awayPlayerNum.font = [UIFont systemFontOfSize:12];
        _awayPlayerNum.textColor = rgb(130, 134, 163);
        _awayPlayerNum.text = @"#30";
    }
    return _awayPlayerNum;
}

- (UILabel *)scoreTitle {
    if (!_scoreTitle) {
        _scoreTitle = [[UILabel alloc] init];
        _scoreTitle.font = [UIFont systemFontOfSize:12];
        _scoreTitle.textColor = rgb(130, 134, 163);
        _scoreTitle.text = @"Score";
    }
    return _scoreTitle;
}

- (UIView *)hostScoreView {
    if (!_hostScoreView) {
        _hostScoreView = [[UIView alloc] init];
        _hostScoreView.backgroundColor = rgb(143, 0, 255);
        _hostScoreView.layer.cornerRadius = 2;
    }
    return _hostScoreView;
}

- (UILabel *)hostScoreLabel {
    if (!_hostScoreLabel) {
        _hostScoreLabel = [[UILabel alloc] init];
        _hostScoreLabel.font = [UIFont systemFontOfSize:12];
        _hostScoreLabel.textColor = [UIColor blackColor];
        _hostScoreLabel.text = @"13";
    }
    return _hostScoreLabel;
}

- (UIView *)awayScoreView {
    if (!_awayScoreView) {
        _awayScoreView = [[UIView alloc] init];
        _awayScoreView.backgroundColor = rgb(0, 162, 36);
        _awayScoreView.layer.cornerRadius = 2;
    }
    return _awayScoreView;
}

- (UILabel *)awayScoreLabel {
    if (!_awayScoreLabel) {
        _awayScoreLabel = [[UILabel alloc] init];
        _awayScoreLabel.font = [UIFont systemFontOfSize:12];
        _awayScoreLabel.textColor = [UIColor blackColor];
        _awayScoreLabel.text = @"9";
    }
    return _awayScoreLabel;
}


@end
