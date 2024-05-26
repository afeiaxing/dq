//
//  QYZYMatchDetailViewController.m
//  QYZY
//
//  Created by jspollo on 2022/10/13.
//

#import "QYZYMatchDetailViewController.h"
#import "QYZYLiveChatViewController.h"
#import "QYZYMatchOverViewController.h"
#import "QYZYMatchAnalyzeViewController.h"
#import "QYZYBasketballOverviewController.h"
#import "QYZYMatchViewModel.h"
#import <WebKit/WebKit.h>
#import "AXMatchBetViewController.h"
#import "AXMatchChatViewController.h"
#import "AXMatchStandingsViewController.h"
#import "AXMatchLineupViewController.h"
#import "AXMatchAnalysisViewController.h"
#import "AXMatchDetailRequest.h"

@interface QYZYMatchDetailViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic ,strong) UIView *statusView;
@property (nonatomic ,strong) UIView *navigationView;
@property (nonatomic ,strong) UIImageView *headerBgView;
@property (nonatomic, strong) UILabel *topHostName;
@property (nonatomic, strong) UILabel *topAwayName;
@property (nonatomic, strong) UIImageView *topHostLogo;
@property (nonatomic, strong) UIImageView *topAwayLogo;

@property (nonatomic, strong) UILabel *hostFlag;
@property (nonatomic, strong) UILabel *awayFlag;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIImageView *hostLogo;
@property (nonatomic ,strong) UIImageView *awayLogo;
@property (nonatomic ,strong) UILabel *hostName;
@property (nonatomic ,strong) UILabel *awayName;
@property (nonatomic ,strong) UIButton *playButton;
@property (nonatomic ,strong) UILabel *scoreLabel;

@property (nonatomic ,strong) QYZYMatchViewModel *viewModel;
@property (nonatomic ,strong) QYZYMatchMainModel *mainModel;
@property (nonatomic ,strong) WKWebView *webView;
@property (nonatomic ,strong) UIButton *backButton;
//@property (nonatomic ,strong) QYZYLiveChatViewController *chatVC;
@property (nonatomic, strong) AXMatchBetViewController *betVC;
@property (nonatomic, strong) AXMatchChatViewController *chatVC;
@property (nonatomic, strong) AXMatchStandingsViewController *standingsVC;
@property (nonatomic, strong) AXMatchLineupViewController *lineupVC;
@property (nonatomic, strong) AXMatchAnalysisViewController *analysisVC;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *containerView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) AXMatchDetailRequest *request;

@end

@implementation QYZYMatchDetailViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.timer) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerLoadDetailData) userInfo:nil repeats:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupSubViews];
    [self setInitData];
    [self requestData];
}

- (void)setupSubViews {
    [self.view addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(StatusBarHeightConstant);
    }];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.statusView.mas_bottom);
        make.height.mas_equalTo(NavigationBarHeight);
    }];
    
    [self.navigationView addSubview:self.topHostName];
    [self.topHostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-50);
        make.centerY.offset(0);
    }];
    
    [self.navigationView addSubview:self.topHostLogo];
    [self.topHostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topHostName.mas_left).offset(-8);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.navigationView addSubview:self.topAwayLogo];
    [self.topAwayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(50);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.navigationView addSubview:self.topAwayName];
    [self.topAwayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topAwayLogo.mas_right).offset(8);
        make.centerY.offset(0);
    }];
    
    CGFloat headerBGHeight = 204;
    [self.view addSubview:self.headerBgView];
    [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navigationView.mas_bottom);
        make.height.mas_equalTo(headerBGHeight);
    }];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerBgView);
    }];
    
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(8);
        make.top.equalTo(self.view).offset(StatusBarHeightConstant + 8);
        make.height.width.mas_equalTo(28);
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
    
    [self.headerBgView addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(self.headerBgView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 24));
    }];
    
    [self.headerBgView addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerBgView);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
    }];
    
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.headerBgView.mas_bottom);
    }];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.categoryView.mas_bottom);
    }];
}

