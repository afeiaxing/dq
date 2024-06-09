//
//  AXMatchDetailHeaderView.m
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import "AXMatchDetailHeaderView.h"
#import "AXMatchDetailNavigationView.h"

@interface AXMatchDetailHeaderView()

@property (nonatomic ,strong) UIImageView *headerBgView;
@property (nonatomic, strong) UILabel *hostFlag;
@property (nonatomic, strong) UILabel *awayFlag;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIImageView *hostLogo;
@property (nonatomic ,strong) UIImageView *awayLogo;
@property (nonatomic ,strong) UILabel *hostName;
@property (nonatomic ,strong) UILabel *awayName;
@property (nonatomic ,strong) UILabel *scoreLabel;

@end

@implementation AXMatchDetailHeaderView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: public
+ (CGFloat)viewHeight{
    return 204;
}

// MARK: private
- (void)setupSubviews{
    self.backgroundColor = UIColor.blackColor;
    
    [self addSubview:self.headerBgView];
    [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset([AXMatchDetailNavigationView viewHeight]);
//        make.top.offset(0);
    }];
    
    [self.headerBgView addSubview:self.hostFlag];
    [self.hostFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.offset(54);
        make.size.mas_equalTo(CGSizeMake(32, 10));
    }];
    
    [self.headerBgView addSubview:self.awayFlag];
    [self.awayFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.width.height.equalTo(self.hostFlag);
    }];
    
    [self.headerBgView addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hostFlag);
        make.width.height.mas_equalTo(50);
        make.top.equalTo(self.hostFlag.mas_bottom).offset(8);
    }];
    [self.headerBgView addSubview:self.hostName];
    [self.hostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hostLogo.mas_bottom).offset(6);
        make.centerX.equalTo(self.hostLogo);
    }];
    [self.headerBgView addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayFlag);
        make.top.width.height.equalTo(self.hostLogo);
        make.top.equalTo(self.hostFlag.mas_bottom).offset(8);
    }];
    [self.headerBgView addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostName);
        make.centerX.equalTo(self.awayLogo);
    }];
    
    [self.headerBgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(78);
    }];
    
    [self.headerBgView addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerBgView);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
    }];
    
}

// MARK: setter & getter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    if (matchModel.leaguesStatus.intValue == 1) {
        self.timeLabel.text = [NSString axTimestampToDate:matchModel.matchTime format:@"HH:mm"];
    } else if (matchModel.leaguesStatus.intValue == 10) {
        self.timeLabel.text = @"End";
    } else {
        int min = matchModel.residualTime.intValue / 60;
        int second = matchModel.residualTime.intValue % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%@ %d:%d", [AXMatchTools handleMatchStatusText:matchModel.leaguesStatus.intValue], min, second];
    }
    self.hostName.text = matchModel.homeTeamName;
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.awayName.text = matchModel.awayTeamName;
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@ - %@",matchModel.homeTotalScore ?: @"0", matchModel.awayTotalScore ?: @"0"];
    _matchModel = matchModel;
}

- (UIImageView *)headerBgView {
    if (!_headerBgView) {
        _headerBgView = [[UIImageView alloc] init];
        _headerBgView.userInteractionEnabled = true;
        _headerBgView.image = [UIImage imageNamed:@"match_detail_headerbg"];
    }
    return _headerBgView;
}

- (UILabel *)hostFlag{
    if (!_hostFlag) {
        _hostFlag = [UILabel new];
        _hostFlag.text = @"Home";
        _hostFlag.textColor = UIColor.whiteColor;
        _hostFlag.textAlignment = NSTextAlignmentCenter;
        _hostFlag.layer.cornerRadius = 5;
        _hostFlag.layer.borderColor = UIColor.whiteColor.CGColor;
        _hostFlag.layer.borderWidth = 1;
        _hostFlag.font = [UIFont systemFontOfSize:8];
    }
    return _hostFlag;
}

- (UILabel *)awayFlag{
    if (!_awayFlag) {
        _awayFlag = [UILabel new];
        _awayFlag.text = @"Away";
        _awayFlag.textColor = UIColor.whiteColor;
        _awayFlag.textAlignment = NSTextAlignmentCenter;
        _awayFlag.layer.cornerRadius = 5;
        _awayFlag.layer.borderColor = UIColor.whiteColor.CGColor;
        _awayFlag.layer.borderWidth = 1;
        _awayFlag.font = [UIFont systemFontOfSize:8];
    }
    return _awayFlag;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = rgba(255, 255, 255, 0.8);
        _timeLabel.font = [UIFont fontWithName:PingFangSC_Regular size:12];
    }
    return _timeLabel;
}

- (UIImageView *)hostLogo {
    if (!_hostLogo) {
        _hostLogo = [[UIImageView alloc] init];
        _hostLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo {
    if (!_awayLogo) {
        _awayLogo = [[UIImageView alloc] init];
        _awayLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _awayLogo;
}

- (UILabel *)hostName {
    if (!_hostName) {
        _hostName = [[UILabel alloc] init];
        _hostName.textColor = UIColor.whiteColor;
        _hostName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    }
    return _hostName;
}

- (UILabel *)awayName {
    if (!_awayName) {
        _awayName = [[UILabel alloc] init];
        _awayName.textColor = UIColor.whiteColor;
        _awayName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    }
    return _awayName;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.textColor = UIColor.whiteColor;
        _scoreLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:32];
    }
    return _scoreLabel;
}


@end
