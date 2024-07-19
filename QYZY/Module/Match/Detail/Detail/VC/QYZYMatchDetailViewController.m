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
#import "AXMatchListRequest.h"
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
@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) AXMatchListRequest *request;

@end

#define kAXMatchDetailHeaderRefreshDuration 30

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
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kAXMatchDetailHeaderRefreshDuration target:self selector:@selector(requestData) userInfo:nil repeats:YES];
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
    weakSelf(self);
    [self.request requestBatchMatchWithMatchId:self.matchModel.matchId completion:^(NSArray<AXMatchListItemModel *> * _Nonnull matchArray) {
        if (matchArray && matchArray.count) {
            strongSelf(self)
            self.matchModel = matchArray.firstObject;
            [self setInitData];
        }
    }];
    
    AXLog(@"~~~赛事详情：header接口调用");
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

- (JXCategoryTitleImageView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
        _categoryView.titles = self.titleArray;
        _categoryView.imageNames = @[@"match_detail_tab_icon1", @"match_detail_tab_icon3", @"match_detail_tab_icon5"];
        _categoryView.selectedImageNames = @[@"match_detail_tab_icon2", @"match_detail_tab_icon4", @"match_detail_tab_icon6"];
        _categoryView.imageSize = CGSizeMake(12, 12);
        _categoryView.titleColor = rgb(17, 17, 17);
        _categoryView.titleSelectedColor = AXSelectColor;
        _categoryView.titleFont = AX_PingFangRegular_Font(14);
        _categoryView.titleSelectedFont = AX_PingFangSemibold_Font(14);
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

- (AXMatchListRequest *)request{
    if (!_request) {
        _request = [AXMatchListRequest new];
    }
    return _request;
}

@end