- (void)setInitData{
//    self.timeLabel.text = [self time_timestampToString:detailModel.matchTime.integerValue];
    [self.topHostLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.topHostName.text = self.matchModel.homeTeamName;
    [self.topAwayLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.topAwayName.text = self.matchModel.awayTeamName;
    
    self.hostName.text = self.matchModel.homeTeamName;
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.awayName.text = self.matchModel.awayTeamName;
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@ - %@",self.matchModel.homeTotalScore ?: @"0", self.matchModel.awayTotalScore ?: @"0"];
}

- (void)requestData {
    weakSelf(self);
    [self.request requestMatchDetailWithMatchId:self.matchModel.matchId completion:^(AXMatchDetailModel * _Nonnull matchModel) {
        NSLog(@"%@", matchModel);
    }];
//    [self.viewModel requestMatchDetailWithMatchId:self.matchId completion:^(QYZYMatchMainModel * _Nonnull detailModel) {
//        strongSelf(self);
//        detailModel = [QYZYMatchMainModel new];
//        if (detailModel) {
//            self.mainModel = detailModel;
//            [self updateHeaderWithDetailModel:detailModel];
//            if (detailModel.animUrl.length) {
//                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detailModel.animUrl]]];
//            } else if (detailModel.obliqueAnimUrl.length) {
//                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detailModel.obliqueAnimUrl]]];
//            }
////            self.chatVC.chatId = detailModel.matchId;
//            self.analyzeVC.detailModel = detailModel;
//            if (detailModel.sportId.integerValue == 2) {
//                self.basketballOverVc.detailModel = detailModel;
//            }else {
//                self.overVC.detailModel = detailModel;
//            }
//        }
//    }];
}

- (void)updateHeaderWithDetailModel:(QYZYMatchMainModel *)detailModel {
    self.timeLabel.text = [self time_timestampToString:detailModel.matchTime.integerValue];
//    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:detailModel.hostTeamLogo]];
//    self.hostLogo.backgroundColor = detailModel.hostTeamLogo.length ? UIColor.clearColor : rgba(255, 255, 255, 0.15);
    self.hostName.text = @"Los Angeles Lakers";
//    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:detailModel.guestTeamLogo]];
//    self.awayLogo.backgroundColor = detailModel.guestTeamLogo.length ? UIColor.clearColor : rgba(255, 255, 255, 0.15);
    self.awayName.text = @"Boston Celtics";
    self.scoreLabel.text = [NSString stringWithFormat:@"%@ - %@",detailModel.hostTeamScore ?: @"0", detailModel.guestTeamScore ?: @"0"];
}

#pragma mark - delegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        return self.betVC;
    } else if (index == 1) {
        return self.chatVC;
    } else if (index == 2) {
        return self.standingsVC;
    } else if (index == 3) {
        return self.lineupVC;
    } else {
        return self.analysisVC;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titleArray.count;
}

#pragma mark - action
- (void)backAction {
    if (!self.webView.hidden) {
        self.webView.hidden = YES;
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playAction {
    if (self.mainModel.animUrl.length || self.mainModel.obliqueAnimUrl.length) {
        self.webView.hidden = NO;
    } else {
        self.webView.hidden = YES;
        [self.view qyzy_showMsg:@"暂无动画"];
    }
}

#pragma mark - get
- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = UIColor.blackColor;
    }
    return _statusView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"live_detail_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [UIView new];
        _navigationView.backgroundColor = UIColor.blackColor;
    }
    return _navigationView;;
}

