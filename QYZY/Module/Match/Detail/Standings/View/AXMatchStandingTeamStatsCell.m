//
//  AXMatchStandingTeamStatsCell.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchStandingTeamStatsCell.h"

@interface AXMatchStandingTeamStatsCell()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *statsTitleLabel;
@property (nonatomic, strong) UILabel *point3TitleLabel;
@property (nonatomic, strong) UILabel *point2TitleLabel;
@property (nonatomic, strong) UILabel *freeThrowTitleLabel;
@property (nonatomic, strong) UILabel *freeThrowPercentTitleLabel;
@property (nonatomic, strong) UILabel *hostPoint3Label;
@property (nonatomic, strong) UILabel *hostPoint2Label;
@property (nonatomic, strong) UILabel *hostFreeThrowLabel;
@property (nonatomic, strong) UILabel *hostFreeThrowPercentLabel;
@property (nonatomic, strong) UILabel *awayPoint3Label;
@property (nonatomic, strong) UILabel *awayPoint2Label;
@property (nonatomic, strong) UILabel *awayFreeThrowLabel;
@property (nonatomic, strong) UILabel *awayFreeThrowPercentLabel;

@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;

@property (nonatomic, strong) UILabel *hostFoulsTitle;
@property (nonatomic, strong) UILabel *hostFouls;
@property (nonatomic, strong) UILabel *awayFoulsTitle;
@property (nonatomic, strong) UILabel *awayFouls;
@property (nonatomic, strong) UILabel *hostTimeoutTitle;
@property (nonatomic, strong) UILabel *hostTimeout;
@property (nonatomic, strong) UILabel *awayTimeoutTitle;
@property (nonatomic, strong) UILabel *awayTimeout;

@property (nonatomic, strong) UIView *point3BackView;
@property (nonatomic, strong) UIView *point3TintView;
@property (nonatomic, strong) UIView *point2BackView;
@property (nonatomic, strong) UIView *point2TintView;
@property (nonatomic, strong) UIView *freeThrowBackView;
@property (nonatomic, strong) UIView *freeThrowTintView;
@property (nonatomic, strong) UIView *freeThrowPercentBackView;
@property (nonatomic, strong) UIView *freeThrowPercentTintView;

@end

#define kAXMatchStandingTeamStatsTitleWidth 90
#define kAXMatchStandingTeamStatsValueWidth 30

@implementation AXMatchStandingTeamStatsCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubviews];
    }
    return self;
}

