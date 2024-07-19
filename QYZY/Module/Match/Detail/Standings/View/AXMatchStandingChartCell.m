//
//  AXMatchStandingChartCell.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchStandingChartCell.h"
#import "AXMatchStandingPolylineView.h"
#import "AXMatchListScoreCustomView.h"

@interface AXMatchStandingChartCell()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;

@property (nonatomic, strong) AXMatchStandingPolylineView *polylineView;

@property (nonatomic, strong) UIView *scoreBGView;
@property (nonatomic, strong) UILabel *scoreTeamTitle;
@property (nonatomic, strong) UIView *scoreHostColorView;
@property (nonatomic, strong) UIView *scoreAwayColorView;
@property (nonatomic, strong) UILabel *scoreHostRanking;
@property (nonatomic, strong) UILabel *scoreAwayRanking;
@property (nonatomic, strong) UIImageView *scoreHostLogo;
@property (nonatomic, strong) UIImageView *scoreAwayLogo;
@property (nonatomic, strong) UILabel *scoreHostName;
@property (nonatomic, strong) UILabel *scoreAwayName;
@property (nonatomic, strong) UIView *scoreLineView;

@property (nonatomic, strong) NSArray *scoreViews;


@end

// 折线图
#define kMatchStandingChartLeftMargin 78
#define kMatchStandingChartRightMargin 12
#define kMatchStandingChartHeight 128

// 比分
#define kAXMatchScoreViewLeftMargin 141
#define kAXMatchScoreViewRightMargin 15

@implementation AXMatchStandingChartCell

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
    
    [self.containerView addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.containerView addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(self.hostLogo);
        make.top.equalTo(self.hostLogo.mas_bottom).offset(20);
    }];
    
    [self.containerView addSubview:self.polylineView];
    
    [self.containerView addSubview:self.scoreBGView];
    [self.scoreBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostLogo);
        make.right.equalTo(self.polylineView);
        make.top.equalTo(self.polylineView.mas_bottom).offset(16);
        make.height.mas_equalTo(114);
    }];
    
    [self.scoreBGView addSubview:self.scoreTeamTitle];
    [self.scoreTeamTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(16);
    }];
    
    [self.scoreBGView addSubview:self.scoreHostColorView];
    [self.scoreHostColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(50);
        make.size.mas_equalTo(CGSizeMake(6, 20));
    }];
    
    [self.scoreBGView addSubview:self.scoreAwayColorView];
    [self.scoreAwayColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.scoreHostColorView);
        make.top.equalTo(self.scoreHostColorView.mas_bottom).offset(11);
    }];
    
    [self.scoreBGView addSubview:self.scoreHostRanking];
    [self.scoreHostRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreHostColorView.mas_right).offset(11);
        make.centerY.equalTo(self.scoreHostColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreAwayRanking];
    [self.scoreAwayRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scoreHostRanking);
        make.centerY.equalTo(self.scoreAwayColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreHostLogo];
    [self.scoreHostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreHostRanking.mas_right).offset(11);
        make.centerY.equalTo(self.scoreHostColorView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.scoreBGView addSubview:self.scoreAwayLogo];
    [self.scoreAwayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.scoreHostLogo);
        make.centerY.equalTo(self.scoreAwayColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreHostName];
    [self.scoreHostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreHostLogo.mas_right).offset(11);
        make.centerY.equalTo(self.scoreHostColorView);
        make.width.mas_equalTo(45);
    }];
    
    [self.scoreBGView addSubview:self.scoreAwayName];
    [self.scoreAwayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scoreHostName);
        make.centerY.equalTo(self.scoreAwayColorView);
        make.width.equalTo(self.scoreHostName);
    }];
    
    [self.scoreBGView addSubview:self.scoreLineView];
    [self.scoreLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(self.scoreHostName.mas_right).offset(12);
        make.size.mas_equalTo(CGSizeMake(1, 80));
    }];
    
    int scoreViewCount = 6; // q1,q2,q3,q4,ot,tot，最多6个
    CGFloat scoreViewW = (ScreenWidth - kAXMatchScoreViewLeftMargin - kAXMatchScoreViewRightMargin) / scoreViewCount;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < scoreViewCount; i++) {
        AXMatchListScoreCustomView *view = [[AXMatchListScoreCustomView alloc] initWithHostscoreTopMargin:15 isNeedScoreSize: false];
        view.viewType = (AXMatchListScoreCustomViewType)i;
        [self.scoreBGView addSubview:view];
        [temp addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kAXMatchScoreViewLeftMargin + scoreViewW * i);
            make.width.mas_equalTo(scoreViewW);
            make.height.mas_equalTo(82);
            make.top.equalTo(self.scoreBGView).offset(16);
        }];
    }
    self.scoreViews = temp.copy;
}

