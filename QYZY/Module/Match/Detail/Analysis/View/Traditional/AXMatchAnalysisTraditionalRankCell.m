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
@property (nonatomic, strong) NSArray *rankDatas;

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
    for (int i = 0; i < self.rankDatas.count; i++) {
        NSString *data = self.rankDatas[i];
        UILabel *rankHostLabel = [self getLabel];
        rankHostLabel.text = data;
        [self.BgView addSubview:rankHostLabel];
        [rankHostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rankTitleLabel.mas_bottom).offset(20 + titleH);
            make.left.offset(titleW * i);
            make.size.mas_equalTo(CGSizeMake(titleW, rankDataH));
        }];
    }
    
    // away rank
    for (int i = 0; i < self.rankDatas.count; i++) {
        NSString *data = self.rankDatas[i];
        UILabel *rankAwayLabel = [self getLabel];
        rankAwayLabel.text = data;
        [self.BgView addSubview:rankAwayLabel];
        [rankAwayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rankTitleLabel.mas_bottom).offset(20 + titleH + rankDataH);
            make.left.offset(titleW * i);
            make.size.mas_equalTo(CGSizeMake(titleW, rankDataH));
        }];
    }
}

- (UILabel *)getLabel{
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    return label;
}

// MARK: setter & setter
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

- (NSArray *)rankDatas{
    return @[@"10", @"Lakers", @"9/10", @"45.7%", @"111.2", @"118.3", @"2WS"];
}


@end
