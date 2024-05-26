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
@property (nonatomic ,strong) UILabel *scoreLabel;

@property (nonatomic ,strong) UIButton *backButton;

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
    if (self.matchModel.leaguesStatus.intValue == 1) {
        self.timeLabel.text = [NSString axTimestampToDate:self.matchModel.matchTime format:@"HH:mm"];
    } else if (self.matchModel.leaguesStatus.intValue == 10) {
        self.timeLabel.text = @"End";
    } else {
        int min = self.matchModel.residualTime.intValue / 60;
        int second = self.matchModel.residualTime.intValue % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%@ %d:%d", [AXMatchTools handleMatchStatusText:self.matchModel.leaguesStatus.intValue], min, second];
    }
    
    [self.topHostLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.topHostName.text = self.matchModel.homeTeamName;
    [self.topAwayLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.topAwayName.text = self.matchModel.awayTeamName;
    
    self.hostName.text = self.matchModel.homeTeamName;
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.awayName.text = self.matchModel.awayTeamName;
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:self.matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@ - %@",self.matchModel.homeTotalScore ?: @"0", self.matchModel.awayTotalScore ?: @"0"];
    
    self.standingsVC.matchModel = self.matchModel;
    self.lineupVC.matchModel = self.matchModel;
    self.analysisVC.matchModel = self.matchModel;
    
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
    [self.navigationController popViewControllerAnimated:YES];
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

- (AXMatchDetailRequest *)request{
    if (!_request) {
        _request = [AXMatchDetailRequest new];
    }
    return _request;
}

@end
