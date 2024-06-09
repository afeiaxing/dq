//
//  QYZYMatchDetailViewController.m
//  QYZY
//
//  Created by jspollo on 2022/10/13.
//

#import "QYZYMatchDetailViewController.h"
#import "AXMatchBetViewController.h"
#import "AXMatchChatViewController.h"
#import "AXMatchStandingsViewController.h"
#import "AXMatchLineupViewController.h"
#import "AXMatchAnalysisViewController.h"
#import "AXMatchDetailRequest.h"
#import "AXMatchDetailNavigationView.h"
#import "AXMatchDetailHeaderView.h"

@interface QYZYMatchDetailViewController ()<JXCategoryViewDelegate, JXPagerViewDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) AXMatchDetailNavigationView *topNavitionView;
@property (nonatomic, strong) AXMatchDetailHeaderView *headerView;

@property (nonatomic, strong) NSArray *childVcs;
@property (nonatomic, strong) AXMatchBetViewController *betVC;
@property (nonatomic, strong) AXMatchChatViewController *chatVC;
@property (nonatomic, strong) AXMatchStandingsViewController *standingsVC;
@property (nonatomic, strong) AXMatchLineupViewController *lineupVC;
@property (nonatomic, strong) AXMatchAnalysisViewController *analysisVC;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) AXMatchDetailRequest *request;

@end

@implementation QYZYMatchDetailViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
    self.view.backgroundColor = UIColor.blackColor;
    [self setupSubViews];
    [self setInitData];
    [self requestData];
}

- (void)setupSubViews {
    CGFloat kNavigationViewHeight = [AXMatchDetailNavigationView viewHeight];
    self.pagerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.pagerView.pinSectionHeaderVerticalOffset = kNavigationViewHeight;  // 控制pinView位置
    [self.view addSubview:self.pagerView];
    
    [self.view addSubview:self.topNavitionView];
    [self.topNavitionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(kNavigationViewHeight);
    }];
//    self.childVcs = @[self.betVC, self.chatVC, self.standingsVC, self.lineupVC, self.analysisVC];
    self.childVcs = @[self.standingsVC, self.lineupVC, self.analysisVC];
}

- (void)setInitData{
    self.topNavitionView.matchModel = self.matchModel;
    self.headerView.matchModel = self.matchModel;
    
    self.standingsVC.matchModel = self.matchModel;
    self.lineupVC.matchModel = self.matchModel;
    self.analysisVC.matchModel = self.matchModel;
    
}

- (void)requestData {
//    weakSelf(self);
    [self.request requestMatchDetailWithMatchId:self.matchModel.matchId completion:^(AXMatchDetailModel * _Nonnull matchModel) {
//        strongSelf(self)
        NSLog(@"%@", matchModel);
    }];
}

#pragma mark - delegate
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return [AXMatchDetailHeaderView viewHeight] + [AXMatchDetailNavigationView viewHeight];  // 控制HeaderView高度、同时控制categoryView位置
}

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 48;  // 控制categoryView高度
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.childVcs.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    return self.childVcs[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.childVcs.count;
}

#pragma mark - get
- (JXPagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[JXPagerView alloc] initWithDelegate:self listContainerType:JXPagerListContainerType_CollectionView];
        _pagerView.backgroundColor = UIColor.blackColor;
    }
    return _pagerView;
}

- (AXMatchDetailNavigationView *)topNavitionView{
    if (!_topNavitionView) {
        _topNavitionView = [AXMatchDetailNavigationView new];
        weakSelf(self)
        _topNavitionView.block = ^{
            strongSelf(self)
            [self.navigationController popViewControllerAnimated:true];
        };
    }
    return _topNavitionView;
}

- (AXMatchDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[AXMatchDetailHeaderView alloc] initWithFrame:CGRectMake(0, [AXMatchDetailNavigationView viewHeight], ScreenWidth, [AXMatchDetailHeaderView viewHeight])];
    }
    return _headerView;
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
        _categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
        
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
//    return @[@"Bet",@"Chat",@"Standings", @"Lineup", @"Analysis"];
    return @[@"Standings", @"Lineup", @"Analysis"];
}

- (AXMatchDetailRequest *)request{
    if (!_request) {
        _request = [AXMatchDetailRequest new];
    }
    return _request;
}

@end
