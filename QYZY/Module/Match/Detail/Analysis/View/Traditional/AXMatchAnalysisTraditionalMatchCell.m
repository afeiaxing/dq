//
//  AXMatchAnalysisTraditionalMatchCell.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisTraditionalMatchCell.h"
#import "AXMatchAnalysisTraditionalMatchView.h"

@interface AXMatchAnalysisTraditionalMatchCell()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *containerView;

@property (nonatomic, strong) AXMatchAnalysisTraditionalMatchView *allView;
@property (nonatomic, strong) AXMatchAnalysisTraditionalMatchView *hostView;
@property (nonatomic, strong) AXMatchAnalysisTraditionalMatchView *awayView;

@end

@implementation AXMatchAnalysisTraditionalMatchCell

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
    // category
    [self.contentView addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.left.right.offset(0);
        make.height.mas_equalTo(36);
    }];
    
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom).offset(23);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    
}

// MARK: JXCategoryViewDelegate,JXCategoryListContainerViewDelegate
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    return categoryView.selectedIndex != index;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    !self.block ? : self.block((int)index);
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        return self.allView;
    } else if (index == 1) {
        return self.hostView;
    } else {
        return self.awayView;
    }
}

// MARK: setter & getter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    _matchModel = matchModel;
    self.allView.matchModel = matchModel;
    self.hostView.matchModel = matchModel;
    self.awayView.matchModel = matchModel;
}

- (void)setRivalryRecordModel:(AXMatchAnalysisRivalryRecordModel *)rivalryRecordModel{
    self.allView.rivalryRecordModel = rivalryRecordModel;
    _rivalryRecordModel = rivalryRecordModel;
}

- (void)setHostTeamRecordModel:(AXMatchAnalysisTeamRecordModel *)hostTeamRecordModel{
    self.hostView.teamRecordModel = hostTeamRecordModel;
    _hostTeamRecordModel = hostTeamRecordModel;
}

- (void)setAwayTeamRecordModel:(AXMatchAnalysisTeamRecordModel *)awayTeamRecordModel{
    self.awayView.teamRecordModel = awayTeamRecordModel;
    _awayTeamRecordModel = awayTeamRecordModel;
}

- (void)setIsRequest10:(BOOL)isRequest10{
    self.allView.isRequest10 = isRequest10;
    self.hostView.isRequest10 = isRequest10;
    self.awayView.isRequest10 = isRequest10;
    _isRequest10 = isRequest10;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
        _categoryView.titles = @[@"Rivalry Records", @"Home Records", @"Away Records"];
        _categoryView.titleColor = rgb(17, 17, 17);
        _categoryView.titleSelectedColor = AXSelectColor;
        _categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _categoryView.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
        _categoryView.cellWidth = 100;
        _categoryView.cellSpacing = 0;
        _categoryView.backgroundColor = UIColor.whiteColor;
        _categoryView.listContainer = self.containerView;
        _categoryView.delegate = self;
        
        JXCategoryIndicatorLineView *indicator = [[JXCategoryIndicatorLineView alloc] init];
        indicator.indicatorColor = AXSelectColor;
        indicator.indicatorWidth = 100;
        indicator.indicatorHeight = 3;
        indicator.indicatorCornerRadius = 1.5;
        indicator.indicatorWidthIncrement = 0;
        indicator.verticalMargin = 2;
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

- (AXMatchAnalysisTraditionalMatchView *)allView{
    if (!_allView) {
        _allView = [AXMatchAnalysisTraditionalMatchView new];
        _allView.viewType = AXMatchAnalysisTraditionalMatchViewType_all;
        _allView.isHost = true;
    }
    return _allView;
}

- (AXMatchAnalysisTraditionalMatchView *)hostView{
    if (!_hostView) {
        _hostView = [AXMatchAnalysisTraditionalMatchView new];
        _hostView.viewType = AXMatchAnalysisTraditionalMatchViewType_host;
        _hostView.isHost = true;
    }
    return _hostView;
}

- (AXMatchAnalysisTraditionalMatchView *)awayView{
    if (!_awayView) {
        _awayView = [AXMatchAnalysisTraditionalMatchView new];
        _awayView.viewType = AXMatchAnalysisTraditionalMatchViewType_away;
        _awayView.isHost = false;
    }
    return _awayView;
}


@end
