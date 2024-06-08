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

@interface QYZYMatchDetailViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) AXMatchDetailNavigationView *topNavitionView;
@property (nonatomic, strong) AXMatchDetailHeaderView *headerView;

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
    [self.view addSubview:self.topNavitionView];
    [self.topNavitionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(StatusBarHeightConstant + NavigationBarHeight);
    }];
    
    CGFloat headerBGHeight = 204;
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.topNavitionView.mas_bottom);
        make.height.mas_equalTo(headerBGHeight);
    }];
    
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.categoryView.mas_bottom);
    }];
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

#pragma mark - get
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
        _headerView = [AXMatchDetailHeaderView new];
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