- (UIImageView *)topHostLogo{
    if (!_topHostLogo) {
        _topHostLogo = [UIImageView new];
        _topHostLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _topHostLogo;
}

- (UIImageView *)topAwayLogo{
    if (!_topAwayLogo) {
        _topAwayLogo = [UIImageView new];
        _topAwayLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _topAwayLogo;
}

- (UILabel *)topHostName{
    if (!_topHostName) {
        _topHostName = [UILabel new];
        _topHostName.text = @"LAL";
        _topHostName.textColor = UIColor.whiteColor;
        _topHostName.font = [UIFont systemFontOfSize:14];
    }
    return _topHostName;
}

- (UILabel *)topAwayName{
    if (!_topAwayName) {
        _topAwayName = [UILabel new];
        _topAwayName.text = @"BOS";
        _topAwayName.textColor = UIColor.whiteColor;
        _topAwayName.font = [UIFont systemFontOfSize:14];
    }
    return _topAwayName;
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

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setTitle:@"观看动画" forState:UIControlStateNormal];
        [_playButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _playButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _playButton.backgroundColor = rgba(255, 255, 255, 0.25);
        _playButton.layer.borderColor = rgba(255, 255, 255, 0.1).CGColor;
        _playButton.layer.borderWidth = 0.5;
        _playButton.layer.cornerRadius = 12;
        _playButton.layer.masksToBounds = YES;
        [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
        _playButton.hidden = true;
    }
    return _playButton;
}

- (UIImageView *)hostLogo {
    if (!_hostLogo) {
        _hostLogo = [[UIImageView alloc] init];
        _hostLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo {
    if (!_awayLogo) {
        _awayLogo = [[UIImageView alloc] init];
        _awayLogo.image = [UIImage imageNamed:@"match_team_logo"];
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

- (QYZYMatchViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QYZYMatchViewModel alloc] init];
    }
    return _viewModel;
}

- (WKWebView *)webView {
    if (!_webView) {
        CGFloat width = CGRectGetWidth(self.view.bounds);
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, width, 9.0/16.0*width) configuration:[[WKWebViewConfiguration alloc] init]];
        _webView.hidden = YES;
    }
    return _webView;
}

- (AXMatchBetViewController *)betVC{
    if (!_betVC) {
        _betVC = [[AXMatchBetViewController alloc] init];
    }
    return _betVC;
}

- (AXMatchChatViewController *)chatVC {
    if (!_chatVC) {
        _chatVC = [[AXMatchChatViewController alloc] init];
    }
    return _chatVC;
}

- (AXMatchStandingsViewController *)standingsVC{
    if (!_standingsVC) {
        _standingsVC = [AXMatchStandingsViewController new];
    }
    return _standingsVC;
}

- (AXMatchLineupViewController *)lineupVC{
    if (!_lineupVC) {
        _lineupVC = [AXMatchLineupViewController new];
    }
    return _lineupVC;
}

- (AXMatchAnalysisViewController *)analysisVC{
    if (!_analysisVC) {
        _analysisVC = [AXMatchAnalysisViewController new];
    }
    return _analysisVC;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
        _categoryView.titles = self.titleArray;
        _categoryView.titleColor = rgb(17, 17, 17);
        _categoryView.titleSelectedColor = AXSelectColor;
        _categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _categoryView.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
        _categoryView.cellWidth = 54;
        _categoryView.cellSpacing = 0;
        _categoryView.backgroundColor = UIColor.whiteColor;
        _categoryView.listContainer = self.containerView;
        
        JXCategoryIndicatorLineView *indicator = [[JXCategoryIndicatorLineView alloc] init];
        indicator.indicatorColor = AXSelectColor;
        indicator.indicatorWidth = 30;
        indicator.indicatorHeight = 3;
        indicator.indicatorCornerRadius = 1.5;
        indicator.indicatorWidthIncrement = 0;
        indicator.verticalMargin = 2;
        _categoryView.indicators = @[indicator];
    }
    return _categoryView;
}

- (NSArray *)titleArray {
    return @[@"Bet",@"Chat",@"Standings", @"Lineup", @"Analysis"];
}

- (JXCategoryListContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    }
    return _containerView;
}

#pragma mark - help
- (NSString *)time_timestampToString:(NSInteger)timestamp{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    return string;
}

