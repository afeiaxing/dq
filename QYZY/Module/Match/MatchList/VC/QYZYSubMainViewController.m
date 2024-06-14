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

@interface QYZYSubMainViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic ,strong) JXCategoryTitleBackgroundView *categoryView;
@property (nonatomic ,strong) JXCategoryListContainerView *containerView;
@property (nonatomic ,strong) QYZYMatchViewModel *viewModel;
@property (nonatomic ,strong) QYZYMatchSubViewController *allVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *resultVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *liveVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *scheduleVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *favoriteVC;

@property (nonatomic, assign) AXMatchStatus currentMatchStatus;

@end

@implementation QYZYSubMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.currentMatchStatus = AXMatchStatusAll;
    [self setupSubViews];
}

- (void)handleFilterDataWithLeagues: (NSString *)leagues{
    if (self.currentMatchStatus == AXMatchStatusAll) {
        [self.allVC handleFilterDataWithLeagues:leagues];
    } else if (self.currentMatchStatus == AXMatchStatusSchedule) {
        [self.scheduleVC handleFilterDataWithLeagues:leagues];
    } else if (self.currentMatchStatus == AXMatchStatusLive) {
        [self.liveVC handleFilterDataWithLeagues:leagues];
    } else if (self.currentMatchStatus == AXMatchStatusResult) {
        [self.resultVC handleFilterDataWithLeagues:leagues];
    }
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

#pragma mark - delegate
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    return categoryView.selectedIndex != index;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    self.currentMatchStatus = index;
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
//        weakSelf(self);
//        _liveVC.requestBlock = ^{
//            strongSelf(self);
//            [self requestData];
//        };
    }
    return _liveVC;
}

- (QYZYMatchSubViewController *)resultVC {
    if (!_resultVC) {
        _resultVC = [[QYZYMatchSubViewController alloc] init];
        _resultVC.status = AXMatchStatusResult;
//        weakSelf(self);
//        _resultVC.requestBlock = ^{
//            strongSelf(self);
//            [self requestData];
//        };
    }
    return _resultVC;
}

- (QYZYMatchSubViewController *)scheduleVC {
    if (!_scheduleVC) {
        _scheduleVC = [[QYZYMatchSubViewController alloc] init];
        _scheduleVC.status = AXMatchStatusSchedule;
//        weakSelf(self);
//        _scheduleVC.requestBlock = ^{
//            strongSelf(self);
//            [self requestData];
//        };
    }
    return _scheduleVC;
}

- (QYZYMatchSubViewController *)allVC {
    if (!_allVC) {
        _allVC = [[QYZYMatchSubViewController alloc] init];
        _allVC.status = AXMatchStatusAll;
//        weakSelf(self);
//        _allVC.requestBlock = ^{
//            strongSelf(self);
//            [self requestData];
//        };
    }
    return _allVC;
}

- (QYZYMatchSubViewController *)favoriteVC {
    if (!_favoriteVC) {
        _favoriteVC = [[QYZYMatchSubViewController alloc] init];
//        _favoriteVC.status = AXMatchStatusFavorite;
//        weakSelf(self);
//        _favoriteVC.requestBlock = ^{
//            strongSelf(self);
//            [self requestData];
//        };
    }
    return _favoriteVC;
}

@end
