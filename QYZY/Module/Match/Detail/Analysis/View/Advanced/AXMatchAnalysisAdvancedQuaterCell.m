//
//  AXMatchAnalysisAdvancedQuaterCell.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisAdvancedQuaterCell.h"

@interface AXMatchAnalysisAdvancedQuaterCell()

@property (nonatomic, strong) UIView *BgView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *scoreBGView;
@property (nonatomic, strong) UILabel *scoreTeamTitle;
@property (nonatomic, strong) UILabel *wlLabel;
@property (nonatomic, strong) UIView *scoreHostColorView;
@property (nonatomic, strong) UIView *scoreAwayColorView;
@property (nonatomic, strong) UIImageView *scoreHostLogo;
@property (nonatomic, strong) UIImageView *scoreAwayLogo;
@property (nonatomic, strong) UILabel *scoreHostName;
@property (nonatomic, strong) UILabel *scoreAwayName;
@property (nonatomic, strong) UIView *scoreLineView;
@property (nonatomic, strong) UILabel *hostAverageScore;
@property (nonatomic, strong) UILabel *hostAverageLoss;
@property (nonatomic, strong) UILabel *awayAverageScore;
@property (nonatomic, strong) UILabel *awayAverageLoss;


@property (nonatomic, strong) NSArray *scoreTitleLabels;
@property (nonatomic, strong) NSArray *scoreHostLabels;


@end

@implementation AXMatchAnalysisAdvancedQuaterCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    self.contentView.backgroundColor = rgb(247, 247, 247);
    
    [self.contentView addSubview:self.BgView];
    [self.BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.BgView addSubview:self.titleLabel];
    [self.BgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(22);
        make.left.offset(15);
    }];
    
    
    [self.BgView addSubview:self.scoreBGView];
    [self.scoreBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
        make.left.offset(16);
        make.right.offset(-16);
        make.height.mas_equalTo(200);
    }];
    
    [self.scoreBGView addSubview:self.scoreTeamTitle];
    [self.scoreTeamTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(16);
    }];
    
    [self.scoreBGView addSubview:self.wlLabel];
    [self.wlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scoreTeamTitle);
        make.left.equalTo(self.scoreTeamTitle.mas_right).offset(15);
    }];

    [self.scoreBGView addSubview:self.scoreHostColorView];
    [self.scoreHostColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(50);
        make.size.mas_equalTo(CGSizeMake(6, 20));
    }];

    [self.scoreBGView addSubview:self.scoreAwayColorView];
    [self.scoreAwayColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.scoreHostColorView);
        make.top.equalTo(self.scoreHostColorView.mas_bottom).offset(58);
    }];

    [self.scoreBGView addSubview:self.scoreHostLogo];
    [self.scoreHostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreHostColorView.mas_right).offset(8);
        make.centerY.equalTo(self.scoreHostColorView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];

    [self.scoreBGView addSubview:self.scoreHostName];
    [self.scoreHostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreHostLogo.mas_bottom).offset(11);
        make.centerX.equalTo(self.scoreHostLogo);
    }];
    
    [self.scoreBGView addSubview:self.hostAverageScore];
    [self.hostAverageScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wlLabel.mas_bottom).offset(11);
        make.centerX.equalTo(self.wlLabel);
    }];
    
    [self.scoreBGView addSubview:self.hostAverageLoss];
    [self.hostAverageLoss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hostAverageScore.mas_bottom).offset(6);
        make.centerX.equalTo(self.wlLabel);
    }];

    [self.scoreBGView addSubview:self.scoreLineView];
    [self.scoreLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.scoreHostName.mas_bottom).offset(14);
        make.height.mas_equalTo(1);
    }];

    [self.scoreBGView addSubview:self.scoreAwayLogo];
    [self.scoreAwayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.scoreHostLogo);
        make.top.equalTo(self.scoreLineView).offset(14);
    }];

    [self.scoreBGView addSubview:self.scoreAwayName];
    [self.scoreAwayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scoreAwayLogo);
        make.top.equalTo(self.scoreAwayLogo.mas_bottom).offset(11);
    }];
    
    [self.scoreBGView addSubview:self.awayAverageScore];
    [self.awayAverageScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreLineView.mas_bottom).offset(11);
        make.centerX.equalTo(self.wlLabel);
    }];
    
    [self.scoreBGView addSubview:self.awayAverageLoss];
    [self.awayAverageLoss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.awayAverageScore.mas_bottom).offset(6);
        make.centerX.equalTo(self.wlLabel);
    }];
    
    [self setScores];
}

