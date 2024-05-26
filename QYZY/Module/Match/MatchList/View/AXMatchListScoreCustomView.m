//
//  AXMatchListScoreCustomView.m
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import "AXMatchListScoreCustomView.h"

@interface AXMatchListScoreCustomView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *hostScore;
@property (nonatomic, strong) UILabel *awayScore;

@end

@implementation AXMatchListScoreCustomView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
        make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
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
            break;
        default:
            break;
    }
    
    self.hostScore.text = @"22";
    self.awayScore.text = @"13";
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
        _hostScore.font = [UIFont systemFontOfSize:12];
    }
    return _hostScore;
}

- (UILabel *)awayScore{
    if (!_awayScore) {
        _awayScore = [UILabel new];
        _awayScore.textColor = rgb(153, 153, 153);
        _awayScore.font = [UIFont systemFontOfSize:12];
    }
    return _awayScore;
}

@end
