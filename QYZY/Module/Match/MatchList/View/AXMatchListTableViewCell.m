//
//  AXMatchListTableViewCell.m
//  QYZY
//
//  Created by 22 on 2024/5/15.
//

#import "AXMatchListTableViewCell.h"
#import "AXMatchListScoreCustomView.h"

@interface AXMatchListTableViewCell()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *leagueLogo;
@property (nonatomic, strong) UILabel *leagueName;
@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) UIView *lineH;

@property (nonatomic, strong) UILabel *hostRank;
@property (nonatomic, strong) UILabel *awayRank;
@property (nonatomic, strong) UILabel *hostLiveFlag;
@property (nonatomic, strong) UILabel *awayLiveFlag;
@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;
@property (nonatomic, strong) UILabel *matchTime;
@property (nonatomic, strong) UILabel *matchState;

@property (nonatomic, strong) UILabel *hostScoreChangeLabel;
@property (nonatomic, strong) UILabel *awayScoreChangeLabel;

@property (nonatomic, strong) UILabel *handicap;
@property (nonatomic, strong) UIButton *apLogoBtn;
@property (nonatomic, strong) NSArray *scoreViews;

@end

#define kAXMatchListScoreViewLeftMargin 182
#define kAXMatchListScoreViewRightMargin 17

@implementation AXMatchListTableViewCell

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
    self.contentView.backgroundColor = rgb(234, 241, 245);
    
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.containerView addSubview:self.leagueLogo];
    [self.leagueLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.left.offset(12);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.containerView addSubview:self.leagueName];
    [self.leagueName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leagueLogo);
        make.left.equalTo(self.leagueLogo.mas_right).offset(4);
    }];
    
    [self.containerView addSubview:self.lineH];
    [self.lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.equalTo(self.leagueLogo.mas_bottom).offset(8);
        make.height.mas_equalTo(1);
    }];
    
    [self.containerView addSubview:self.hostRank];
    [self.hostRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.equalTo(self.lineH.mas_bottom).offset(18);
        make.width.mas_equalTo(23);
    }];
    
    [self.containerView addSubview:self.hostLiveFlag];
    [self.hostLiveFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(6);
        make.top.equalTo(self.lineH.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(26, 22));
    }];
    
    [self.containerView addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(35);
        make.top.equalTo(self.lineH.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.containerView addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.hostLogo);
        make.top.equalTo(self.hostLogo.mas_bottom).offset(12);
    }];
    
    [self.containerView addSubview:self.hostName];
    [self.hostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostLogo);
        make.left.equalTo(self.hostLogo.mas_right).offset(8);
        make.width.mas_equalTo(72);
    }];
    
    [self.containerView addSubview:self.awayRank];
    [self.awayRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostRank);
        make.centerY.equalTo(self.awayLogo);
        make.width.equalTo(self.hostRank);
    }];
    
    [self.containerView addSubview:self.awayLiveFlag];
    [self.awayLiveFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.hostLiveFlag);
        make.centerY.equalTo(self.awayLogo);
    }];
    
    [self.containerView addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awayLogo);
        make.left.width.equalTo(self.hostName);
    }];
    
    [self.containerView addSubview:self.matchTime];
    [self.matchTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(self.awayLogo.mas_bottom).offset(10);
    }];

    [self.containerView addSubview:self.matchState];
    [self.matchState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.matchTime.mas_right).offset(5);
        make.centerY.equalTo(self.matchTime);
        make.size.mas_equalTo(CGSizeMake(64, 18));
    }];

    UIView *lineV = [UIView new];
    lineV.backgroundColor = rgb(231, 232, 241);
    [self.containerView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(141);
        make.top.equalTo(self.lineH.mas_bottom).offset(22);
        make.size.mas_equalTo(CGSizeMake(1, 45));
    }];

    [self.containerView addSubview:self.handicap];
    [self.handicap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV.mas_right).offset(13);
        make.centerY.equalTo(self.hostLogo);
    }];
    
    [self.containerView addSubview:self.apLogoBtn];
    [self.apLogoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.bottom.offset(-7);
        make.size.mas_equalTo(CGSizeMake(218, 28));
    }];
    
    CGFloat lastViewPosX = 0;
    int scoreViewCount = 6; // q1,q2,q3,q4,ot,tot，最多6个
    CGFloat scoreViewW = (ScreenWidth - kAXMatchListScoreViewLeftMargin - kAXMatchListScoreViewRightMargin) / scoreViewCount;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < scoreViewCount; i++) {
        AXMatchListScoreCustomView *view = [[AXMatchListScoreCustomView alloc] initWithHostscoreTopMargin:0 isNeedScoreSize: true];
        view.viewType = (AXMatchListScoreCustomViewType)i;
        [self.containerView addSubview:view];
        [temp addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kAXMatchListScoreViewLeftMargin + scoreViewW * i);
            make.width.mas_equalTo(scoreViewW);
            make.height.mas_equalTo(65);
            make.top.equalTo(self.lineH.mas_bottom).offset(6);
        }];
        
        if (i == scoreViewCount - 1) {
            lastViewPosX = kAXMatchListScoreViewLeftMargin + scoreViewW * i;
        }
    }
    self.scoreViews = temp.copy;
    
    [self.containerView addSubview:self.hostScoreChangeLabel];
    [self.hostScoreChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(lastViewPosX + scoreViewW - 20);
        make.top.equalTo(self.lineH.mas_bottom).offset(13);
    }];
    
    [self.containerView addSubview:self.awayScoreChangeLabel];
    [self.awayScoreChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostScoreChangeLabel);
        make.top.equalTo(self.hostScoreChangeLabel.mas_bottom).offset(13);
    }];
}