// MARK: setter & setter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    _matchModel = matchModel;
    
    self.polylineView.matchModel = matchModel;
    
    self.scoreHostRanking.text = matchModel.homePosition;
    self.scoreAwayRanking.text = matchModel.awayPosition;
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.scoreHostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.scoreAwayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.scoreHostName.text = matchModel.homeTeamName;
    self.scoreAwayName.text = matchModel.awayTeamName;
    
    /// 赛事状态：1:未开赛，2:第1节，3:第1节完，4:第2节，5:第2节完，6:第3节，:第3节完，8:第4节，9:加时，10:完
    // 设置比分
    AXMatchListScoreCustomView *q1View = self.scoreViews[0];
    AXMatchListScoreCustomView *q2View = self.scoreViews[1];
    AXMatchListScoreCustomView *q3View = self.scoreViews[2];
    AXMatchListScoreCustomView *q4View = self.scoreViews[3];
    AXMatchListScoreCustomView *otView = self.scoreViews[4];
    AXMatchListScoreCustomView *totalView = self.scoreViews[5];
    
    BOOL isScheduleStatus = matchModel.leaguesStatus.intValue == 1;
    totalView.datas = @[isScheduleStatus ? @"-" : matchModel.homeTotalScore, isScheduleStatus ? @"-" : matchModel.awayTotalScore];
    
    BOOL q1 = matchModel.leaguesStatus.intValue >= 2;

    q1View.datas = @[q1 && matchModel.homeScoreList.count > 0 ? matchModel.homeScoreList[0] : @"-",
                     q1 && matchModel.awayscoreList.count > 0 ? matchModel.awayscoreList[0] : @"-"];
    q1View.isNeedHighlight = (matchModel.leaguesStatus.intValue == 2 || matchModel.leaguesStatus.intValue == 3);
    
    BOOL q2 = matchModel.leaguesStatus.intValue >= 4;
    q2View.datas = @[q2 && matchModel.homeScoreList.count > 1 ? matchModel.homeScoreList[1] : @"-",
                     q2 && matchModel.awayscoreList.count > 1 ? matchModel.awayscoreList[1] : @"-"];
    q2View.isNeedHighlight = (matchModel.leaguesStatus.intValue == 4 || matchModel.leaguesStatus.intValue == 5);
    
    BOOL q3 = matchModel.leaguesStatus.intValue >= 6;
    q3View.datas = @[q3 && matchModel.homeScoreList.count > 2 ? matchModel.homeScoreList[2] : @"-",
                     q3 && matchModel.awayscoreList.count > 2 ? matchModel.awayscoreList[2] : @"-"];
    q3View.isNeedHighlight = (matchModel.leaguesStatus.intValue == 6 || matchModel.leaguesStatus.intValue == 7);
    
    BOOL q4 = matchModel.leaguesStatus.intValue >= 8;
    q4View.datas = @[q4 && matchModel.homeScoreList.count > 3 ? matchModel.homeScoreList[3] : @"-",
                     q4 && matchModel.awayscoreList.count > 3 ? matchModel.awayscoreList[3] : @"-"];
    q4View.isNeedHighlight = (matchModel.leaguesStatus.intValue == 8);
    
    BOOL ot = matchModel.leaguesStatus.intValue == 9 || matchModel.homeScoreList.count > 4;  // 当前为加时；或者是结束了加时有值

    otView.hidden = !ot;
    otView.datas = @[ot && matchModel.homeScoreList.count > 4 ? matchModel.homeScoreList[4] : @"-",
                     q4 && matchModel.awayscoreList.count > 4 ? matchModel.awayscoreList[4] : @"-"];
    otView.isNeedHighlight = (matchModel.leaguesStatus.intValue == 9);
    
    // 重新布局比分
    int scoreViewCount = ot ? 6 : 5;
    CGFloat scoreViewW = (ScreenWidth - kAXMatchScoreViewLeftMargin - kAXMatchScoreViewRightMargin - kMatchStandingChartRightMargin - 12) / scoreViewCount;
    for (int i = 0; i < self.scoreViews.count; i++) {
        AXMatchListScoreCustomView *view = self.scoreViews[i];
        // 设置ot view是否隐藏
        if (i == self.scoreViews.count - 2) {
            view.hidden = !ot;
        }
        
        CGFloat leftPostion = kAXMatchScoreViewLeftMargin + scoreViewW * i;
        // 设置tot view位置
        if ((i == self.scoreViews.count - 1) && !ot) {
            leftPostion = kAXMatchScoreViewLeftMargin + scoreViewW * (i - 1);  // 如果没有ot，tot view的位置往左侧挪动一位
        }
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(leftPostion);
            make.width.mas_equalTo(scoreViewW);
        }];
    }
}

