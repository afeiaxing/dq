//
//  AXMatchAnalysisTraditionalMatchView.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisTraditionalMatchView.h"
#import "AXMatchAnalysisTraditionalPerformanceView.h"
#import "AXMatchAnalysisTraditionalMatchHistoryView.h"

@interface AXMatchAnalysisTraditionalMatchView()

@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;
@property (nonatomic, strong) UILabel *hostFlagLabel;
@property (nonatomic, strong) UILabel *awayFlagLabel;
@property (nonatomic, strong) UILabel *vsLabel;

@property (nonatomic, strong) AXMatchAnalysisTraditionalPerformanceView *performanceView;
@property (nonatomic, strong) AXMatchAnalysisTraditionalMatchHistoryView *historyView;
@property (nonatomic, strong) AXMatchAnalysisTraditionalMatchScheduleView *scheduleView;

@end

@implementation AXMatchAnalysisTraditionalMatchView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self;
}

// MARK: private
- (void)setupSubviews{
    [self addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.left.offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self addSubview:self.hostFlagLabel];
    [self.hostFlagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hostLogo);
        make.left.equalTo(self.hostLogo.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self addSubview:self.hostName];
    [self.hostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.hostLogo);
        make.left.equalTo(self.hostLogo.mas_right).offset(12);
        make.width.mas_equalTo(60);
    }];
    
    [self addSubview:self.vsLabel];
    [self.vsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.equalTo(self.hostLogo);
    }];
    
    [self addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.centerY.equalTo(self.hostName);
        make.width.equalTo(self.hostName);
    }];
    
    [self addSubview:self.awayFlagLabel];
    [self.awayFlagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awayName).offset(0);
        make.width.height.centerY.equalTo(self.hostFlagLabel);
    }];
    
    [self addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.hostLogo);
        make.right.equalTo(self.awayName.mas_left).offset(-12);
    }];
    
    [self addSubview:self.performanceView];
    [self.performanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hostLogo.mas_bottom).offset(26);
        make.left.right.offset(0);
        make.height.mas_equalTo(216);
    }];
    
    [self addSubview:self.historyView];
    [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset(0);
        make.top.equalTo(self.performanceView.mas_bottom).offset(20);
        make.height.mas_equalTo(360);
    }];
    
    [self addSubview:self.scheduleView];
    [self.scheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset(0);
        make.top.equalTo(self.historyView.mas_bottom).offset(0);
        make.height.mas_equalTo(266);
    }];
}

// MARK: setter & getter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    if (self.viewType != AXMatchAnalysisTraditionalMatchViewType_away) {
        [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
        self.hostName.text = matchModel.homeTeamName;
    } else {
        [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
        self.hostName.text = matchModel.awayTeamName;
    }
    
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.awayName.text = matchModel.awayTeamName;
    _matchModel = matchModel;
}

- (void)setViewType:(AXMatchAnalysisTraditionalMatchViewType)viewType{
    _viewType = viewType;
    
    if (viewType == AXMatchAnalysisTraditionalMatchViewType_all) {
        self.vsLabel.hidden = false;
        self.hostFlagLabel.text = @"H";
        // 设置1 = 主队，2 = 客队
    } else if (viewType == AXMatchAnalysisTraditionalMatchViewType_host) {
        self.vsLabel.hidden = true;
        self.hostFlagLabel.text = @"H";
        // 设置1 = 主队，2 隐藏
    } else {
        self.vsLabel.hidden = true;
        self.hostFlagLabel.text = @"A";
        // 设置1 = 客队，2 = 隐藏
    }
     
    self.awayLogo.hidden = viewType != AXMatchAnalysisTraditionalMatchViewType_all;
    self.awayName.hidden = viewType != AXMatchAnalysisTraditionalMatchViewType_all;
    self.awayFlagLabel.hidden = viewType != AXMatchAnalysisTraditionalMatchViewType_all;
    
    self.scheduleView.hidden = viewType == AXMatchAnalysisTraditionalMatchViewType_all;
    self.scheduleView.viewType = viewType;
}

// 设置两队历史交锋
- (void)setRivalryRecordModel:(AXMatchAnalysisRivalryRecordModel *)rivalryRecordModel{
    if (!rivalryRecordModel) {return;}
    self.performanceView.rivalryRecordModel = rivalryRecordModel;
    self.historyView.records = rivalryRecordModel.matchRecords;
    _rivalryRecordModel = rivalryRecordModel;
}