- (void)handleLabelHidden: (NSArray <UILabel *>*)labels hide: (BOOL)hide{
    for (UILabel *label in labels) {
        label.hidden = hide;
    }
}

- (void)handleLabelText:(NSArray <UILabel *>*)labels text: (NSString *)text{
    for (UILabel *label in labels) {
        label.text = text;
    }
}

// MARK: setter & getter
- (void)setModel:(AXMatchListItemModel *)model{
    [self.leagueLogo sd_setImageWithURL:[NSURL URLWithString:model.leaguesLogo] placeholderImage:AXLeaguePlaceholderLogo];
    self.leagueName.text = model.leaguesName;
    self.hostRank.text = model.homePosition;
    self.awayRank.text = model.awayPosition;
    self.hostRank.hidden = !(model.leaguesStatus.intValue == 1 || model.leaguesStatus.intValue == 10);
    self.awayRank.hidden = !(model.leaguesStatus.intValue == 1 || model.leaguesStatus.intValue == 10);
    self.hostLiveFlag.hidden = (model.leaguesStatus.intValue == 1 || model.leaguesStatus.intValue == 10);
    self.awayLiveFlag.hidden = (model.leaguesStatus.intValue == 1 || model.leaguesStatus.intValue == 10);
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:model.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:model.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostName.text = model.homeTeamName;
    self.awayName.text = model.awayTeamName;
    self.handicap.text = [NSString stringWithFormat:@"%.1f", fabsf(model.spread.floatValue)];
    [self.handicap mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(model.spread.intValue > 0 ? self.hostLogo : self.awayLogo);
        make.left.offset(154);
    }];
    
    [self.apLogoBtn setImage:[UIImage imageNamed:model.leaguesStatus.intValue == 10 ? @"ap_logo1" : @"ap_logo2"] forState:UIControlStateNormal];
    
    self.matchTime.text = [NSString axTimestampToDate:model.matchTime format:@"HH:mm"];
    if (model.leaguesStatus.intValue == 10) {
        self.matchState.text = @"End";
        self.matchState.textColor = rgb(255, 0, 31);
        self.matchState.backgroundColor = rgba(255, 0, 31, 0.1);
    } else {
        int min = model.residualTime.intValue / 60;
        int second = model.residualTime.intValue % 60;
        NSString *minStr = [NSString stringWithFormat: min < 10 ? @"0%d" : @"%d", min];
        NSString *secondStr = [NSString stringWithFormat:second < 10 ? @"0%d" : @"%d", second];
        self.matchState.text = [NSString stringWithFormat:@"%@ %@:%@", [AXMatchTools handleMatchStatusText:model.leaguesStatus.intValue], minStr, secondStr];
        self.matchState.textColor = rgb(65, 187, 24);
        self.matchState.backgroundColor = rgba(65, 187, 24, 0.1);
    }
    
    /// 赛事状态：1:未开赛，2:第1节，3:第1节完，4:第2节，5:第2节完，6:第3节，:第3节完，8:第4节，9:加时，10:完
    // 设置比分
    AXMatchListScoreCustomView *q1View = self.scoreViews[0];
    AXMatchListScoreCustomView *q2View = self.scoreViews[1];
    AXMatchListScoreCustomView *q3View = self.scoreViews[2];
    AXMatchListScoreCustomView *q4View = self.scoreViews[3];
    AXMatchListScoreCustomView *otView = self.scoreViews[4];
    AXMatchListScoreCustomView *totalView = self.scoreViews[5];
    totalView.datas = @[model.homeTotalScore, model.awayTotalScore];
    
    
    q1View.datas = @[model.homeScoreList.firstObject, model.awayscoreList.firstObject];
    q1View.isNeedHighlight = (model.leaguesStatus.intValue == 2 || model.leaguesStatus.intValue == 3);
    
    BOOL q2 = model.leaguesStatus.intValue >= 4;
    q2View.datas = @[q2 && model.homeScoreList.count > 1 ? model.homeScoreList[1] : @"-",
                     q2 && model.awayscoreList.count > 1 ? model.awayscoreList[1] : @"-"];
    q2View.isNeedHighlight = (model.leaguesStatus.intValue == 4 || model.leaguesStatus.intValue == 5);
    
    BOOL q3 = model.leaguesStatus.intValue >= 6;
    q3View.datas = @[q3 && model.homeScoreList.count > 2 ? model.homeScoreList[2] : @"-",
                     q3 && model.awayscoreList.count > 2 ? model.awayscoreList[2] : @"-"];
    q3View.isNeedHighlight = (model.leaguesStatus.intValue == 6 || model.leaguesStatus.intValue == 7);
    
    BOOL q4 = model.leaguesStatus.intValue >= 8;
    q4View.datas = @[q4 && model.homeScoreList.count > 3 ? model.homeScoreList[3] : @"-",
                     q4 && model.awayscoreList.count > 3 ? model.awayscoreList[3] : @"-"];
    q4View.isNeedHighlight = (model.leaguesStatus.intValue == 8);
    
    BOOL ot = model.leaguesStatus.intValue == 9 || model.homeScoreList.count > 4;  // 当前为加时；或者是结束了加时有值

    otView.hidden = !ot;
    otView.datas = @[ot && model.homeScoreList.count > 4 ? model.homeScoreList[4] : @"-",
                     q4 && model.awayscoreList.count > 4 ? model.awayscoreList[4] : @"-"];
    otView.isNeedHighlight = (model.leaguesStatus.intValue == 9);
    
    // 重新布局比分
    int scoreViewCount = ot ? 6 : 5;
    CGFloat scoreViewW = (ScreenWidth - kAXMatchListScoreViewLeftMargin - kAXMatchListScoreViewRightMargin) / scoreViewCount;
    for (int i = 0; i < self.scoreViews.count; i++) {
        AXMatchListScoreCustomView *view = self.scoreViews[i];
        // 设置ot view是否隐藏
        if (i == self.scoreViews.count - 2) {
            view.hidden = !ot;
        }
        
        CGFloat leftPostion = kAXMatchListScoreViewLeftMargin + scoreViewW * i;
        // 设置tot view位置
        if ((i == self.scoreViews.count - 1) && !ot) {
            leftPostion = kAXMatchListScoreViewLeftMargin + scoreViewW * (i - 1);  // 如果没有ot，tot view的位置往左侧挪动一位
        }
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(leftPostion);
            make.width.mas_equalTo(scoreViewW);
        }];
    }
    
    // 设置变色逻辑
    if (model.hostScoreChangeValue > 0) {
        self.hostScoreChangeLabel.hidden = false;
        self.hostScoreChangeLabel.text = [NSString stringWithFormat:@"+%d", model.hostScoreChangeValue];
        AXRunAfter(1, ^{
            self.hostScoreChangeLabel.hidden = true;
        });
        
        for (AXMatchListScoreCustomView *scoreView in self.scoreViews) {
            if (scoreView.isNeedHighlight) {
                [scoreView handleScoreChangeColor:true];
                AXLog(@"~~~~~~找到主队了");
                break;
            }
        }
    } else {
        self.hostScoreChangeLabel.hidden = true;
    }
    
    if (model.awayScoreChangeValue > 0) {
        self.awayScoreChangeLabel.hidden = false;
        self.awayScoreChangeLabel.text = [NSString stringWithFormat:@"+%d", model.awayScoreChangeValue];
        AXRunAfter(1, ^{
            self.awayScoreChangeLabel.hidden = true;
        });
        
        for (AXMatchListScoreCustomView *scoreView in self.scoreViews) {
            if (scoreView.isNeedHighlight) {
                [scoreView handleScoreChangeColor:false];
                AXLog(@"~~~~~~找到客队了");
                break;
            }
        }
    } else {
        self.awayScoreChangeLabel.hidden = true;
    }
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;
}

