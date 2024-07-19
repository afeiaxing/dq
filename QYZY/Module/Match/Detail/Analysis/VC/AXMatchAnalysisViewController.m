//
//  AXMatchAnalysisViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchAnalysisViewController.h"
#import "AXMatchAnalysisTraditionalViewController.h"
#import "AXMatchAnalysisAdvancedViewController.h"

@interface AXMatchAnalysisViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *containerView;
@property (nonatomic, strong) AXMatchAnalysisTraditionalViewController *traditionalVC;
@property (nonatomic, strong) AXMatchAnalysisAdvancedViewController *advancedVC;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation AXMatchAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

// MARK: private
- (void)setupSubviews{
    self.view.backgroundColor = rgb(247, 247, 247);
    
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(10);
        make.size.mas_equalTo(CGSizeMake(300, 36));
    }];
    
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.containerView.scrollView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

// MARK: JXCategoryViewDelegate,JXCategoryListContainerViewDelegate
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    return categoryView.selectedIndex != index;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        return self.traditionalVC;
    } else {
        return self.advancedVC;
    }
}

// MARK: setter & setter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    _matchModel = matchModel;
    
    self.traditionalVC.matchModel = matchModel;
    self.advancedVC.matchModel = matchModel;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
        _categoryView.titles = @[@"Traditional",@"Advanced"];
        _categoryView.titleColor = rgb(0, 0, 0);
        _categoryView.titleSelectedColor = rgb(0, 0, 0);
        _categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        _categoryView.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        _categoryView.backgroundColor = rgba(118, 118, 128, 0.12);
        _categoryView.cellWidth = 100;
        _categoryView.cellSpacing = 0;
        _categoryView.delegate = self;
        _categoryView.layer.cornerRadius = 8;
        _categoryView.listContainer = self.containerView;
//        _categoryView.layer.masksToBounds = NO;
//        _categoryView.layer.cornerRadius = 4.0;
        
        JXCategoryIndicatorBackgroundView *indicator = [[JXCategoryIndicatorBackgroundView alloc] init];
        indicator.indicatorColor = rgb(255, 255, 255);
        indicator.indicatorWidth = 148;
        indicator.indicatorHeight = 32;
        indicator.indicatorCornerRadius = 7;
//        indicator.verticalMargin = 2;
        _categoryView.indicators = @[indicator];
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

- (AXMatchAnalysisTraditionalViewController *)traditionalVC{
    if (!_traditionalVC) {
        _traditionalVC = [AXMatchAnalysisTraditionalViewController new];
        weakSelf(self)
        _traditionalVC.scrollCallback = ^(UIScrollView *scrollView) {
            strongSelf(self)
            self.scrollCallback(scrollView);
        };
    }
    return _traditionalVC;
}

- (AXMatchAnalysisAdvancedViewController *)advancedVC{
    if (!_advancedVC) {
        _advancedVC = [AXMatchAnalysisAdvancedViewController new];
        weakSelf(self)
        _advancedVC.scrollCallback = ^(UIScrollView *scrollView) {
            strongSelf(self)
            self.scrollCallback(scrollView);
        };
    }
    return _advancedVC;
}

@end
