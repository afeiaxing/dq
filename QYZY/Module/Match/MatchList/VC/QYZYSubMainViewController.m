//
//  QYZYSubMainViewController.m
//  QYZY
//
//  Created by jspollo on 2022/10/13.
//

#import "QYZYSubMainViewController.h"
#import "QYZYMatchSubViewController.h"
#import "QYZYMatchViewModel.h"
#import "JXCategoryTitleBackgroundView.h"
#import "AXMatchListRequest.h"

@interface QYZYSubMainViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic ,strong) JXCategoryTitleBackgroundView *categoryView;
@property (nonatomic ,strong) JXCategoryListContainerView *containerView;
@property (nonatomic ,strong) QYZYMatchViewModel *viewModel;
@property (nonatomic ,strong) QYZYMatchSubViewController *allVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *resultVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *liveVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *scheduleVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *favoriteVC;
@property (nonatomic, strong) AXMatchListRequest *requestManager;
@property (nonatomic, strong) NSTimer *timer;
@end

#define kMatchListRefreshDuration 1500000000000

@implementation QYZYSubMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupSubViews];
    [self requestData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kMatchListRefreshDuration target:self selector:@selector(requestData) userInfo:nil repeats:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView *)listView {
    return self.view;
}

- (void)setupSubViews {
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.offset(0);
        make.height.mas_equalTo(48);
    }];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.categoryView.mas_bottom);
    }];
}

- (void)requestData {
    weakSelf(self);
    [self.allVC.view ax_showLoading];
    [self.requestManager requestMatchListWithcompletion:^(AXMatchListModel * _Nonnull matchModel) {
        [self.liveVC endRefresh];
        [self.resultVC endRefresh];
        [self.scheduleVC endRefresh];
        NSMutableArray *allModel = [NSMutableArray array];
        if (matchModel.live.count) {
            [allModel addObject:matchModel.live];
            self.liveVC.matches = @[matchModel.live];
        }
        if (matchModel.schedule.count) {
            [allModel addObject:matchModel.schedule];
            self.scheduleVC.matches = @[matchModel.schedule];
        }
        if (matchModel.result.count) {
            [allModel addObject:matchModel.result];
            self.resultVC.matches = @[matchModel.result];
        }
        self.allVC.matches = allModel.copy;
    }];
}

#pragma mark - delegate
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    return categoryView.selectedIndex != index;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        return self.allVC;
    } else if (index == 1) {
        return self.liveVC;
    } else if (index == 2) {
        return self.scheduleVC;
    } else if (index == 3) {
        return self.resultVC;
    } else {
        return self.favoriteVC;
    }
}

#pragma mark - get
- (JXCategoryTitleBackgroundView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleBackgroundView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
//        _categoryView.titles = @[@"All",@"Live",@"Scheduled",@"Result",@"Favorite"];
        _categoryView.titles = @[@"All",@"Live",@"Scheduled",@"Result"];
        _categoryView.titleColor = rgb(153, 153, 153);
        _categoryView.titleSelectedColor = rgb(255, 88, 0);
        _categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _categoryView.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _categoryView.cellWidth = 60;
        _categoryView.cellSpacing = 0;
        _categoryView.borderLineWidth = 1;
        _categoryView.selectedBorderColor = rgb(255, 88, 0);
        _categoryView.backgroundCornerRadius = 10;
//        _categoryView.backgroundColor = UIColor.whiteColor;
        _categoryView.listContainer = self.containerView;
        _categoryView.delegate = self;
        
//        JXCategoryIndicatorBackgroundView *indicator = [[JXCategoryIndicatorBackgroundView alloc] init];
//        indicator.indicatorColor = UIColor.whiteColor;
//        indicator.indicatorWidth = 78;
//        indicator.indicatorHeight = 28;
//        indicator.indicatorCornerRadius = 1;
//        indicator.indicatorWidthIncrement = 1;
//        _categoryView.indicators = @[indicator];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _containerView.listCellBackgroundColor = UIColor.clearColor;
        _containerView.scrollView.backgroundColor = UIColor.clearColor;
    }
    return _containerView;
}

- (QYZYMatchViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QYZYMatchViewModel alloc] init];
        _viewModel.matchType = self.matchType;
    }
    return _viewModel;
}

- (QYZYMatchSubViewController *)liveVC {
    if (!_liveVC) {
        _liveVC = [[QYZYMatchSubViewController alloc] init];
        _liveVC.status = AXMatchStatusLive;
        weakSelf(self);
        _liveVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _liveVC;
}

- (QYZYMatchSubViewController *)resultVC {
    if (!_resultVC) {
        _resultVC = [[QYZYMatchSubViewController alloc] init];
        _resultVC.status = AXMatchStatusResult;
        weakSelf(self);
        _resultVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _resultVC;
}

- (QYZYMatchSubViewController *)scheduleVC {
    if (!_scheduleVC) {
        _scheduleVC = [[QYZYMatchSubViewController alloc] init];
        _scheduleVC.status = AXMatchStatusSchedule;
        weakSelf(self);
        _scheduleVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _scheduleVC;
}

- (QYZYMatchSubViewController *)allVC {
    if (!_allVC) {
        _allVC = [[QYZYMatchSubViewController alloc] init];
        _allVC.status = AXMatchStatusAll;
        weakSelf(self);
        _allVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _allVC;
}

- (QYZYMatchSubViewController *)favoriteVC {
    if (!_favoriteVC) {
        _favoriteVC = [[QYZYMatchSubViewController alloc] init];
//        _favoriteVC.status = AXMatchStatusFavorite;
        weakSelf(self);
        _favoriteVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _favoriteVC;
}

- (AXMatchListRequest *)requestManager{
    if (!_requestManager) {
        _requestManager = [AXMatchListRequest new];
    }
    return _requestManager;
}

@end