// MARK: private
- (void)setupSubviews{
    self.contentView.backgroundColor = rgb(247, 247, 247);
    
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.containerView addSubview:self.statsTitleLabel];
    [self.statsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(34);
    }];
    
    [self.containerView addSubview:self.point3TitleLabel];
    [self.point3TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.statsTitleLabel.mas_bottom).offset(47);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsTitleWidth);
    }];
    
    [self.containerView addSubview:self.point2TitleLabel];
    [self.point2TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.point3TitleLabel.mas_bottom).offset(36);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsTitleWidth);
    }];
    
    [self.containerView addSubview:self.freeThrowTitleLabel];
    [self.freeThrowTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.point2TitleLabel.mas_bottom).offset(36);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsTitleWidth);
    }];
    
    [self.containerView addSubview:self.freeThrowPercentTitleLabel];
    [self.freeThrowPercentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.freeThrowTitleLabel.mas_bottom).offset(36);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsTitleWidth);
    }];
    
    [self.containerView addSubview:self.hostPoint3Label];
    [self.hostPoint3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.point3TitleLabel).offset(0);
        make.right.equalTo(self.point3TitleLabel.mas_left).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.hostPoint2Label];
    [self.hostPoint2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.point2TitleLabel).offset(0);
        make.right.equalTo(self.point2TitleLabel.mas_left).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.hostFreeThrowLabel];
    [self.hostFreeThrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.freeThrowTitleLabel).offset(0);
        make.right.equalTo(self.freeThrowTitleLabel.mas_left).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.hostFreeThrowPercentLabel];
    [self.hostFreeThrowPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.freeThrowPercentTitleLabel).offset(0);
        make.right.equalTo(self.freeThrowPercentTitleLabel.mas_left).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.awayPoint3Label];
    [self.awayPoint3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.point3TitleLabel).offset(0);
        make.left.equalTo(self.point3TitleLabel.mas_right).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.awayPoint2Label];
    [self.awayPoint2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.point2TitleLabel).offset(0);
        make.left.equalTo(self.point2TitleLabel.mas_right).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.awayFreeThrowLabel];
    [self.awayFreeThrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.freeThrowTitleLabel).offset(0);
        make.left.equalTo(self.freeThrowTitleLabel.mas_right).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.awayFreeThrowPercentLabel];
    [self.awayFreeThrowPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.freeThrowPercentTitleLabel).offset(0);
        make.left.equalTo(self.freeThrowPercentTitleLabel.mas_right).offset(0);
        make.width.mas_equalTo(kAXMatchStandingTeamStatsValueWidth);
    }];
    
    [self.containerView addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.left.offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.containerView addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.hostLogo);
        make.right.offset(-20);
    }];
    
    [self.containerView addSubview:self.hostName];
    [self.hostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hostLogo);
        make.top.equalTo(self.hostLogo.mas_bottom).offset(10);
        make.width.mas_equalTo(60);
    }];

    [self.containerView addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayLogo);
        make.centerY.equalTo(self.hostName);
        make.width.equalTo(self.hostName);
    }];
    
    [self.containerView addSubview:self.hostFoulsTitle];
    [self.hostFoulsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hostLogo);
        make.top.equalTo(self.hostName.mas_bottom).offset(54);
    }];
    
    [self.containerView addSubview:self.awayFoulsTitle];
    [self.awayFoulsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayLogo);
        make.centerY.equalTo(self.hostFoulsTitle);
    }];
    
    [self.containerView addSubview:self.hostFouls];
    [self.hostFouls mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hostLogo);
        make.top.equalTo(self.hostFoulsTitle.mas_bottom).offset(5);
    }];
    
    [self.containerView addSubview:self.awayFouls];
    [self.awayFouls mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayLogo);
        make.centerY.equalTo(self.hostFouls);
    }];
    
    [self.containerView addSubview:self.hostTimeoutTitle];
    [self.hostTimeoutTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hostLogo);
        make.top.equalTo(self.hostFouls.mas_bottom).offset(13);
    }];
    
    [self.containerView addSubview:self.awayTimeoutTitle];
    [self.awayTimeoutTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayLogo);
        make.centerY.equalTo(self.hostTimeoutTitle);
    }];
    
    [self.containerView addSubview:self.hostTimeout];
    [self.hostTimeout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hostLogo);
        make.top.equalTo(self.hostTimeoutTitle.mas_bottom).offset(5);
    }];
    
    [self.containerView addSubview:self.awayTimeout];
    [self.awayTimeout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayLogo);
        make.centerY.equalTo(self.hostTimeout);
    }];
    
    [self.contentView addSubview:self.point3BackView];
    [self.point3BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostPoint3Label);
        make.right.equalTo(self.awayPoint3Label);
        make.height.mas_equalTo(8);
        make.top.equalTo(self.point3TitleLabel.mas_bottom).offset(4);
    }];
        
    [self.contentView addSubview:self.point3TintView];
    [self.point3TintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.height.equalTo(self.point3BackView);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.point2BackView];
    [self.point2BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.point3BackView);
        make.top.equalTo(self.point2TitleLabel.mas_bottom).offset(4);
    }];
    
    [self.contentView addSubview:self.point2TintView];
    [self.point2TintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.height.equalTo(self.point2BackView);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.freeThrowBackView];
    [self.freeThrowBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.point3BackView);
        make.top.equalTo(self.freeThrowTitleLabel.mas_bottom).offset(4);
    }];
    
    [self.contentView addSubview:self.freeThrowTintView];
    [self.freeThrowTintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.height.equalTo(self.freeThrowBackView);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.freeThrowPercentBackView];
    [self.freeThrowPercentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.point3BackView);
        make.top.equalTo(self.freeThrowPercentTitleLabel.mas_bottom).offset(4);
    }];
    
    [self.contentView addSubview:self.freeThrowPercentTintView];
    [self.freeThrowPercentTintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.height.equalTo(self.freeThrowPercentBackView);
        make.width.mas_equalTo(100);
    }];
}

