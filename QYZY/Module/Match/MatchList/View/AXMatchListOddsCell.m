//
//  AXMatchListOddsCell.m
//  QYZY
//
//  Created by 11 on 5/16/24.
//

#import "AXMatchListOddsCell.h"
#import "AXMatchListScoreCustomView.h"

@interface AXMatchListOddsCell()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *leagueLogo;
@property (nonatomic, strong) UILabel *leagueName;
@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) UILabel *hostRank;
@property (nonatomic, strong) UILabel *awayRank;
@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;
@property (nonatomic, strong) UILabel *matchTime;
@property (nonatomic, strong) UILabel *matchState;

@property (nonatomic, strong) UILabel *handicap;
@property (nonatomic, strong) UIButton *apLogoBtn;
@property (nonatomic, strong) NSArray *marketViews;

@end

#define kAXMatchListMarketViewLeftMargin 220
#define kAXMatchListMarketViewRightMargin 17

@implementation AXMatchListOddsCell

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
    
    UIView *lineH = [UIView new];
    lineH.backgroundColor = rgb(231, 232, 241);
    [self.containerView addSubview:lineH];
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.equalTo(self.leagueLogo.mas_bottom).offset(8);
        make.height.mas_equalTo(1);
    }];
    
    [self.containerView addSubview:self.hostRank];
    [self.hostRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.equalTo(lineH.mas_bottom).offset(18);
        make.width.mas_equalTo(23);
    }];
    
    [self.containerView addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(35);
        make.top.equalTo(lineH.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.containerView addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.hostLogo);
        make.top.equalTo(self.hostLogo.mas_bottom).offset(12);
    }];
    
    [self.containerView addSubview:self.awayRank];
    [self.awayRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostRank);
        make.centerY.equalTo(self.awayLogo);
        make.width.equalTo(self.hostRank);
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
        make.top.equalTo(lineH.mas_bottom).offset(22);
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
    
    int marketViewCount = 3;
    CGFloat marketViewW = (ScreenWidth - kAXMatchListMarketViewLeftMargin - kAXMatchListMarketViewRightMargin) / marketViewCount;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < marketViewCount; i++) {
        AXMatchListScoreCustomView *view = [[AXMatchListScoreCustomView alloc] initWithHostscoreTopMargin:0 isNeedScoreSize: false];
        view.marketType = (AXMatchListScoreCustomMarketType)i;
        [self.containerView addSubview:view];
        [temp addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kAXMatchListMarketViewLeftMargin + marketViewW * i);
            make.width.mas_equalTo(marketViewW);
            make.height.mas_equalTo(65);
            make.top.equalTo(lineH.mas_bottom).offset(6);
        }];
    }
    self.marketViews = temp.copy;
}

// MARK: setter & getter
- (void)setModel:(AXMatchListItemModel *)model{
    [self.leagueLogo sd_setImageWithURL:[NSURL URLWithString:model.leaguesLogo] placeholderImage:AXLeaguePlaceholderLogo];
    self.leagueName.text = model.leaguesName;
    self.hostRank.text = model.homePosition;
    self.awayRank.text = model.awayPosition;
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:model.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:model.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostName.text = model.homeTeamName;
    self.awayName.text = model.awayTeamName;
    self.handicap.text = model.spread;
    NSString *handicap = [self handleNullData:model.spread];
    self.handicap.text = handicap.length ? [NSString stringWithFormat:@"%.1f", fabsf(model.spread.floatValue)] : handicap;
    [self.handicap mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(model.spread.intValue > 0 ? self.hostLogo : self.awayLogo);
        make.left.offset(154);
    }];
    
    self.matchTime.text = [NSString axTimestampToDate:model.matchTime format:@"HH:mm"];
    self.matchState.text = [NSDate getScheduleMatchTimeWithTimestamp:model.matchTime];
    
    for (AXMatchListScoreCustomView *view in self.marketViews) {
        if (view.marketType == AXMatchListScoreCustomMarketTypeHandicap) {
            view.datas = @[[self handleNullData:model.homeOdds], [self handleNullData:model.awayOdds]];
        } else if (view.marketType == AXMatchListScoreCustomMarketTypeOU) {
            NSString *ou = [self handleNullData:model.ballScore];
            NSString *o = ou.length ? [NSString stringWithFormat:@"O%@",ou] : @"";
            NSString *u = ou.length ? [NSString stringWithFormat:@"U%@",ou] : @"";
            view.datas = @[o, u];
        } else if (view.marketType == AXMatchListScoreCustomMarketTypeMoneyline) {
            view.datas = @[[NSString stringWithFormat:@"%@",[self handleNullData:model.bigBallOdds]], [NSString stringWithFormat:@"%@",[self handleNullData:model.smallBallOdds]]];
        }
    }
    
}

- (NSString *)handleNullData: (NSString *)data{
    if (data && data.length){
        return data;
    } else {
        return @"";
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

- (UILabel *)hostRank{
    if (!_hostRank) {
        _hostRank = [UILabel new];
        _hostRank.font = AX_PingFangSemibold_Font(16);
        _hostRank.textColor = rgb(130, 134, 163);
    }
    return _hostRank;
}

- (UILabel *)awayRank{
    if (!_awayRank) {
        _awayRank = [UILabel new];
        _awayRank.font = AX_PingFangSemibold_Font(16);
        _awayRank.textColor = rgb(130, 134, 163);
    }
    return _awayRank;
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
    }
    return _matchTime;
}

- (UILabel *)matchState{
    if (!_matchState) {
        _matchState = [UILabel new];
        _matchState.font = [UIFont systemFontOfSize:10];
        _matchState.textColor = AXSelectColor;
        _matchState.backgroundColor = rgba(255, 88, 0, 0.1);
        _matchState.layer.cornerRadius = 9;
        _matchState.layer.masksToBounds = true;
        _matchState.textAlignment = NSTextAlignmentCenter;
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