// 此处的代码是从standing页面拷贝过来，逻辑待优化
- (void)setScores{
    NSArray *hostScore = @[@"1", @"2", @"12", @"12", @"0", @"2"];
    NSArray *hostLoss = @[@"11", @"12", @"2", @"21", @"10", @"21"];
    NSArray *awayScore = @[@"3", @"4", @"11", @"2", @"12", @"1"];
    NSArray *awayLoss = @[@"31", @"14", @"1", @"12", @"2", @"11"];
    
    NSInteger quarterCount = hostScore.count;
    NSArray *quarterTitles;
    
    if (5 > quarterCount) {
        // 无加时
        quarterTitles = @[@"Q1", @"Q2", @"Q3", @"Q4"];
    } else if (quarterCount == 5) {
        // 加时1
        quarterTitles = @[@"Q1", @"Q2", @"Q3", @"Q4", @"OT1"];
    } else {
        // 加时2
        quarterTitles = @[@"Q1", @"Q2", @"Q3", @"Q4", @"OT1", @"OT2"];
    }
    
    NSArray *hostScores = hostScore;// [self handleScoreArray:score];
    NSArray *awayScores = awayScore;// [self handleScoreArray:awayScore];
    
    NSMutableArray *titleLabels = [NSMutableArray array];
    NSMutableArray *hostScoreLabels = [NSMutableArray array];
    NSMutableArray *hostLossLabels = [NSMutableArray array];
    NSMutableArray *awayScoreLabels = [NSMutableArray array];
    NSMutableArray *awayLossLabels = [NSMutableArray array];
    
    for (int i = 0; i < quarterTitles.count; i++) {
        // title
        NSString *title = quarterTitles[i];
        UILabel *titleLabel = [self getLabelWithText:title TextColor:rgb(130, 134, 163) fontSize:12];
        [self.scoreBGView addSubview:titleLabel];
        [titleLabels addObject:titleLabel];
        
        // host score
        NSString *hostScoreString = hostScores[i];
        UILabel *hostScoreLabel = [self getLabelWithText:hostScoreString TextColor:rgb(130, 134, 163) fontSize:14];
        [self.scoreBGView addSubview:hostScoreLabel];
        [hostScoreLabels addObject:hostScoreLabel];
        
        // host loss
        NSString *hostLossString = hostLoss[i];
        UILabel *hostLossLabel = [self getLabelWithText:hostLossString TextColor:rgb(130, 134, 163) fontSize:14];
        [self.scoreBGView addSubview:hostLossLabel];
        [hostLossLabels addObject:hostLossLabel];
        
        // away score
        NSString *awayScoreString = awayScores[i];
        UILabel *awayScoreLabel = [self getLabelWithText:awayScoreString TextColor:rgb(130, 134, 163) fontSize:14];
        [self.scoreBGView addSubview:awayScoreLabel];
        [awayScoreLabels addObject:awayScoreLabel];
        
        // away loss
        NSString *awayLossString = awayLoss[i];
        UILabel *awayLossLabel = [self getLabelWithText:awayLossString TextColor:rgb(130, 134, 163) fontSize:14];
        [self.scoreBGView addSubview:awayLossLabel];
        [awayLossLabels addObject:awayLossLabel];
    }
    
    CGFloat leftMargin = 148;
    [titleLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:leftMargin tailSpacing:15];
    [titleLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scoreTeamTitle);
    }];
    
    [hostScoreLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:leftMargin tailSpacing:15];
    [hostScoreLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostAverageScore);
    }];
    
    [hostLossLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:leftMargin tailSpacing:15];
    [hostLossLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostAverageLoss);
    }];
    
    [awayScoreLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:leftMargin tailSpacing:15];
    [awayScoreLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awayAverageScore);
    }];
    
    [awayLossLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:leftMargin tailSpacing:15];
    [awayLossLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awayAverageLoss);
    }];
}

- (UILabel *)getLabelWithText: (NSString *)text
                    TextColor: (UIColor *)textColor
                     fontSize: (CGFloat)fontSize{
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

// 不足4节的，在得分数组里加“-”
- (NSArray *)handleScoreArray: (NSArray *)scores{
    NSMutableArray *temp = [NSMutableArray arrayWithArray:scores];
    while (temp.count < 4) {
        [temp addObject:@"-"];
    }
    return temp.copy;
}

// MARK: setter & getter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    [self.scoreHostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.scoreAwayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    _matchModel = matchModel;
}

- (UIView *)BgView{
    if (!_BgView) {
        _BgView = [UIView new];
        _BgView.backgroundColor = UIColor.whiteColor;
    }
    return _BgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = rgb(17, 17, 17);
        _titleLabel.text = @"Single Quarter";
    }
    return _titleLabel;
}

- (UIView *)scoreBGView{
    if (!_scoreBGView) {
        _scoreBGView = [UIView new];
        _scoreBGView.backgroundColor = rgb(255, 247, 239);
        _scoreBGView.layer.cornerRadius = 8;
    }
    return _scoreBGView;
}

