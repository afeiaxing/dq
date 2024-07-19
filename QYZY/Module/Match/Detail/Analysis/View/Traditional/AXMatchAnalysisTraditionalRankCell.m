//
//  AXMatchAnalysisTraditionalRankCell.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisTraditionalRankCell.h"
#import "AXSwitchView.h"
#import "AXMatchAnalysisTraditionalRankTipView.h"

@interface AXMatchAnalysisTraditionalRankCell()

@property (nonatomic, strong) UIView *BgView;

@property (nonatomic, strong) UILabel *rankTitleLabel;
@property (nonatomic, strong) UIButton *tipsBtn;
@property (nonatomic, strong) AXMatchAnalysisTraditionalRankTipView *tipsView;
@property (nonatomic, strong) AXSwitchView *switchView;
@property (nonatomic, strong) NSArray *rankTitles;
@property (nonatomic, strong) NSArray *hostRankDataLabels;
@property (nonatomic, strong) NSArray *awayRankDataLabels;

@end

@implementation AXMatchAnalysisTraditionalRankCell

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
    self.contentView.backgroundColor = rgb(247, 247, 247);
    
    [self.contentView addSubview:self.BgView];
    [self.BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.BgView addSubview:self.rankTitleLabel];
    [self.rankTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(23);
    }];
    
    [self.BgView addSubview:self.tipsBtn];
    [self.tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rankTitleLabel);
        make.left.equalTo(self.rankTitleLabel.mas_right).offset(9);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [self.BgView addSubview:self.tipsView];
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tipsBtn);
        make.top.equalTo(self.rankTitleLabel.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(170, 160));
    }];
    
    [self.BgView addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-19);
        make.centerY.equalTo(self.rankTitleLabel);
        make.size.mas_equalTo(CGSizeMake([AXSwitchView viewWidth], [AXSwitchView viewHeight]));
    }];
    
    CGFloat titleW = ScreenWidth / self.rankTitles.count;
    CGFloat titleH = 30;
    
    // rank title
    for (int i = 0; i < self.rankTitles.count; i++) {
        NSString *title = self.rankTitles[i];
        UILabel *rankTitleLabel = [self getLabel];
        rankTitleLabel.text = title;
        rankTitleLabel.backgroundColor = rgb(255, 247, 239);
        rankTitleLabel.font = AX_PingFangSemibold_Font(12);
        [self.BgView addSubview:rankTitleLabel];
        [rankTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rankTitleLabel.mas_bottom).offset(20);
            make.left.offset(titleW * i);
            make.size.mas_equalTo(CGSizeMake(titleW, titleH));
        }];
    }
    
    CGFloat rankDataH = 45;
    // host rank
    NSMutableArray *hostTemp = [NSMutableArray array];
    for (int i = 0; i < self.rankTitles.count; i++) {
        UILabel *rankHostLabel = [self getLabel];
        rankHostLabel.font = AX_PingFangMedium_Font(12);
        [self.BgView addSubview:rankHostLabel];
        [hostTemp addObject:rankHostLabel];
        [rankHostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rankTitleLabel.mas_bottom).offset(20 + titleH);
            make.left.offset(titleW * i);
            make.size.mas_equalTo(CGSizeMake(titleW, rankDataH));
        }];
    }
    self.hostRankDataLabels = hostTemp.copy;
    
    // away rank
    NSMutableArray *awayTemp = [NSMutableArray array];
    for (int i = 0; i < self.rankTitles.count; i++) {
        UILabel *rankAwayLabel = [self getLabel];
        rankAwayLabel.font = AX_PingFangMedium_Font(12);
        [self.BgView addSubview:rankAwayLabel];
        [awayTemp addObject:rankAwayLabel];
        [rankAwayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rankTitleLabel.mas_bottom).offset(20 + titleH + rankDataH);
            make.left.offset(titleW * i);
            make.size.mas_equalTo(CGSizeMake(titleW, rankDataH));
        }];
    }
    self.awayRankDataLabels = awayTemp.copy;
}

- (UILabel *)getLabel{
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)handleRankDataWithModel: (AXMatchAnalysisTeamRankModel *)model
                         labels: (NSArray *)label{
    if (label.count > 6) {
        UILabel *rank = label[0];
        rank.text = model.ranking;
        
        UILabel *teamName = label[1];
        teamName.text = model.teamName;
        
        UILabel *wl = label[2];
        wl.text = model.wl;
        
        UILabel *wp = label[3];
        wp.text = model.wp;
        
        UILabel *ave = label[4];
        ave.text = [NSString stringWithFormat:@"%.1f",  model.ave.floatValue];
        
        UILabel *al = label[5];
        al.text = [NSString stringWithFormat:@"%.1f",  model.al.floatValue];
        
        UILabel *status = label[6];
        status.text = model.status;
    }
}

- (void)handleTipsEvent{
    self.tipsView.hidden = false;
    [self.BgView bringSubviewToFront:self.tipsView];
}

// MARK: setter & setter
- (void)setTeamRankModel:(NSDictionary *)teamRankModel{
    AXMatchAnalysisTeamRankModel *hostModel = [teamRankModel valueForKey:@"hostModel"];
    AXMatchAnalysisTeamRankModel *awayModel = [teamRankModel valueForKey:@"awayModel"];
    if (hostModel) {
        [self handleRankDataWithModel:hostModel labels:self.hostRankDataLabels];
    }
    if (awayModel) {
        [self handleRankDataWithModel:awayModel labels:self.awayRankDataLabels];
    }
    
    _teamRankModel = teamRankModel;
}

- (UIView *)BgView{
    if (!_BgView) {
        _BgView = [UIView new];
        _BgView.backgroundColor = UIColor.whiteColor;
    }
    return _BgView;
}

- (UILabel *)rankTitleLabel {
    if (!_rankTitleLabel) {
        _rankTitleLabel = [[UILabel alloc] init];
        _rankTitleLabel.font = AX_PingFangSemibold_Font(16);
        _rankTitleLabel.textColor = rgb(17, 17, 17);
        _rankTitleLabel.text = @"Team Ranking";
    }
    return _rankTitleLabel;
}

- (UIButton *)tipsBtn{
    if (!_tipsBtn) {
        _tipsBtn = [UIButton new];
        [_tipsBtn setImage:[UIImage imageNamed:@"match_detail_tips"] forState:UIControlStateNormal];
        [_tipsBtn addTarget:self action:@selector(handleTipsEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipsBtn;
}

- (AXMatchAnalysisTraditionalRankTipView *)tipsView{
    if (!_tipsView) {
        _tipsView = [AXMatchAnalysisTraditionalRankTipView new];
        _tipsView.hidden = true;
    }
    return _tipsView;
}

- (AXSwitchView *)switchView{
    if (!_switchView) {
        _switchView = [AXSwitchView new];
        weakSelf(self)
        _switchView.block = ^(BOOL isValue) {
            strongSelf(self)
            !self.block ? : self.block(isValue);
        };
    }
    return _switchView;
}

- (NSArray *)rankTitles{
    return @[@"Rank", @"Team", @"W/L", @"WP", @"AVE", @"AL", @"Status"];
}


@end