// 设置主队 / 客队 历史对阵 & 未来赛程
- (void)setTeamRecordModel:(AXMatchAnalysisTeamRecordModel *)teamRecordModel{
    if (!teamRecordModel) {return;}
    
    self.performanceView.teamRecordModel = teamRecordModel;
    self.historyView.records = teamRecordModel.matchRecords;
    self.scheduleView.scheduleMatchs = self.viewType == AXMatchAnalysisTraditionalMatchViewType_host ? teamRecordModel.homeSchedule : teamRecordModel.awaySchedule;
    
    _teamRecordModel = teamRecordModel;
}

- (void)setIsHost:(BOOL)isHost{
    self.performanceView.isHost = isHost;
    _isHost = isHost;
}

- (void)setIsRequest10:(BOOL)isRequest10{
    [self.historyView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(isRequest10 ? 560 : 360);
    }];
    
    self.performanceView.isRequest10 = isRequest10;
    _isRequest10 = isRequest10;
}

- (UIImageView *)hostLogo{
    if (!_hostLogo) {
        _hostLogo = [UIImageView new];
        _hostLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo{
    if (!_awayLogo) {
        _awayLogo = [UIImageView new];
        _awayLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _awayLogo;
}

- (UILabel *)hostName {
    if (!_hostName) {
        _hostName = [[UILabel alloc] init];
        _hostName.font = AX_PingFangSemibold_Font(14);
        _hostName.textColor = rgb(17, 17, 17);
    }
    return _hostName;
}

- (UILabel *)awayName {
    if (!_awayName) {
        _awayName = [[UILabel alloc] init];
        _awayName.font = AX_PingFangSemibold_Font(14);
        _awayName.textColor = rgb(17, 17, 17);
    }
    return _awayName;
}

- (UILabel *)hostFlagLabel {
    if (!_hostFlagLabel) {
        _hostFlagLabel = [[UILabel alloc] init];
        _hostFlagLabel.font = AX_PingFangMedium_Font(12);
        _hostFlagLabel.textColor = AXSelectColor;
        _hostFlagLabel.backgroundColor = rgb(255, 247, 349);
        _hostFlagLabel.textAlignment = NSTextAlignmentCenter;
        _hostFlagLabel.text = @"H";
        _hostFlagLabel.layer.cornerRadius = 4;
        _hostFlagLabel.layer.masksToBounds = true;
    }
    return _hostFlagLabel;
}

- (UILabel *)awayFlagLabel {
    if (!_awayFlagLabel) {
        _awayFlagLabel = [[UILabel alloc] init];
        _awayFlagLabel.font = AX_PingFangMedium_Font(12);
        _awayFlagLabel.textColor = AXSelectColor;
        _awayFlagLabel.backgroundColor = rgb(255, 247, 349);
        _awayFlagLabel.textAlignment = NSTextAlignmentCenter;
        _awayFlagLabel.text = @"A";
        _awayFlagLabel.layer.cornerRadius = 4;
        _awayFlagLabel.layer.masksToBounds = true;
    }
    return _awayFlagLabel;
}

- (UILabel *)vsLabel{
    if (!_vsLabel) {
        _vsLabel = [[UILabel alloc] init];
        _vsLabel.font = AX_PingFangSemibold_Font(16);
        _vsLabel.textColor = rgb(17, 17, 17);
        _vsLabel.text = @"VS";
    }
    return _vsLabel;
}

- (AXMatchAnalysisTraditionalPerformanceView *)performanceView{
    if (!_performanceView) {
        _performanceView = [AXMatchAnalysisTraditionalPerformanceView new];
    }
    return _performanceView;
}

- (AXMatchAnalysisTraditionalMatchHistoryView *)historyView{
    if (!_historyView) {
        _historyView = [AXMatchAnalysisTraditionalMatchHistoryView new];
    }
    return _historyView;
}

- (AXMatchAnalysisTraditionalMatchScheduleView *)scheduleView{
    if (!_scheduleView) {
        _scheduleView = [AXMatchAnalysisTraditionalMatchScheduleView new];
    }
    return _scheduleView;
}

@end