- (UILabel *)scoreTeamTitle{
    if (!_scoreTeamTitle) {
        _scoreTeamTitle = [UILabel new];
        _scoreTeamTitle.text = @"Team";
        _scoreTeamTitle.font = [UIFont systemFontOfSize:12];
        _scoreTeamTitle.textColor = rgb(130, 134, 163);
    }
    return _scoreTeamTitle;
}

- (UILabel *)wlLabel{
    if (!_wlLabel) {
        _wlLabel = [UILabel new];
        _wlLabel.text = @"W/L per game";
        _wlLabel.font = [UIFont systemFontOfSize:12];
        _wlLabel.textColor = rgb(130, 134, 163);
    }
    return _wlLabel;
}

- (UIView *)scoreHostColorView{
    if (!_scoreHostColorView) {
        _scoreHostColorView = [UIView new];
        _scoreHostColorView.backgroundColor = rgb(143, 0, 255);
        _scoreHostColorView.layer.cornerRadius = 4;
        _scoreHostColorView.layer.maskedCorners =  kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
    }
    return _scoreHostColorView;
}

- (UIView *)scoreAwayColorView{
    if (!_scoreAwayColorView) {
        _scoreAwayColorView = [UIView new];
        _scoreAwayColorView.backgroundColor = rgb(0, 162, 36);
        _scoreAwayColorView.layer.cornerRadius = 4;
        _scoreAwayColorView.layer.maskedCorners =  kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
    }
    return _scoreAwayColorView;
}

- (UIImageView *)scoreHostLogo{
    if (!_scoreHostLogo) {
        _scoreHostLogo = [UIImageView new];
    }
    return _scoreHostLogo;
}

- (UIImageView *)scoreAwayLogo{
    if (!_scoreAwayLogo) {
        _scoreAwayLogo = [UIImageView new];
    }
    return _scoreAwayLogo;
}

- (UILabel *)scoreHostName{
    if (!_scoreHostName) {
        _scoreHostName = [UILabel new];
        _scoreHostName.text = @"LAL";
        _scoreHostName.font = [UIFont systemFontOfSize:14];
        _scoreHostName.textColor = rgb(17, 17, 17);
    }
    return _scoreHostName;
}

- (UILabel *)hostAverageScore{
    if (!_hostAverageScore) {
        _hostAverageScore = [UILabel new];
        _hostAverageScore.text = @"Average Score \n 22.5";
        _hostAverageScore.font = [UIFont systemFontOfSize:12];
        _hostAverageScore.textColor = rgb(130, 134, 163);
        _hostAverageScore.numberOfLines = 2;
        _hostAverageScore.textAlignment = NSTextAlignmentCenter;
    }
    return _hostAverageScore;
}

- (UILabel *)hostAverageLoss{
    if (!_hostAverageLoss) {
        _hostAverageLoss = [UILabel new];
        _hostAverageLoss.text = @"Average Loss \n 12.5";
        _hostAverageLoss.font = [UIFont systemFontOfSize:12];
        _hostAverageLoss.textColor = rgb(130, 134, 163);
        _hostAverageLoss.numberOfLines = 2;
        _hostAverageLoss.textAlignment = NSTextAlignmentCenter;
    }
    return _hostAverageLoss;
}

- (UILabel *)awayAverageScore{
    if (!_awayAverageScore) {
        _awayAverageScore = [UILabel new];
        _awayAverageScore.text = @"Average Score \n 32.5";
        _awayAverageScore.font = [UIFont systemFontOfSize:12];
        _awayAverageScore.textColor = rgb(130, 134, 163);
        _awayAverageScore.numberOfLines = 2;
        _awayAverageScore.textAlignment = NSTextAlignmentCenter;
    }
    return _awayAverageScore;
}

- (UILabel *)awayAverageLoss{
    if (!_awayAverageLoss) {
        _awayAverageLoss = [UILabel new];
        _awayAverageLoss.text = @"Average Loss \n 24.5";
        _awayAverageLoss.font = [UIFont systemFontOfSize:12];
        _awayAverageLoss.textColor = rgb(130, 134, 163);
        _awayAverageLoss.numberOfLines = 2;
        _awayAverageLoss.textAlignment = NSTextAlignmentCenter;
    }
    return _awayAverageLoss;
}

- (UILabel *)scoreAwayName{
    if (!_scoreAwayName) {
        _scoreAwayName = [UILabel new];
        _scoreAwayName.text = @"BOS";
        _scoreAwayName.font = [UIFont systemFontOfSize:14];
        _scoreAwayName.textColor = rgb(17, 17, 17);
    }
    return _scoreAwayName;
}

- (UIView *)scoreLineView{
    if (!_scoreLineView) {
        _scoreLineView = [UIView new];
        _scoreLineView.backgroundColor = rgba(130, 134, 163, 0.5);
    }
    return _scoreLineView;
}

@end
