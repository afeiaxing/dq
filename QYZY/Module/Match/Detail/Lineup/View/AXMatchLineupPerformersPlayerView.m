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

#define AXMatchLineupPerformersPlayerViewBaseHeight 50

@implementation AXMatchLineupPerformersPlayerView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

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
        make.bottom.equalTo(self.hostPlayerName).offset(-10);
        make.centerX.offset(-10);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(4);
    }];
    
    [self.hostScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostScoreView);
        make.right.equalTo(self.hostScoreView.mas_left).offset(-3);
    }];
    
    [self.awayScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.hostPlayerName).offset(-10);
        make.centerX.offset(10);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(4);
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

- (void)setHostModel:(AXMatchLineupTopPerformerModel *)hostModel{
    if (!hostModel) {return;}
    [self.hostPlayerLogo sd_setImageWithURL:[NSURL URLWithString:hostModel.playerLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostPlayerName.text = hostModel.playerName;
    self.hostPlayerNum.text = [NSString stringWithFormat:@"#%@", hostModel.shirtNumber];
    self.hostScoreLabel.text = hostModel.score;
    _hostModel = hostModel;
}

- (void)setAwayModel:(AXMatchLineupTopPerformerModel *)awayModel{
    if (!awayModel) {return;}
    [self.awayPlayerLogo sd_setImageWithURL:[NSURL URLWithString:awayModel.playerLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.awayPlayerName.text = awayModel.playerName;
    self.awayPlayerNum.text = [NSString stringWithFormat:@"#%@", awayModel.shirtNumber];
    self.awayScoreLabel.text = awayModel.score;
    
    // 设置柱状图高度
    if (self.hostModel.score.floatValue > awayModel.score.floatValue) {
        [self.hostScoreView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(AXMatchLineupPerformersPlayerViewBaseHeight);
        }];
        CGFloat precent = awayModel.score.floatValue / self.hostModel.score.floatValue;
        [self.awayScoreView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(AXMatchLineupPerformersPlayerViewBaseHeight * precent);
        }];
    } else {
        CGFloat precent = self.hostModel.score.floatValue / awayModel.score.floatValue;
        [self.hostScoreView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(AXMatchLineupPerformersPlayerViewBaseHeight * precent);
        }];
        [self.awayScoreView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(AXMatchLineupPerformersPlayerViewBaseHeight);
        }];
    }
    
    _awayModel = awayModel;
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
        _hostPlayerLogo.contentMode = UIViewContentModeScaleAspectFit;
        _hostPlayerLogo.image = AXTeamPlaceholderLogo;
    }
    return _hostPlayerLogo;
}

- (UILabel *)hostPlayerName {
    if (!_hostPlayerName) {
        _hostPlayerName = [[UILabel alloc] init];
        _hostPlayerName.font = AX_PingFangMedium_Font(12);
        _hostPlayerName.textColor = rgb(17, 17, 17);
    }
    return _hostPlayerName;
}

- (UILabel *)hostPlayerNum {
    if (!_hostPlayerNum) {
        _hostPlayerNum = [[UILabel alloc] init];
        _hostPlayerNum.font = [UIFont systemFontOfSize:12];
        _hostPlayerNum.textColor = AXUnSelectColor;
        _hostPlayerNum.text = @"#";
    }
    return _hostPlayerNum;
}

- (UIImageView *)awayPlayerLogo {
    if (!_awayPlayerLogo) {
        _awayPlayerLogo = [[UIImageView alloc] init];
        _awayPlayerLogo.contentMode = UIViewContentModeScaleAspectFit;
        _awayPlayerLogo.image = AXTeamPlaceholderLogo;
    }
    return _awayPlayerLogo;
}

- (UILabel *)awayPlayerName {
    if (!_awayPlayerName) {
        _awayPlayerName = [[UILabel alloc] init];
        _awayPlayerName.font = AX_PingFangMedium_Font(12);
        _awayPlayerName.textColor = rgb(17, 17, 17);
    }
    return _awayPlayerName;
}

- (UILabel *)awayPlayerNum {
    if (!_awayPlayerNum) {
        _awayPlayerNum = [[UILabel alloc] init];
        _awayPlayerNum.font = [UIFont systemFontOfSize:12];
        _awayPlayerNum.textColor = AXUnSelectColor;
        _awayPlayerNum.text = @"#";
    }
    return _awayPlayerNum;
}

- (UILabel *)scoreTitle {
    if (!_scoreTitle) {
        _scoreTitle = [[UILabel alloc] init];
        _scoreTitle.font = [UIFont systemFontOfSize:12];
        _scoreTitle.textColor = AXUnSelectColor;
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
    }
    return _awayScoreLabel;
}


@end