- (UIImageView *)leagueLogo{
    if (!_leagueLogo) {
        _leagueLogo = [UIImageView new];
    }
    return _leagueLogo;
}

- (UILabel *)leagueName{
    if (!_leagueName) {
        _leagueName = [UILabel new];
        _leagueName.font = [UIFont systemFontOfSize:12];
        _leagueName.textColor = rgb(17, 17, 17);
    }
    return _leagueName;
}

- (UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [UIButton new];
        [_collectBtn setImage:[UIImage imageNamed:@"match_list_collect"] forState:UIControlStateNormal];
    }
    return _collectBtn;
}

- (UIView *)lineH{
    if (!_lineH) {
        _lineH = [UIView new];
        _lineH.backgroundColor = rgb(231, 232, 241);
    }
    return _lineH;
}

- (UILabel *)hostRank{
    if (!_hostRank) {
        _hostRank = [UILabel new];
        _hostRank.font = AX_PingFangSemibold_Font(16);
        _hostRank.textColor = rgb(130, 134, 163);
    }
    return _hostRank;
}

- (UILabel *)hostLiveFlag{
    if (!_hostLiveFlag) {
        _hostLiveFlag = [UILabel new];
        _hostLiveFlag.text = @"Live";
        _hostLiveFlag.textAlignment = NSTextAlignmentCenter;
        _hostLiveFlag.textColor = rgb(73, 210, 27);
        _hostLiveFlag.font = AX_PingFangMedium_Font(8);
        _hostLiveFlag.layer.cornerRadius = 11;
        _hostLiveFlag.layer.masksToBounds = true;
        _hostLiveFlag.backgroundColor = rgba(65, 187, 24, 0.05);
    }
    return _hostLiveFlag;
}

