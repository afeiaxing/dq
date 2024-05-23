//
//  AXMatchStandingChartCell.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchStandingChartCell.h"
#import "ORLineChartView.h"

@interface AXMatchStandingChartCell()<ORLineChartViewDataSource>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;

@property (nonatomic, strong) NSArray *chartDatas;
@property (nonatomic, strong) ORLineChartView *lineChartView;

@property (nonatomic, strong) UIView *scoreBGView;
@property (nonatomic, strong) UILabel *scoreTeamTitle;
@property (nonatomic, strong) UIView *scoreHostColorView;
@property (nonatomic, strong) UIView *scoreAwayColorView;
@property (nonatomic, strong) UILabel *scoreHostRanking;
@property (nonatomic, strong) UILabel *scoreAwayRanking;
@property (nonatomic, strong) UIImageView *scoreHostLogo;
@property (nonatomic, strong) UIImageView *scoreAwayLogo;
@property (nonatomic, strong) UILabel *scoreHostName;
@property (nonatomic, strong) UILabel *scoreAwayName;
@property (nonatomic, strong) UIView *scoreLineView;

@property (nonatomic, strong) NSArray *scoreTitleLabels;
@property (nonatomic, strong) NSArray *scoreHostLabels;
@property (nonatomic, strong) NSArray *scoreAwayLabels;


@end

#define kMatchStandingChartLeftMargin 78
#define kMatchStandingChartRightMargin 12
#define kMatchStandingChartHeight 104

@implementation AXMatchStandingChartCell

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
    
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.containerView addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.containerView addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(self.hostLogo);
        make.top.equalTo(self.hostLogo.mas_bottom).offset(20);
    }];
    
    [self.containerView addSubview:self.lineChartView];
    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.right.offset(-kMatchStandingChartRightMargin);
        make.left.offset(kMatchStandingChartLeftMargin);
        make.height.mas_equalTo(kMatchStandingChartHeight);
    }];
    
    [self.containerView addSubview:self.scoreBGView];
    [self.scoreBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hostLogo);
        make.right.equalTo(self.lineChartView);
        make.top.equalTo(self.lineChartView.mas_bottom).offset(16);
        make.height.mas_equalTo(114);
    }];
    
    [self.scoreBGView addSubview:self.scoreTeamTitle];
    [self.scoreTeamTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(16);
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
        make.top.equalTo(self.scoreHostColorView.mas_bottom).offset(11);
    }];
    
    [self.scoreBGView addSubview:self.scoreHostRanking];
    [self.scoreHostRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreHostColorView.mas_right).offset(11);
        make.centerY.equalTo(self.scoreHostColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreAwayRanking];
    [self.scoreAwayRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scoreHostRanking);
        make.centerY.equalTo(self.scoreAwayColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreHostLogo];
    [self.scoreHostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreHostRanking.mas_right).offset(11);
        make.centerY.equalTo(self.scoreHostColorView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.scoreBGView addSubview:self.scoreAwayLogo];
    [self.scoreAwayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.scoreHostLogo);
        make.centerY.equalTo(self.scoreAwayColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreHostName];
    [self.scoreHostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreHostLogo.mas_right).offset(11);
        make.centerY.equalTo(self.scoreHostColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreAwayName];
    [self.scoreAwayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scoreHostName);
        make.centerY.equalTo(self.scoreAwayColorView);
    }];
    
    [self.scoreBGView addSubview:self.scoreLineView];
    [self.scoreLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(self.scoreHostName.mas_right).offset(12);
        make.size.mas_equalTo(CGSizeMake(1, 80));
    }];
    
    [self setScores];
}

