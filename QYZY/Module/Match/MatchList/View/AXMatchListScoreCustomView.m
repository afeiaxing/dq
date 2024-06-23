//
//  AXMatchListScoreCustomView.m
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import "AXMatchListScoreCustomView.h"

@interface AXMatchListScoreCustomView()

@property (nonatomic, assign) CGFloat hostscoreTopMargin;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *hostScore;
@property (nonatomic, strong) UILabel *awayScore;

@end

@implementation AXMatchListScoreCustomView

// MARK: lifecycle
- (instancetype)initWithHostscoreTopMargin: (CGFloat)hostscoreTopMargin{
    if (self = [super init]) {
        self.hostscoreTopMargin = hostscoreTopMargin;
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.offset(0);
    }];
    
    [self addSubview:self.hostScore];
    [self.hostScore mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.hostscoreTopMargin != 0) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(self.hostscoreTopMargin);
        } else {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
        }
        make.centerX.offset(0);
    }];
    
    [self addSubview:self.awayScore];
    [self.awayScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.offset(0);
    }];
}

// MARK: setter & getter
- (void)setViewType:(AXMatchListScoreCustomViewType)viewType{
    _viewType = viewType;
    
    switch (viewType) {
        case AXMatchListScoreCustomViewQ1:
            self.titleLabel.text = @"Q1";
            break;
        case AXMatchListScoreCustomViewQ2:
            self.titleLabel.text = @"Q2";
            break;
        case AXMatchListScoreCustomViewQ3:
            self.titleLabel.text = @"Q3";
            break;
        case AXMatchListScoreCustomViewQ4:
            self.titleLabel.text = @"Q4";
            break;
        case AXMatchListScoreCustomViewOT:
            self.titleLabel.text = @"OT";
            break;
        case AXMatchListScoreCustomViewTot:
            self.titleLabel.text = @"Tot.";
            self.hostScore.textColor = AXSelectColor;
            self.awayScore.textColor = AXSelectColor;
            break;
        default:
            break;
    }
}

- (void)setMarketType:(AXMatchListScoreCustomMarketType)marketType{
    _marketType = marketType;
    switch (marketType) {
        case AXMatchListScoreCustomMarketTypeHandicap:
            self.titleLabel.text = @"Handicap";
            break;
        case AXMatchListScoreCustomMarketTypeOU:
            self.titleLabel.text = @"O/U";
            break;
        case AXMatchListScoreCustomMarketTypeMoneyline:
            self.titleLabel.text = @"Moneyline";
            break;
        default:
            break;
    }
}

- (void)setDatas:(NSArray *)datas{
    self.hostScore.text = datas.firstObject;
    self.awayScore.text = datas.lastObject;
}

- (void)setIsNeedHighlight:(BOOL)isNeedHighlight{
    self.hostScore.textColor = isNeedHighlight ? rgb(17, 17, 17) : rgb(153, 153, 153);
    self.awayScore.textColor = isNeedHighlight ? rgb(17, 17, 17) : rgb(153, 153, 153);
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = rgb(153, 153, 153);
        _titleLabel.font = [UIFont systemFontOfSize:8];
    }
    return _titleLabel;
}

- (UILabel *)hostScore{
    if (!_hostScore) {
        _hostScore = [UILabel new];
        _hostScore.textColor = rgb(153, 153, 153);
        _hostScore.font = AX_PingFangMedium_Font(12);
    }
    return _hostScore;
}

- (UILabel *)awayScore{
    if (!_awayScore) {
        _awayScore = [UILabel new];
        _awayScore.textColor = rgb(153, 153, 153);
        _awayScore.font = AX_PingFangMedium_Font(12);
    }
    return _awayScore;
}

@end