- (void)setStandingModel:(AXMatchStandingModel *)standingModel{
    _standingModel = standingModel;
    NSMutableArray *temp = [NSMutableArray array];
    
    for (NSArray *array in standingModel.scoreDiff) {
        for (NSNumber *scoreDiff in array) {
            [temp addObject:scoreDiff];
        }
    }
    if (temp.count) {
        self.polylineView.scoreDiffs = temp.copy;
    }
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;
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

- (AXMatchStandingPolylineView *)polylineView{
    if (!_polylineView) {
        _polylineView = [[AXMatchStandingPolylineView alloc] initWithFrame:CGRectMake(kMatchStandingChartLeftMargin, 20, ScreenWidth - kMatchStandingChartLeftMargin - kMatchStandingChartRightMargin, kMatchStandingChartHeight)];
    }
    return _polylineView;
}

- (UIView *)scoreBGView{
    if (!_scoreBGView) {
        _scoreBGView = [UIView new];
        _scoreBGView.backgroundColor = rgb(255, 247, 239);
        _scoreBGView.layer.cornerRadius = 8;
    }
    return _scoreBGView;
}

- (UILabel *)scoreTeamTitle{
    if (!_scoreTeamTitle) {
        _scoreTeamTitle = [UILabel new];
        _scoreTeamTitle.text = @"Team";
        _scoreTeamTitle.font = [UIFont systemFontOfSize:12];
        _scoreTeamTitle.textColor = AXUnSelectColor;
    }
    return _scoreTeamTitle;
}

- (UIView *)scoreHostColorView{
    if (!_scoreHostColorView) {
        _scoreHostColorView = [UIView new];
        _scoreHostColorView.backgroundColor = rgb(143, 0, 255);
        _scoreHostColorView.layer.cornerRadius = 4;
        _scoreHostColorView.layer.maskedCorners =  kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
    }
    return _scoreHostColorView;
}

- (UIView *)scoreAwayColorView{
    if (!_scoreAwayColorView) {
        _scoreAwayColorView = [UIView new];
        _scoreAwayColorView.backgroundColor = rgb(0, 162, 36);
        _scoreAwayColorView.layer.cornerRadius = 4;
        _scoreAwayColorView.layer.maskedCorners =  kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
    }
    return _scoreAwayColorView;
}

- (UILabel *)scoreHostRanking{
    if (!_scoreHostRanking) {
        _scoreHostRanking = [UILabel new];
        _scoreHostRanking.text = @"5";
        _scoreHostRanking.font = AX_PingFangSemibold_Font(16);
        _scoreHostRanking.textColor = AXUnSelectColor;
    }
    return _scoreHostRanking;
}

- (UILabel *)scoreAwayRanking{
    if (!_scoreAwayRanking) {
        _scoreAwayRanking = [UILabel new];
        _scoreAwayRanking.text = @"2";
        _scoreAwayRanking.font = AX_PingFangSemibold_Font(16);
        _scoreAwayRanking.textColor = AXUnSelectColor;
    }
    return _scoreAwayRanking;
}

- (UIImageView *)scoreHostLogo{
    if (!_scoreHostLogo) {
        _scoreHostLogo = [UIImageView new];
        _scoreHostLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _scoreHostLogo;
}

- (UIImageView *)scoreAwayLogo{
    if (!_scoreAwayLogo) {
        _scoreAwayLogo = [UIImageView new];
        _scoreAwayLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _scoreAwayLogo;
}

- (UILabel *)scoreHostName{
    if (!_scoreHostName) {
        _scoreHostName = [UILabel new];
        _scoreHostName.font = [UIFont systemFontOfSize:14];
        _scoreHostName.textColor = rgb(17, 17, 17);
    }
    return _scoreHostName;
}

- (UILabel *)scoreAwayName{
    if (!_scoreAwayName) {
        _scoreAwayName = [UILabel new];
        _scoreAwayName.font = [UIFont systemFontOfSize:14];
        _scoreAwayName.textColor = rgb(17, 17, 17);
    }
    return _scoreAwayName;
}

- (UIView *)scoreLineView{
    if (!_scoreLineView) {
        _scoreLineView = [UIView new];
        _scoreLineView.backgroundColor = rgba(130, 134, 163, 0.5);
    }
    return _scoreLineView;
}

@end