- (void)setScores{
    NSArray *score = @[@"1", @"2", @"12", @"12", @"0", @"2"];
    NSArray *awayScore = @[@"3", @"4", @"1", @"2", @"2", @"1"];
    NSInteger quarterCount = score.count;
    NSArray *quarterTitles;
    
    if (5 > quarterCount) {
        // 无加时
        quarterTitles = @[@"Q1", @"Q2", @"Q3", @"Q4", @"Tot."];
    } else if (quarterCount == 5) {
        // 加时1
        quarterTitles = @[@"Q1", @"Q2", @"Q3", @"Q4", @"OT1", @"Tot."];
    } else {
        // 加时2
        quarterTitles = @[@"Q1", @"Q2", @"Q3", @"Q4", @"OT1", @"OT2", @"Tot."];
    }
    
    NSArray *hostScores = [self handleScoreArray:score];
    NSArray *awayScores = [self handleScoreArray:awayScore];
    
    NSMutableArray *titleLabels = [NSMutableArray array];
    NSMutableArray *hostScoreLabels = [NSMutableArray array];
    NSMutableArray *awayScoreLabels = [NSMutableArray array];
    
    for (int i = 0; i < quarterTitles.count; i++) {
        // title
        NSString *title = quarterTitles[i];
        UILabel *titleLabel = [self getLabelWithText:title TextColor:AXUnSelectColor fontSize:12];
        [self.scoreBGView addSubview:titleLabel];
        [titleLabels addObject:titleLabel];
        
        BOOL isTotolScore = i == quarterTitles.count - 1;
        
        // host score
        NSString *hostScoreString = hostScores[i];
        UILabel *hostScoreLabel = [self getLabelWithText:hostScoreString TextColor:isTotolScore ? AXSelectColor : AXUnSelectColor fontSize:14];
        [self.scoreBGView addSubview:hostScoreLabel];
        [hostScoreLabels addObject:hostScoreLabel];
        
        // away score
        NSString *awayScoreString = awayScores[i];
        UILabel *awayScoreLabel = [self getLabelWithText:awayScoreString TextColor:isTotolScore ? AXSelectColor : AXUnSelectColor fontSize:14];
        [self.scoreBGView addSubview:awayScoreLabel];
        [awayScoreLabels addObject:awayScoreLabel];
    }
    
    [titleLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:126 tailSpacing:15];
    [titleLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16);
//        make.left.equalTo(self.scoreLineView).offset(15);
    }];
    
    [hostScoreLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:126 tailSpacing:15];
    [hostScoreLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(50);
    }];
    
    [awayScoreLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:126 tailSpacing:15];
    [awayScoreLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(84);
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

// 不足4节的，在得分数组里加“-”；和算出总分
- (NSArray *)handleScoreArray: (NSArray *)scores{
    NSMutableArray *temp = [NSMutableArray arrayWithArray:scores];
    while (temp.count < 4) {
        [temp addObject:@"-"];
    }
    
    NSInteger totalScore = 0;
    for (NSString *score in temp) {
        totalScore += [score isEqualToString:@"-"] ? 0 : score.integerValue;
    }
    
    [temp addObject:[NSString stringWithFormat:@"%ld", totalScore]];
    return temp.copy;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_lineChartView reloadData];


    return;
}

// MARK: ORLineChartViewDataSource
- (NSString *)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index{
    return @"";
}

- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView {
    return self.chartDatas.count;
}

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index {
    return [self.chartDatas[index] doubleValue];
}

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView {
    return 4;
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"value: %g", [self.chartDatas[index] doubleValue]]];
    return string;
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor redColor]};
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor blueColor]};
}

////custom left values
//- (CGFloat)chartView:(ORLineChartView *)chartView valueOfVerticalSeparateAtIndex:(NSInteger)index {
//    NSArray *number1 = @[@(0),@(0.2),@(0.4),@(0.6),@(0.8),@(0.10)];
//    return [number1[index] doubleValue];
//}


// MARK: setter & setter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;
}

- (UIImageView *)hostLogo{
    if (!_hostLogo) {
        _hostLogo = [UIImageView new];
        _hostLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo{
    if (!_awayLogo) {
        _awayLogo = [UIImageView new];
        _awayLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _awayLogo;
}

- (ORLineChartView *)lineChartView{
    if (!_lineChartView) {
        _lineChartView = [[ORLineChartView alloc] initWithFrame:CGRectZero];
        _lineChartView.config.gradientLocations = @[@(0.8), @(0.9)];
        _lineChartView.config.showShadowLine = false;
        _lineChartView.config.showVerticalBgline = false;
        _lineChartView.config.showHorizontalBgline = false;
        _lineChartView.config.bottomLabelWidth = (ScreenWidth - kMatchStandingChartLeftMargin - kMatchStandingChartRightMargin) / self.chartDatas.count;

        _lineChartView.dataSource = self;
    }
    return _lineChartView;
}

- (NSArray *)chartDatas{
    return @[@(1), @(3),@(5),@(4),@(6),@(7),@(9),@(0),@(-2),@(-4),@(-9),@(4),@(0),@(-2),@(5)];;
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
        _scoreTeamTitle.textColor = AXUnSelectColor;
    }
    return _scoreTeamTitle;
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

- (UILabel *)scoreHostRanking{
    if (!_scoreHostRanking) {
        _scoreHostRanking = [UILabel new];
        _scoreHostRanking.text = @"5";
        _scoreHostRanking.font = [UIFont systemFontOfSize:16];
        _scoreHostRanking.textColor = AXUnSelectColor;
    }
    return _scoreHostRanking;
}

- (UILabel *)scoreAwayRanking{
    if (!_scoreAwayRanking) {
        _scoreAwayRanking = [UILabel new];
        _scoreAwayRanking.text = @"2";
        _scoreAwayRanking.font = [UIFont systemFontOfSize:16];
        _scoreAwayRanking.textColor = AXUnSelectColor;
    }
    return _scoreAwayRanking;
}

- (UIImageView *)scoreHostLogo{
    if (!_scoreHostLogo) {
        _scoreHostLogo = [UIImageView new];
        _scoreHostLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _scoreHostLogo;
}

- (UIImageView *)scoreAwayLogo{
    if (!_scoreAwayLogo) {
        _scoreAwayLogo = [UIImageView new];
        _scoreAwayLogo.image = [UIImage imageNamed:@"match_team_logo"];
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
