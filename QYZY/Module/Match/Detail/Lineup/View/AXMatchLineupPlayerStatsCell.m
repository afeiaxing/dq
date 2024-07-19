//
//  AXMatchLineupPlayerStatsCell.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchLineupPlayerStatsCell.h"
#import "AXMatchLineupPlayerStatsView.h"
#import "AXMatchLineupPlayerStatsTipView.h"

@interface AXMatchLineupPlayerStatsCell()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) UILabel *statsTitleLabel;
@property (nonatomic, strong) UIButton *tipsBtn;
@property (nonatomic, strong) AXMatchLineupPlayerStatsTipView *tipsView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *containerView;
@property (nonatomic, strong) AXMatchLineupPlayerStatsView *hostPlayerStatsView;
@property (nonatomic, strong) AXMatchLineupPlayerStatsView *awayPlayerStatsView;

@end

@implementation AXMatchLineupPlayerStatsCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubviews];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tipsView.hidden = true;
}

// MARK: private
- (void)setupSubviews{
    [self.contentView addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(30);
        make.size.mas_equalTo(CGSizeMake(300, 36));
    }];
    
    [self.contentView addSubview:self.statsTitleLabel];
    [self.statsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.categoryView.mas_bottom).offset(30);
    }];
    
    [self.contentView addSubview:self.tipsBtn];
    [self.tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statsTitleLabel);
        make.left.equalTo(self.statsTitleLabel.mas_right).offset(9);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [self.contentView addSubview:self.tipsView];
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.statsTitleLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(293, 192));
    }];
    
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statsTitleLabel.mas_bottom).offset(26);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)handleTipsEvent{
    self.tipsView.hidden = false;
    [self.contentView bringSubviewToFront:self.tipsView];
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
        return self.hostPlayerStatsView;
    }
    else {
        return self.awayPlayerStatsView;
    }
}

// MARK: setter & setter
- (void)setLineupModel:(AXMatchLineupModel *)lineupModel{
    self.hostPlayerStatsView.playerStats = lineupModel.homePlayerStats;
    self.awayPlayerStatsView.playerStats = lineupModel.awayPlayerStats;
    _lineupModel = lineupModel;
}

- (UILabel *)statsTitleLabel {
    if (!_statsTitleLabel) {
        _statsTitleLabel = [[UILabel alloc] init];
        _statsTitleLabel.font = AX_PingFangSemibold_Font(16);
        _statsTitleLabel.textColor = rgb(17, 17, 17);
        _statsTitleLabel.text = @"Player Statistics";
    }
    return _statsTitleLabel;
}

- (UIButton *)tipsBtn{
    if (!_tipsBtn) {
        _tipsBtn = [UIButton new];
        [_tipsBtn setImage:[UIImage imageNamed:@"match_detail_tips"] forState:UIControlStateNormal];
        [_tipsBtn addTarget:self action:@selector(handleTipsEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipsBtn;
}

- (AXMatchLineupPlayerStatsTipView *)tipsView{
    if (!_tipsView) {
        _tipsView = [AXMatchLineupPlayerStatsTipView new];
        _tipsView.hidden = true;
    }
    return _tipsView;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
        _categoryView.titles = @[@"Home Stats",@"Away Stats"];
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

- (AXMatchLineupPlayerStatsView *)hostPlayerStatsView{
    if (!_hostPlayerStatsView) {
        _hostPlayerStatsView = [AXMatchLineupPlayerStatsView new];
    }
    return _hostPlayerStatsView;
}

- (AXMatchLineupPlayerStatsView *)awayPlayerStatsView{
    if (!_awayPlayerStatsView) {
        _awayPlayerStatsView = [AXMatchLineupPlayerStatsView new];
    }
    return _awayPlayerStatsView;
}


@end
