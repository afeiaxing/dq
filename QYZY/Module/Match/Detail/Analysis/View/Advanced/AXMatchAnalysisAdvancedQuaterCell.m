//
//  AXMatchAnalysisAdvancedQuaterCell.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisAdvancedQuaterCell.h"
#import "AXSwitchView.h"

@interface AXMatchAnalysisAdvancedQuaterCell()

@property (nonatomic, strong) UIView *BgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) AXSwitchView *switchView;

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

@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, strong) NSMutableArray *hostScoreLabels;
@property (nonatomic, strong) NSMutableArray *hostLossLabels;
@property (nonatomic, strong) NSMutableArray *awayScoreLabels;
@property (nonatomic, strong) NSMutableArray *awayLossLabels;


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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(22);
        make.left.offset(15);
    }];
    
    [self.BgView addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-19);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake([AXSwitchView viewWidth], [AXSwitchView viewHeight]));
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
        make.width.mas_equalTo(60);
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
        make.width.equalTo(self.scoreHostName);
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
}

- (UILabel *)getLabelWithText: (NSString *)text
                    TextColor: (UIColor *)textColor
                         font: (UIFont *)font{
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
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

- (void)handleRemoveSubView: (NSMutableArray *)array{
    for (UILabel *label in array) {
        [label removeFromSuperview];
    }
    [array removeAllObjects];
}


- (void)handleSetAttributedWithLabel: (UILabel *)label
                          playerName: (NSString *)playerName
                            playerNo: (NSString *)playerNo{
    // 创建NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    // 创建第一段文字的属性
    NSString *firstString = playerName;
    NSDictionary *firstAttributes = @{
        NSForegroundColorAttributeName: rgb(130, 134, 163),
        NSFontAttributeName: AX_PingFangSemibold_Font(8)
    };
    NSAttributedString *firstAttributedString = [[NSAttributedString alloc] initWithString:firstString attributes:firstAttributes];
    
    // 创建第二段文字的属性
    NSString *secondString = [NSString stringWithFormat:@"%@", playerNo];
    NSDictionary *secondAttributes = @{
        NSForegroundColorAttributeName: rgb(130, 134, 163),
        NSFontAttributeName: AX_PingFangSemibold_Font(14)
    };
    NSAttributedString *secondAttributedString = [[NSAttributedString alloc] initWithString:secondString attributes:secondAttributes];
    
    // 将两段文字添加到NSMutableAttributedString中
    [attributedString appendAttributedString:firstAttributedString];
    [attributedString appendAttributedString:secondAttributedString];
    
    // 将富文本赋值给UILabel
    label.attributedText = attributedString;
}

// MARK: setter & getter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    [self.scoreHostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.scoreAwayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.scoreHostName.text = matchModel.homeTeamName;
    self.scoreAwayName.text = matchModel.awayTeamName;
    _matchModel = matchModel;
}

