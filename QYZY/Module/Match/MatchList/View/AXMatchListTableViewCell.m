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

@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;
@property (nonatomic, strong) UILabel *matchTime;
@property (nonatomic, strong) UILabel *matchState;

@property (nonatomic, strong) UILabel *handicap;
@property (nonatomic, strong) UIButton *apLogoBtn;
@property (nonatomic, strong) NSArray *scoreViews;

@end

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
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        AXMatchListScoreCustomView *view = [AXMatchListScoreCustomView new];
        view.viewType = (AXMatchListScoreCustomViewType)i;
        [self.containerView addSubview:view];
        [temp addObject:view];
    }
    self.scoreViews = temp.copy;
    [self.scoreViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:20 leadSpacing:182 tailSpacing:17];
    [self.scoreViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(65);
        make.top.equalTo(self.lineH.mas_bottom).offset(6);
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
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:model.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:model.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostName.text = model.homeTeamName;
    self.awayName.text = model.awayTeamName;
    self.handicap.text = [NSString stringWithFormat:@"%.1f", fabsf(model.spread.floatValue)];
    [self.handicap mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(model.spread.intValue > 0 ? self.hostLogo : self.awayLogo);
        make.left.offset(154);
    }];
    
    self.matchTime.text = [NSString axTimestampToDate:model.matchTime format:@"HH:mm"];
    if (model.leaguesStatus.intValue == 10) {
        self.matchState.text = @"End";
        self.matchState.textColor = rgb(255, 0, 31);
        self.matchState.backgroundColor = rgba(255, 0, 31, 0.1);
    } else if (model.leaguesStatus.intValue == 1) {
        self.matchState.text = [NSDate getScheduleMatchTimeWithTimestamp:model.matchTime];
        self.matchState.textColor = AXSelectColor;
        self.matchState.backgroundColor = rgba(255, 88, 0, 0.1);
    } else {
        int min = model.residualTime.intValue / 60;
        int second = model.residualTime.intValue % 60;
        self.matchState.text = [NSString stringWithFormat:@"%@ %d:%d", [AXMatchTools handleMatchStatusText:model.leaguesStatus.intValue], min, second];
        self.matchState.textColor = rgb(65, 187, 24);
        self.matchState.backgroundColor = rgba(65, 187, 24, 0.1);
    }
    
    /// 赛事状态：1:未开赛，2:第1节，3:第1节完，4:第2节，5:第2节完，6:第3节，:第3节完，8:第4节，9:加时，10:完
    // 设置比分
    AXMatchListScoreCustomView *q1View = self.scoreViews[0];
    AXMatchListScoreCustomView *q2View = self.scoreViews[1];
    AXMatchListScoreCustomView *q3View = self.scoreViews[2];
    AXMatchListScoreCustomView *q4View = self.scoreViews[3];
    AXMatchListScoreCustomView *ot1View = self.scoreViews[4];
    AXMatchListScoreCustomView *totalView = self.scoreViews[5];
    totalView.datas = @[model.homeTotalScore, model.awayTotalScore];
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:@[q1View, q2View, q3View, q4View]];
    
    q1View.datas = @[model.homeScoreList.firstObject, model.awayscoreList.firstObject];
    
    BOOL q2 = model.leaguesStatus.intValue >= 4;
    q2View.datas = @[q2 && model.homeScoreList.count > 1 ? model.homeScoreList[1] : @"-",
                     q2 && model.awayscoreList.count > 1 ? model.awayscoreList[1] : @"-"];
    
    BOOL q3 = model.leaguesStatus.intValue >= 6;
    q3View.datas = @[q3 && model.homeScoreList.count > 2 ? model.homeScoreList[2] : @"-",
                     q3 && model.awayscoreList.count > 2 ? model.awayscoreList[2] : @"-"];
    
    BOOL q4 = model.leaguesStatus.intValue >= 8;
    q4View.datas = @[q4 && model.homeScoreList.count > 3 ? model.homeScoreList[3] : @"-",
                     q4 && model.awayscoreList.count > 3 ? model.awayscoreList[3] : @"-"];
    
    BOOL ot1 = model.leaguesStatus.intValue == 9 || model.homeScoreList.count > 4;  // 当前为加时；或者是结束了加时有值
    if (ot1) {
        [temp addObject:ot1View];
    }
    ot1View.hidden = !ot1;
    ot1View.datas = @[ot1 && model.homeScoreList.count > 4 ? model.homeScoreList[4] : @"-",
                     q4 && model.awayscoreList.count > 4 ? model.awayscoreList[4] : @"-"];
    
    // 重新布局比分
    
//    [temp mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:20 leadSpacing:182 tailSpacing:17];
//    [temp mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(65);
//        make.top.equalTo(self.lineH.mas_bottom).offset(6);
//    }];
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

- (UIImageView *)hostLogo{
    if (!_hostLogo) {
        _hostLogo = [UIImageView new];
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo{
    if (!_awayLogo) {
        _awayLogo = [UIImageView new];
    }
    return _awayLogo;
}

- (UILabel *)hostName{
    if (!_hostName) {
        _hostName = [UILabel new];
        _hostName.font = [UIFont systemFontOfSize:14];
        _hostName.textColor = rgb(17, 17, 17);
    }
    return _hostName;
}

- (UILabel *)awayName{
    if (!_awayName) {
        _awayName = [UILabel new];
        _awayName.font = [UIFont systemFontOfSize:14];
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
        _handicap.font = [UIFont systemFontOfSize:12];
        _handicap.textColor = rgb(253, 157, 9);
        _handicap.text = @"6.5";
    }
    return _handicap;
}

- (UIButton *)apLogoBtn{
    if (!_apLogoBtn) {
        _apLogoBtn = [UIButton new];
        [_apLogoBtn setImage:[UIImage imageNamed:@"ap_logo2"] forState:UIControlStateNormal];
    }
    return _apLogoBtn;
}

@end