// MARK: setter & setter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostName.text = matchModel.homeTeamName;
    self.awayName.text = matchModel.awayTeamName;
    _matchModel = matchModel;
}

- (void)setStandingModel:(AXMatchStandingModel *)standingModel{
    if (!standingModel) {return;}
    
    _standingModel = standingModel;
    self.hostFouls.text = standingModel.hostTeamStats.currentFouls;
    self.awayFouls.text = standingModel.awayTeamStats.currentFouls;
    self.hostTimeout.text = standingModel.hostTeamStats.timeouts;
    self.awayTimeout.text = standingModel.awayTeamStats.timeouts;
    
    self.hostPoint3Label.text = standingModel.hostTeamStats.threePoints;
    self.awayPoint3Label.text = standingModel.awayTeamStats.threePoints;
    self.hostPoint2Label.text = standingModel.hostTeamStats.twoPoints;
    self.awayPoint2Label.text = standingModel.awayTeamStats.twoPoints;
    self.hostFreeThrowLabel.text = standingModel.hostTeamStats.freeThrow;
    self.awayFreeThrowLabel.text = standingModel.awayTeamStats.freeThrow;
    self.hostFreeThrowPercentLabel.text = standingModel.hostTeamStats.freeThrowAccuracy;
    self.awayFreeThrowPercentLabel.text = standingModel.awayTeamStats.freeThrowAccuracy;
    
    CGFloat backViewW = self.point3BackView.bounds.size.width;

    // 3-point
    [self handleTintViewLayoutWithHostValue:standingModel.hostTeamStats.threePoints awayValue:standingModel.awayTeamStats.threePoints backView:self.point3BackView tintView:self.point3TintView backViewWidth:backViewW];
    
    // 2-point
    [self handleTintViewLayoutWithHostValue:standingModel.hostTeamStats.twoPoints awayValue:standingModel.awayTeamStats.twoPoints backView:self.point2BackView tintView:self.point2TintView backViewWidth:backViewW];
    
    // free throw
    [self handleTintViewLayoutWithHostValue:standingModel.hostTeamStats.freeThrow awayValue:standingModel.awayTeamStats.freeThrow backView:self.freeThrowBackView tintView:self.freeThrowTintView backViewWidth:backViewW];
    
    // free throw %
    [self handleTintViewLayoutWithHostValue:standingModel.hostTeamStats.freeThrowAccuracy awayValue:standingModel.awayTeamStats.freeThrowAccuracy backView:self.freeThrowPercentBackView tintView:self.freeThrowPercentTintView backViewWidth:backViewW];
}

- (void)handleTintViewLayoutWithHostValue: (NSString *)hostValue
                                awayValue: (NSString *)awayValue
                                 backView: (UIView *)backView
                                 tintView: (UIView *)tintView
                            backViewWidth: (CGFloat)backViewWidth{
    CGFloat point3Total = hostValue.intValue + awayValue.intValue;
    CGFloat point3Precent;
    BOOL isAlignLeft;
    CGFloat leftMargin;
    CGFloat tintViewW;
    if (hostValue.floatValue > awayValue.floatValue) {
        isAlignLeft = true;
        point3Precent = hostValue.intValue / point3Total;
        tintViewW = backViewWidth * point3Precent;
        leftMargin = 0;
    } else {
        isAlignLeft = false;
        point3Precent = awayValue.intValue / point3Total;
        tintViewW = backViewWidth * point3Precent;
        leftMargin = (1 - point3Precent) * backViewWidth;
    }
    
    // 兼容服务器返回异常数据，例如“-”，会导致算出的数值为“NaN”
    if (isnan(leftMargin)) {
        leftMargin = 0.01;
    }
    if (isnan(tintViewW)) {
        tintViewW = 0.01;
    }

    [tintView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(leftMargin);
        make.width.mas_equalTo(tintViewW);
    }];
}


- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;
}

- (UILabel *)statsTitleLabel {
    if (!_statsTitleLabel) {
        _statsTitleLabel = [[UILabel alloc] init];
        _statsTitleLabel.font = AX_PingFangMedium_Font(16);
        _statsTitleLabel.textColor = rgb(17, 17, 17);
        _statsTitleLabel.text = @"Team Stats";
    }
    return _statsTitleLabel;
}

- (UILabel *)point3TitleLabel {
    if (!_point3TitleLabel) {
        _point3TitleLabel = [[UILabel alloc] init];
        _point3TitleLabel.font = [UIFont systemFontOfSize:12];
        _point3TitleLabel.textColor = rgb(153, 153, 153);
        _point3TitleLabel.text = @"3-Point";
        _point3TitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _point3TitleLabel;
}

- (UILabel *)point2TitleLabel {
    if (!_point2TitleLabel) {
        _point2TitleLabel = [[UILabel alloc] init];
        _point2TitleLabel.font = [UIFont systemFontOfSize:12];
        _point2TitleLabel.textColor = rgb(153, 153, 153);
        _point2TitleLabel.text = @"2-Point";
        _point2TitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _point2TitleLabel;
}

- (UILabel *)freeThrowTitleLabel {
    if (!_freeThrowTitleLabel) {
        _freeThrowTitleLabel = [[UILabel alloc] init];
        _freeThrowTitleLabel.font = [UIFont systemFontOfSize:12];
        _freeThrowTitleLabel.textColor = rgb(153, 153, 153);
        _freeThrowTitleLabel.text = @"Free Throw";
        _freeThrowTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _freeThrowTitleLabel;
}

- (UILabel *)freeThrowPercentTitleLabel {
    if (!_freeThrowPercentTitleLabel) {
        _freeThrowPercentTitleLabel = [[UILabel alloc] init];
        _freeThrowPercentTitleLabel.font = [UIFont systemFontOfSize:12];
        _freeThrowPercentTitleLabel.textColor = rgb(153, 153, 153);
        _freeThrowPercentTitleLabel.text = @"Free Throw %";
        _freeThrowPercentTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _freeThrowPercentTitleLabel;
}

- (UILabel *)hostPoint3Label {
    if (!_hostPoint3Label) {
        _hostPoint3Label = [[UILabel alloc] init];
        _hostPoint3Label.font = [UIFont systemFontOfSize:12];
        _hostPoint3Label.textColor = rgb(17, 17, 17);
    }
    return _hostPoint3Label;
}

- (UILabel *)hostPoint2Label {
    if (!_hostPoint2Label) {
        _hostPoint2Label = [[UILabel alloc] init];
        _hostPoint2Label.font = [UIFont systemFontOfSize:12];
        _hostPoint2Label.textColor = rgb(17, 17, 17);
    }
    return _hostPoint2Label;
}

- (UILabel *)hostFreeThrowLabel {
    if (!_hostFreeThrowLabel) {
        _hostFreeThrowLabel = [[UILabel alloc] init];
        _hostFreeThrowLabel.font = [UIFont systemFontOfSize:12];
        _hostFreeThrowLabel.textColor = rgb(17, 17, 17);
    }
    return _hostFreeThrowLabel;
}

- (UILabel *)hostFreeThrowPercentLabel {
    if (!_hostFreeThrowPercentLabel) {
        _hostFreeThrowPercentLabel = [[UILabel alloc] init];
        _hostFreeThrowPercentLabel.font = [UIFont systemFontOfSize:12];
        _hostFreeThrowPercentLabel.textColor = rgb(17, 17, 17);
    }
    return _hostFreeThrowPercentLabel;
}

- (UILabel *)awayPoint3Label {
    if (!_awayPoint3Label) {
        _awayPoint3Label = [[UILabel alloc] init];
        _awayPoint3Label.font = [UIFont systemFontOfSize:12];
        _awayPoint3Label.textColor = rgb(17, 17, 17);
        _awayPoint3Label.textAlignment = NSTextAlignmentRight;
    }
    return _awayPoint3Label;
}

- (UILabel *)awayPoint2Label {
    if (!_awayPoint2Label) {
        _awayPoint2Label = [[UILabel alloc] init];
        _awayPoint2Label.font = [UIFont systemFontOfSize:12];
        _awayPoint2Label.textColor = rgb(17, 17, 17);
        _awayPoint2Label.textAlignment = NSTextAlignmentRight;
    }
    return _awayPoint2Label;
}

- (UILabel *)awayFreeThrowLabel {
    if (!_awayFreeThrowLabel) {
        _awayFreeThrowLabel = [[UILabel alloc] init];
        _awayFreeThrowLabel.font = [UIFont systemFontOfSize:12];
        _awayFreeThrowLabel.textColor = rgb(17, 17, 17);
        _awayFreeThrowLabel.textAlignment = NSTextAlignmentRight;
    }
    return _awayFreeThrowLabel;
}

- (UILabel *)awayFreeThrowPercentLabel {
    if (!_awayFreeThrowPercentLabel) {
        _awayFreeThrowPercentLabel = [[UILabel alloc] init];
        _awayFreeThrowPercentLabel.font = [UIFont systemFontOfSize:12];
        _awayFreeThrowPercentLabel.textColor = rgb(17, 17, 17);
        _awayFreeThrowPercentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _awayFreeThrowPercentLabel;
}

- (UIImageView *)hostLogo{
    if (!_hostLogo) {
        _hostLogo = [UIImageView new];
        _hostLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo{
    if (!_awayLogo) {
        _awayLogo = [UIImageView new];
        _awayLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _awayLogo;
}

- (UILabel *)hostName {
    if (!_hostName) {
        _hostName = [[UILabel alloc] init];
        _hostName.font = AX_PingFangMedium_Font(14);
        _hostName.textAlignment = NSTextAlignmentCenter;
        _hostName.textColor = rgb(17, 17, 17);
    }
    return _hostName;
}

- (UILabel *)awayName {
    if (!_awayName) {
        _awayName = [[UILabel alloc] init];
        _awayName.font = AX_PingFangMedium_Font(14);
        _awayName.textAlignment = NSTextAlignmentCenter;
        _awayName.textColor = rgb(17, 17, 17);
    }
    return _awayName;
}

- (UILabel *)hostFoulsTitle {
    if (!_hostFoulsTitle) {
        _hostFoulsTitle = [[UILabel alloc] init];
        _hostFoulsTitle.font = [UIFont systemFontOfSize:12];
        _hostFoulsTitle.textColor = rgb(153, 153, 153);
        _hostFoulsTitle.text = @"Current fouls";
    }
    return _hostFoulsTitle;
}

- (UILabel *)hostFouls {
    if (!_hostFouls) {
        _hostFouls = [[UILabel alloc] init];
        _hostFouls.font = AX_PingFangSemibold_Font(16);
        _hostFouls.textColor = rgb(17, 17, 17);
    }
    return _hostFouls;
}

- (UILabel *)awayFoulsTitle {
    if (!_awayFoulsTitle) {
        _awayFoulsTitle = [[UILabel alloc] init];
        _awayFoulsTitle.font = [UIFont systemFontOfSize:12];
        _awayFoulsTitle.textColor = rgb(153, 153, 153);
        _awayFoulsTitle.text = @"Current fouls";
    }
    return _awayFoulsTitle;
}

- (UILabel *)awayFouls {
    if (!_awayFouls) {
        _awayFouls = [[UILabel alloc] init];
        _awayFouls.font = AX_PingFangSemibold_Font(16);
        _awayFouls.textColor = rgb(17, 17, 17);
    }
    return _awayFouls;
}

- (UILabel *)hostTimeoutTitle {
    if (!_hostTimeoutTitle) {
        _hostTimeoutTitle = [[UILabel alloc] init];
        _hostTimeoutTitle.font = [UIFont systemFontOfSize:12];
        _hostTimeoutTitle.textColor = rgb(153, 153, 153);
        _hostTimeoutTitle.text = @"Timeout";
    }
    return _hostTimeoutTitle;
}

- (UILabel *)hostTimeout {
    if (!_hostTimeout) {
        _hostTimeout = [[UILabel alloc] init];
        _hostTimeout.font = AX_PingFangSemibold_Font(16);
        _hostTimeout.textColor = rgb(17, 17, 17);
    }
    return _hostTimeout;
}

- (UILabel *)awayTimeoutTitle {
    if (!_awayTimeoutTitle) {
        _awayTimeoutTitle = [[UILabel alloc] init];
        _awayTimeoutTitle.font = [UIFont systemFontOfSize:12];
        _awayTimeoutTitle.textColor = rgb(153, 153, 153);
        _awayTimeoutTitle.text = @"Timeout";
    }
    return _awayTimeoutTitle;
}

- (UILabel *)awayTimeout {
    if (!_awayTimeout) {
        _awayTimeout = [[UILabel alloc] init];
        _awayTimeout.font = AX_PingFangSemibold_Font(16);
        _awayTimeout.textColor = rgb(17, 17, 17);
    }
    return _awayTimeout;
}

- (UIView *)point3BackView {
    if (!_point3BackView) {
        _point3BackView = [[UIView alloc] init];
        _point3BackView.backgroundColor = rgb(255, 247, 239);
        _point3BackView.layer.cornerRadius = 4;
    }
    return _point3BackView;
}

- (UIView *)point3TintView {
    if (!_point3TintView) {
        _point3TintView = [[UIView alloc] init];
        _point3TintView.backgroundColor = AXSelectColor;
        _point3TintView.layer.cornerRadius = 4;
    }
    return _point3TintView;
}

- (UIView *)point2BackView {
    if (!_point2BackView) {
        _point2BackView = [[UIView alloc] init];
        _point2BackView.backgroundColor = rgb(255, 247, 239);
        _point2BackView.layer.cornerRadius = 4;
    }
    return _point2BackView;
}

- (UIView *)point2TintView {
    if (!_point2TintView) {
        _point2TintView = [[UIView alloc] init];
        _point2TintView.backgroundColor = AXSelectColor;
        _point2TintView.layer.cornerRadius = 4;
    }
    return _point2TintView;
}

- (UIView *)freeThrowBackView {
    if (!_freeThrowBackView) {
        _freeThrowBackView = [[UIView alloc] init];
        _freeThrowBackView.backgroundColor = rgb(255, 247, 239);
        _freeThrowBackView.layer.cornerRadius = 4;
    }
    return _freeThrowBackView;
}

- (UIView *)freeThrowTintView {
    if (!_freeThrowTintView) {
        _freeThrowTintView = [[UIView alloc] init];
        _freeThrowTintView.backgroundColor = AXSelectColor;
        _freeThrowTintView.layer.cornerRadius = 4;
    }
    return _freeThrowTintView;
}

- (UIView *)freeThrowPercentBackView {
    if (!_freeThrowPercentBackView) {
        _freeThrowPercentBackView = [[UIView alloc] init];
        _freeThrowPercentBackView.backgroundColor = rgb(255, 247, 239);
        _freeThrowPercentBackView.layer.cornerRadius = 4;
    }
    return _freeThrowPercentBackView;
}

- (UIView *)freeThrowPercentTintView {
    if (!_freeThrowPercentTintView) {
        _freeThrowPercentTintView = [[UIView alloc] init];
        _freeThrowPercentTintView.backgroundColor = AXSelectColor;
        _freeThrowPercentTintView.layer.cornerRadius = 4;
    }
    return _freeThrowPercentTintView;
}

@end
