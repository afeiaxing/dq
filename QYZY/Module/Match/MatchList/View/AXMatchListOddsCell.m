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
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 7; i < 10; i++) {
        AXMatchListScoreCustomView *view = [AXMatchListScoreCustomView new];
        view.viewType = (AXMatchListScoreCustomViewType)i;
        [self.containerView addSubview:view];
        [temp addObject:view];
    }
    self.marketViews = temp.copy;
    [self.marketViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:50 leadSpacing:200 tailSpacing:19];
    [self.marketViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.equalTo(lineH.mas_bottom).offset(6);
    }];
}

// MARK: setter & getter
- (void)setModel:(AXMatchListItemModel *)model{
    [self.leagueLogo sd_setImageWithURL:[NSURL URLWithString:model.leaguesLogo] placeholderImage:AXLeaguePlaceholderLogo];
    self.leagueName.text = model.leaguesName;
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:model.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:model.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostName.text = model.homeTeamName;
    self.awayName.text = model.awayTeamName;
    self.handicap.text = model.spread;
    self.handicap.text = [NSString stringWithFormat:@"%.1f", fabsf(model.spread.floatValue)];
    [self.handicap mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(model.spread.intValue > 0 ? self.hostLogo : self.awayLogo);
        make.left.offset(154);
    }];
    
    self.matchTime.text = [NSString axTimestampToDate:model.matchTime format:@"HH:mm"];
    int min = model.residualTime.intValue / 60;
    int second = model.residualTime.intValue % 60;
    self.matchState.text = [NSString stringWithFormat:@"%@ %d:%d", [AXMatchTools handleMatchStatusText:model.leaguesStatus.intValue], min, second];
    
    for (AXMatchListScoreCustomView *view in self.marketViews) {
        if (view.viewType == AXMatchListScoreCustomViewHandicap) {
            view.datas = @[model.homeOdds, model.awayOdds];
        } else if (view.viewType == AXMatchListScoreCustomViewOU) {
            view.datas = @[[NSString stringWithFormat:@"O%@",model.ballScore], [NSString stringWithFormat:@"U%@",model.ballScore]];
        } else if (view.viewType == AXMatchListScoreCustomViewMoneyline) {
            view.datas = @[[NSString stringWithFormat:@"%@",model.bigBallOdds], [NSString stringWithFormat:@"%@",model.smallBallOdds]];
        }
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
    }
    return _matchTime;
}

- (UILabel *)matchState{
    if (!_matchState) {
        _matchState = [UILabel new];
        _matchState.font = [UIFont systemFontOfSize:10];
        _matchState.textColor = rgb(65, 187, 24);
        _matchState.backgroundColor = rgba(65, 187, 24, 0.1);
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