///比赛状态
- (NSString *)getStatusCode:(NSInteger)statusCode
                 timePlayed:(NSInteger)timePlayed
                  MatchTime:(NSNumber *)matchTime
                     status:(NSInteger)status
            detailModel:(QYZYMatchMainModel *)detailModel {
    if (!matchTime) {
        matchTime = @0;
    }
    if (timePlayed < 0) {
        timePlayed = 0;
    }
    NSString * statusString = @"未知";
    switch (statusCode) {
        case 0:
            statusString = @"未";
            break;
        case 1:
        {
            if ([detailModel.sportId isEqualToString:@"1"]) {
                NSInteger minute = 0;
                if (timePlayed == 0) {
                    NSInteger interval = [[NSDate date] timeIntervalSince1970];
                    minute = (interval - matchTime.integerValue / 1000.0) / 60;
                } else {
                    minute = ceilf(timePlayed / 60.0);
                }
                if (minute < 0) minute = 0;
                if (minute > 45) {
                    statusString = @"45+";
                } else {
                    statusString = [NSString stringWithFormat:@"%zd",minute];
                }
            } else {
                statusString = @"上半场";
            }
        }
            break;
        case 2:
        {
            if ([detailModel.sportId isEqualToString:@"1"]) {
                NSInteger minute = 0;
                if (timePlayed == 0) {
                    NSInteger interval = [[NSDate date] timeIntervalSince1970];
                    minute = (interval - matchTime.integerValue / 1000.0) / 60 - 15;
                } else {
                    minute = ceilf(timePlayed / 60.0);
                }
                if (minute > 90) {
                    statusString = @"90+";
                } else {
                    statusString = [NSString stringWithFormat:@"%zd",minute];
                }
            } else {
                statusString = @"下半场";
            }
        }
            break;
        case 10:
        {
            NSInteger interval = [[NSDate date] timeIntervalSince1970];
            NSInteger minute = (interval - matchTime.integerValue / 1000.0) / 60;
            if ([detailModel.sportId isEqualToString:@"1"]) {
                if (timePlayed != 0) {
                    minute = ceilf(timePlayed / 60.0);
                }
                statusString = [NSString stringWithFormat:@"%zd",minute];
                break;
            } else if ([detailModel.sportId isEqualToString:@"2"]) {
                if (minute <= 3) {
                    statusString = @"第一节";
                    break;
                }
            }
            statusString = @"进行中";
        }
            break;
        case 11:
        case 12:
        case 13:
        case 14:
            statusString = [NSString stringWithFormat:@"第%@节",[self numberToString:statusCode - 10]];
            break;
//        case XMMatchBallStatusOvertime:
        case 21:
        case 22:
            if ([detailModel.sportId isEqualToString:@"1"]) {
                NSInteger minute = 0;
                if (timePlayed == 0) {
                    NSInteger interval = [[NSDate date] timeIntervalSince1970];
                    minute = (interval - matchTime.integerValue / 1000.0) / 60 - 15;
                } else {
                    minute = ceilf(timePlayed / 60.0);
                }
                statusString = [NSString stringWithFormat:@"%zd",minute];
            }
            break;
        case 25:
            statusString = @"点球";
            break;
        case 30:
            statusString = @"暂停";
            break;
        case 31:
            statusString = @"中";
            break;
        case 35:
        case 36:
            statusString = @"点球";
            break;
        case 40:
            statusString = @"取消";
            break;
        case 41:
            statusString = @"延期";
            break;
        case 42:
            statusString = @"推迟";
            break;
        case 43:
            statusString = @"中断";
            break;
        case 100:
            statusString = @"完";
            break;
        case 404:
            statusString = @"未知";
            break;
        default:
            break;
    }
    
    if ([detailModel.sportId isEqualToString:@"2"]) {
        if (statusCode == 11 ||
            statusCode == 12 ||
            statusCode == 13 ||
            statusCode == 14 ||
            statusCode == 1 ||
            statusCode == 2 ||
            (statusCode == 20)) {
            NSInteger minute = (timePlayed) / 60.0;
            NSInteger second = (timePlayed) % 60;
            statusString = [NSString stringWithFormat:@"%@ %02ld:%02ld",statusString,minute,second];
        }
    }
    
    if (status == 3 ||
        statusCode == 100) {
        statusString = @"完";
    }
    return statusString;
}

- (NSString *)numberToString:(NSInteger)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];// 如果不设置locle 跟随系统语言
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    return [formatter stringFromNumber:[NSNumber numberWithInteger:number]];
}

- (AXMatchDetailRequest *)request{
    if (!_request) {
        _request = [AXMatchDetailRequest new];
    }
    return _request;
}

@end
