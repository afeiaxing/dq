//
//  QYZYMatchViewController.m
//  QYZY
//
//  Created by jspollo on 2022/10/12.
//

#import "QYZYMatchViewController.h"
#import "QYZYSubMainViewController.h"
#import "QYZYMatchCell.h"
#import "AXMatchFilterViewController.h"
#import "AXMatchSettingViewController.h"
#import "AXDataBaseViewController.h"

@interface QYZYMatchViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) UIView *categoryBgView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *containerView;
@property (nonatomic, strong) QYZYSubMainViewController *basketVC;
@property (nonatomic, strong) AXDataBaseViewController *dataBaseVC;

@property (nonatomic, strong) UIView *navigationLine;
@property (nonatomic, strong) UIButton *filterBtn;
@property (nonatomic, strong) UIButton *settingBtn;

@property (nonatomic, strong) NSString *filterString;

@end

@implementation QYZYMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    self.view.backgroundColor = rgb(248, 249, 254);
    self.fd_prefersNavigationBarHidden = true;
    
    [self.view addSubview:self.categoryBgView];
    [self.categoryBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(90);
    }];
    
    [self.categoryBgView addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.bottom.offset(-1);
        make.size.mas_equalTo(CGSizeMake(240, 32));
    }];
    
    [self.categoryBgView addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.width.height.mas_equalTo(28);
        make.centerY.equalTo(self.categoryView);
    }];
    
    [self.categoryBgView addSubview:self.filterBtn];
    [self.filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.settingBtn.mas_left).offset(-12);
        make.right.offset(-12);
        make.width.height.mas_equalTo(28);
        make.centerY.equalTo(self.categoryView);
    }];

    [self.categoryBgView addSubview:self.navigationLine];
    [self.navigationLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.categoryBgView.mas_bottom);
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
        return self.basketVC;
    } else {
        return self.dataBaseVC;
    }
}

// MARK: private
- (void)handleFilterBtnEvent{
    AXMatchFilterViewController *vc = [AXMatchFilterViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.block = ^(BOOL isSelectAll, NSArray * _Nonnull selectLeagues) {
        if (isSelectAll) {
            self.filterString = nil;
        } else {
            NSMutableString *str = [NSMutableString string];
            
            for (NSString *leagueName in selectLeagues) {
                [str appendFormat:@"%@,@,", leagueName];
            }
            
            if (str.length) {
                [str replaceCharactersInRange:NSMakeRange(str.length - 3, 3) withString:@""];
            }
            
            self.filterString = str.copy;
        }
        
        [self.basketVC handleFilterDataWithLeagues:self.filterString];
    };
    [self.navigationController pushViewController:vc animated:true];
}

- (void)handleSettingBtnEvent{
    AXMatchSettingViewController *vc = [AXMatchSettingViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:true];
}

// MARK: setter & getter
- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
        _categoryView.titles = @[@"BASKETBALL",@"LEAGUES"];
        _categoryView.titleColor = AXUnSelectColor;
        _categoryView.titleSelectedColor = rgb(17, 17, 17);
        _categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _categoryView.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
        _categoryView.cellWidth = 100;
        _categoryView.cellSpacing = 0;
        _categoryView.delegate = self;
        _categoryView.listContainer = self.containerView;
        _categoryView.backgroundColor = UIColor.whiteColor;//rgb(12, 35, 137);
//        _categoryView.layer.masksToBounds = NO;
//        _categoryView.layer.cornerRadius = 4.0;
        
        JXCategoryIndicatorLineView *indicator = [[JXCategoryIndicatorLineView alloc] init];
        indicator.indicatorColor = rgb(255, 88, 0);
        indicator.indicatorWidth = 105;
        indicator.indicatorHeight = 4;
//        indicator.indicatorCornerRadius = 1.5;
        indicator.indicatorWidthIncrement = 0;
//        indicator.verticalMargin = 2;
//        JXCategoryIndicatorBackgroundView *indicator = [[JXCategoryIndicatorBackgroundView alloc] init];
//        indicator.indicatorColor = rgb(254, 254, 255);
//        indicator.indicatorWidth = 87;
//        indicator.indicatorHeight = 28;
//        indicator.indicatorCornerRadius = 4;
//        indicator.indicatorWidthIncrement = 0;
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

- (AXDataBaseViewController *)dataBaseVC{
    if (!_dataBaseVC) {
        _dataBaseVC = [AXDataBaseViewController new];
    }
    return _dataBaseVC;
}

- (QYZYSubMainViewController *)basketVC {
    if (!_basketVC) {
        _basketVC = [[QYZYSubMainViewController alloc] init];
//        _basketVC.matchType = QYZYMatchTypeBasketball;
    }
    return _basketVC;
}

- (UIView *)categoryBgView{
    if (!_categoryBgView) {
        _categoryBgView = [UIView new];
        _categoryBgView.backgroundColor = UIColor.whiteColor;
    }
    return _categoryBgView;
}

- (UIView *)navigationLine{
    if (!_navigationLine) {
        _navigationLine = [[UIView alloc] init];
        _navigationLine.backgroundColor = rgba(231, 232, 241, 1);
    }
    return _navigationLine;
}

- (UIButton *)filterBtn{
    if (!_filterBtn) {
        _filterBtn = [UIButton new];
        [_filterBtn setImage:[UIImage imageNamed:@"match_filter"] forState:UIControlStateNormal];
        [_filterBtn addTarget:self action:@selector(handleFilterBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterBtn;
}

- (UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [UIButton new];
        [_settingBtn setImage:[UIImage imageNamed:@"match_setting"] forState:UIControlStateNormal];
        _settingBtn.hidden = true;
        [_settingBtn addTarget:self action:@selector(handleSettingBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

@end