- (UILabel *)awayRank{
    if (!_awayRank) {
        _awayRank = [UILabel new];
        _awayRank.font = AX_PingFangSemibold_Font(16);
        _awayRank.textColor = rgb(130, 134, 163);
    }
    return _awayRank;
}

- (UILabel *)awayLiveFlag{
    if (!_awayLiveFlag) {
        _awayLiveFlag = [UILabel new];
        _awayLiveFlag.text = @"Live";
        _awayLiveFlag.textAlignment = NSTextAlignmentCenter;
        _awayLiveFlag.textColor = rgb(73, 210, 27);
        _awayLiveFlag.font = AX_PingFangMedium_Font(8);
        _awayLiveFlag.layer.cornerRadius = 11;
        _awayLiveFlag.layer.masksToBounds = true;
        _awayLiveFlag.backgroundColor = rgba(65, 187, 24, 0.05);
    }
    return _awayLiveFlag;
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

- (UILabel *)hostName{
    if (!_hostName) {
        _hostName = [UILabel new];
        _hostName.font = AX_PingFangMedium_Font(10);
        _hostName.numberOfLines = 2;
        _hostName.textColor = rgb(17, 17, 17);
    }
    return _hostName;
}

- (UILabel *)awayName{
    if (!_awayName) {
        _awayName = [UILabel new];
        _awayName.font = AX_PingFangMedium_Font(10);
        _awayName.numberOfLines = 2;
        _awayName.textColor = rgb(17, 17, 17);
    }
    return _awayName;
}

- (UILabel *)matchTime{
    if (!_matchTime) {
        _matchTime = [UILabel new];
        _matchTime.font = [UIFont systemFontOfSize:12];
        _matchTime.textColor = rgb(130, 134, 163);
        _matchTime.text = @"08:30";
    }
    return _matchTime;
}

- (UILabel *)matchState{
    if (!_matchState) {
        _matchState = [UILabel new];
        _matchState.font = [UIFont systemFontOfSize:10];
        _matchState.layer.cornerRadius = 9;
        _matchState.layer.masksToBounds = true;
        _matchState.textAlignment = NSTextAlignmentCenter;
        _matchState.text = @"OT2 04:34";
    }
    return _matchState;
}

- (UILabel *)handicap{
    if (!_handicap) {
        _handicap = [UILabel new];
        _handicap.font = AX_PingFangMedium_Font(12);
        _handicap.textColor = rgb(253, 157, 9);
        _handicap.text = @"6.5";
    }
    return _handicap;
}

- (UIButton *)apLogoBtn{
    if (!_apLogoBtn) {
        _apLogoBtn = [UIButton new];
    }
    return _apLogoBtn;
}

- (UILabel *)hostScoreChangeLabel{
    if (!_hostScoreChangeLabel) {
        _hostScoreChangeLabel = [UILabel new];
        _hostScoreChangeLabel.textColor = rgb(73, 210, 27);
        _hostScoreChangeLabel.font = AX_PingFangSemibold_Font(12);
        _hostScoreChangeLabel.text = @"+2";
        _hostScoreChangeLabel.hidden = true;
    }
    return _hostScoreChangeLabel;
}

- (UILabel *)awayScoreChangeLabel{
    if (!_awayScoreChangeLabel) {
        _awayScoreChangeLabel = [UILabel new];
        _awayScoreChangeLabel.textColor = rgb(73, 210, 27);
        _awayScoreChangeLabel.font = AX_PingFangSemibold_Font(12);
        _awayScoreChangeLabel.text = @"+2";
        _awayScoreChangeLabel.hidden = true;
    }
    return _awayScoreChangeLabel;
}

@end
