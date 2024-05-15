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
@property (nonatomic ,strong) QYZYMatchSubViewController *finishedVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *goingVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *uncomingVC;
@property (nonatomic ,strong) QYZYMatchSubViewController *favoriteVC;
@end

@implementation QYZYSubMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupSubViews];
    [self requestData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:QYZYNetworkingFirstAvaliableNotification object:nil];
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
        make.left.right.top.equalTo(self.view);
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
    [self.viewModel requestMatchDataWithDateString:self.currentDateString completion:^(QYZYMatchModel * _Nonnull matchModel) {
        strongSelf(self);
        [self.goingVC endRefresh];
        [self.finishedVC endRefresh];
        [self.uncomingVC endRefresh];
        if (matchModel) {
            self.allVC.matches = matchModel.going.matches;
            self.goingVC.matches = matchModel.going.matches;
            self.finishedVC.matches = matchModel.finished.matches;
            self.uncomingVC.matches = matchModel.uncoming.matches;
            self.favoriteVC.matches = matchModel.going.matches;
        }
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
        return self.goingVC;
    } else if (index == 2) {
        return self.uncomingVC;
    } else if (index == 2) {
        return self.finishedVC;
    } else {
        return self.favoriteVC;
    }
}

#pragma mark - get
- (JXCategoryTitleBackgroundView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleBackgroundView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
        _categoryView.titles = @[@"All",@"Live",@"Scheduled",@"Result",@"Favorite"];
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

- (QYZYMatchSubViewController *)goingVC {
    if (!_goingVC) {
        _goingVC = [[QYZYMatchSubViewController alloc] init];
        weakSelf(self);
        _goingVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _goingVC;
}

- (QYZYMatchSubViewController *)finishedVC {
    if (!_finishedVC) {
        _finishedVC = [[QYZYMatchSubViewController alloc] init];
        weakSelf(self);
        _finishedVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _finishedVC;
}

- (QYZYMatchSubViewController *)uncomingVC {
    if (!_uncomingVC) {
        _uncomingVC = [[QYZYMatchSubViewController alloc] init];
        weakSelf(self);
        _uncomingVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _uncomingVC;
}

- (QYZYMatchSubViewController *)allVC {
    if (!_allVC) {
        _allVC = [[QYZYMatchSubViewController alloc] init];
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
        weakSelf(self);
        _favoriteVC.requestBlock = ^{
            strongSelf(self);
            [self requestData];
        };
    }
    return _favoriteVC;
}


@end