- (void)setAdvancedModel:(AXMatchAnalysisAdvancedModel *)advancedModel{
    NSArray <AXMatchAnalysisAdvancedAlAveModel *> *homeAl = advancedModel.homeAl;
    NSArray <AXMatchAnalysisAdvancedAlAveModel *> *homeAve = advancedModel.homeAve;
    NSArray <AXMatchAnalysisAdvancedAlAveModel *> *awayAl = advancedModel.awayAl;
    NSArray <AXMatchAnalysisAdvancedAlAveModel *> *awayAve = advancedModel.awayAve;
    NSInteger quarterCount = homeAl.count;
    if (quarterCount == 0) {return;}
    if ((quarterCount != homeAve.count) || (quarterCount != awayAl.count) || (quarterCount != awayAve.count)) {
        return;
    }
    
    // 移除数组元素 & 复式图移除
    [self handleRemoveSubView:self.titleLabels];
    [self handleRemoveSubView:self.hostScoreLabels];
    [self handleRemoveSubView:self.hostLossLabels];
    [self handleRemoveSubView:self.awayScoreLabels];
    [self handleRemoveSubView:self.awayLossLabels];
    
    for (int i = 0; i < quarterCount; i++) {
        AXMatchAnalysisAdvancedAlAveModel *homeAlModel = homeAl[i];
        AXMatchAnalysisAdvancedAlAveModel *homeAveModel = homeAve[i];
        AXMatchAnalysisAdvancedAlAveModel *awayAlModel = awayAl[i];
        AXMatchAnalysisAdvancedAlAveModel *awayAveModel = awayAve[i];
        
        if (i == 0) {
            // 平均得失分的Label，可以在这里创建，而不在init里创建，待优化
            [self handleSetAttributedWithLabel:self.hostAverageScore playerName:@"Average Score\n" playerNo:homeAveModel.score];
            [self handleSetAttributedWithLabel:self.hostAverageLoss playerName:@"Average Loss\n" playerNo:homeAlModel.score];
            [self handleSetAttributedWithLabel:self.awayAverageScore playerName:@"Average Score\n" playerNo:awayAveModel.score];
            [self handleSetAttributedWithLabel:self.awayAverageLoss playerName:@"Average Loss\n" playerNo:awayAlModel.score];
        } else {
            // title
            UILabel *titleLabel = [self getLabelWithText:homeAlModel.name TextColor:rgb(130, 134, 163) font:AX_PingFangRegular_Font(10)];
            [self.scoreBGView addSubview:titleLabel];
            [self.titleLabels addObject:titleLabel];
            
            // host score
            NSString *hostScoreString = homeAveModel.score;
            UILabel *hostScoreLabel = [self getLabelWithText:hostScoreString TextColor:rgb(130, 134, 163) font:AX_PingFangMedium_Font(14)];
            [self.scoreBGView addSubview:hostScoreLabel];
            [self.hostScoreLabels addObject:hostScoreLabel];
            
            // host loss
            NSString *hostLossString = homeAlModel.score;
            UILabel *hostLossLabel = [self getLabelWithText:hostLossString TextColor:rgb(130, 134, 163) font:AX_PingFangMedium_Font(14)];
            [self.scoreBGView addSubview:hostLossLabel];
            [self.hostLossLabels addObject:hostLossLabel];
            
            // away score
            NSString *awayScoreString = awayAveModel.score;
            UILabel *awayScoreLabel = [self getLabelWithText:awayScoreString TextColor:rgb(130, 134, 163) font:AX_PingFangMedium_Font(14)];
            [self.scoreBGView addSubview:awayScoreLabel];
            [self.awayScoreLabels addObject:awayScoreLabel];
            
            // away loss
            NSString *awayLossString = awayAlModel.score;
            UILabel *awayLossLabel = [self getLabelWithText:awayLossString TextColor:rgb(130, 134, 163) font:AX_PingFangMedium_Font(14)];
            [self.scoreBGView addSubview:awayLossLabel];
            [self.awayLossLabels addObject:awayLossLabel];
        }
    }
    
    CGFloat leftMargin = 148;
    [self.titleLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:leftMargin tailSpacing:15];
    [self.titleLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scoreTeamTitle);
    }];
    
    [self.hostScoreLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:leftMargin tailSpacing:15];
    [self.hostScoreLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostAverageScore);
    }];
    
    [self.hostLossLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:leftMargin tailSpacing:15];
    [self.hostLossLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostAverageLoss);
    }];
    
    [self.awayScoreLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:leftMargin tailSpacing:15];
    [self.awayScoreLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awayAverageScore);
    }];
    
    [self.awayLossLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:leftMargin tailSpacing:15];
    [self.awayLossLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awayAverageLoss);
    }];
    
    _advancedModel = advancedModel;
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
        _titleLabel.font = AX_PingFangSemibold_Font(16);
        _titleLabel.textColor = rgb(17, 17, 17);
        _titleLabel.text = @"Single Quarter";
    }
    return _titleLabel;
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
        _scoreHostLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _scoreHostLogo;
}

- (UIImageView *)scoreAwayLogo{
    if (!_scoreAwayLogo) {
        _scoreAwayLogo = [UIImageView new];
        _scoreAwayLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _scoreAwayLogo;
}

- (UILabel *)scoreHostName{
    if (!_scoreHostName) {
        _scoreHostName = [UILabel new];
        _scoreHostName.font = AX_PingFangSemibold_Font(14);
        _scoreHostName.textAlignment = NSTextAlignmentCenter;
        _scoreHostName.textColor = rgb(17, 17, 17);
    }
    return _scoreHostName;
}

- (UILabel *)hostAverageScore{
    if (!_hostAverageScore) {
        _hostAverageScore = [UILabel new];
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
        _scoreAwayName.font = AX_PingFangSemibold_Font(14);
        _scoreAwayName.textAlignment = NSTextAlignmentCenter;
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

- (NSMutableArray *)titleLabels{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (NSMutableArray *)hostScoreLabels{
    if (!_hostScoreLabels) {
        _hostScoreLabels = [NSMutableArray array];
    }
    return _hostScoreLabels;
}

- (NSMutableArray *)hostLossLabels{
    if (!_hostLossLabels) {
        _hostLossLabels = [NSMutableArray array];
    }
    return _hostLossLabels;
}

- (NSMutableArray *)awayScoreLabels{
    if (!_awayScoreLabels) {
        _awayScoreLabels = [NSMutableArray array];
    }
    return _awayScoreLabels;
}

- (NSMutableArray *)awayLossLabels{
    if (!_awayLossLabels) {
        _awayLossLabels = [NSMutableArray array];
    }
    return _awayLossLabels;
}

@end
