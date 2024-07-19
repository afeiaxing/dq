//
//  AXMatchStandingPBPCell.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchStandingPBPCell.h"
#import "AXMatchStandingPBPView.h"
#import "AXMatchStandingPBPStatsView.h"

@interface AXMatchStandingPBPCell()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) UIView *colorBgView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *containerView;
@property (nonatomic, strong) AXMatchStandingPBPView *pbpView;
@property (nonatomic, strong) AXMatchStandingPBPStatsView *statsView;

@end

@implementation AXMatchStandingPBPCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubviews];
    }
    return self;
}

// MARK: private
- (void)setupSubviews{
    self.contentView.backgroundColor = rgb(247, 247, 247);
    
    [self.contentView addSubview:self.colorBgView];
    [self.colorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.colorBgView addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
        make.centerX.offset(0);
        make.top.offset(26);
        make.size.mas_equalTo(CGSizeMake(300, 36));
    }];
    
    [self.colorBgView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom).offset(23);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
}

// MARK: JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,FSCalendarDelegate
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    return categoryView.selectedIndex != index;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        return self.pbpView;
    }
    else {
        return self.statsView;
    }
}

// MARK: setter & setter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    self.statsView.matchModel = matchModel;
    self.pbpView.matchModel = matchModel;
    _matchModel = matchModel;
}

- (void)setTextLives:(NSDictionary *)textLives{
    self.pbpView.textLives = textLives;
    _textLives = textLives;
}

- (void)setStandingModel:(AXMatchStandingModel *)standingModel{
    self.statsView.standingModel = standingModel;
    _standingModel = standingModel;
}

- (UIView *)colorBgView{
    if (!_colorBgView) {
        _colorBgView = [UIView new];
        _colorBgView.backgroundColor = UIColor.whiteColor;
    }
    return _colorBgView;
}
- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
        _categoryView.titles = @[@"Play By Play",@"Statistics"];
        _categoryView.titleColor = rgb(0, 0, 0);
        _categoryView.titleSelectedColor = rgb(0, 0, 0);
        _categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        _categoryView.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        _categoryView.backgroundColor = rgba(118, 118, 128, 0.12);
        _categoryView.cellWidth = 100;
        _categoryView.cellSpacing = 0;
        _categoryView.delegate = self;
        _categoryView.layer.cornerRadius = 18;
        _categoryView.listContainer = self.containerView;
//        _categoryView.layer.masksToBounds = NO;
//        _categoryView.layer.cornerRadius = 4.0;
        
        JXCategoryIndicatorBackgroundView *indicator = [[JXCategoryIndicatorBackgroundView alloc] init];
        indicator.indicatorColor = rgb(255, 255, 255);
        indicator.indicatorWidth = 148;
        indicator.indicatorHeight = 32;
        indicator.indicatorCornerRadius = 16;
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
- (AXMatchStandingPBPView *)pbpView{
    if (!_pbpView) {
        _pbpView = [AXMatchStandingPBPView new];
    }
    return _pbpView;
}

- (AXMatchStandingPBPStatsView *)statsView{
    if (!_statsView) {
        _statsView = [AXMatchStandingPBPStatsView new];
    }
    return _statsView;
}


@end
