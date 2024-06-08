//
//  AXMatchAnalysisTraditionalRankCell.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisTraditionalRankCell.h"

@interface AXMatchAnalysisTraditionalRankCell()

@property (nonatomic, strong) UIView *BgView;

@property (nonatomic, strong) UILabel *rankTitleLabel;
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

// MARK: private
- (void)setupSubviews{
    self.contentView.backgroundColor = rgb(247, 247, 247);
    
    [self.contentView addSubview:self.BgView];
    [self.BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.BgView addSubview:self.rankTitleLabel];
    [self.BgView addSubview:self.rankTitleLabel];
    [self.rankTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(23);
    }];
    
    CGFloat titleW = ScreenWidth / self.rankTitles.count;
    CGFloat titleH = 30;
    
    // rank title
    for (int i = 0; i < self.rankTitles.count; i++) {
        NSString *title = self.rankTitles[i];
        UILabel *rankTitleLabel = [self getLabel];
        rankTitleLabel.text = title;
        rankTitleLabel.backgroundColor = rgb(255, 247, 239);
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
    label.font = [UIFont systemFontOfSize:12];
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
        ave.text = model.ave;
        
        UILabel *al = label[5];
        al.text = model.al;
        
        UILabel *status = label[6];
        status.text = model.status;
    }
}

// MARK: setter & setter
- (void)setTeamRankModel:(NSArray<AXMatchAnalysisTeamRankModel *> *)teamRankModel{
    [self handleRankDataWithModel:teamRankModel.firstObject labels:self.hostRankDataLabels];
    [self handleRankDataWithModel:teamRankModel.lastObject labels:self.awayRankDataLabels];
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
        _rankTitleLabel.font = [UIFont systemFontOfSize:16];
        _rankTitleLabel.textColor = rgb(17, 17, 17);
        _rankTitleLabel.text = @"Team Ranking";
    }
    return _rankTitleLabel;
}

- (NSArray *)rankTitles{
    return @[@"Rank", @"Team", @"W/L", @"WP", @"AVE", @"AL", @"Status"];
}


@end
