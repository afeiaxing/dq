//
//  AXMatchAnalysisTraditionalPerformanceView.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisTraditionalPerformanceView.h"

@interface AXMatchAnalysisTraditionalPerformanceView()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *winLabel;
@property (nonatomic, strong) UILabel *loseLabel;
@property (nonatomic, strong) UILabel *aveLabel;
@property (nonatomic, strong) UILabel *lLabel;
@property (nonatomic, strong) UILabel *moneylineLabel;
@property (nonatomic, strong) UILabel *ouLabel;

@end

@implementation AXMatchAnalysisTraditionalPerformanceView

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
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.bottom.offset(0);
    }];
    
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(22);
    }];
    
    [self.containerView addSubview:self.winLabel];
    [self.winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.width.mas_equalTo(187);
        make.height.mas_equalTo(30);
    }];
    
    [self.containerView addSubview:self.loseLabel];
    [self.loseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.centerY.height.equalTo(self.winLabel);
        make.left.equalTo(self.winLabel.mas_right).offset(5);
    }];
    
    [self.containerView addSubview:self.aveLabel];
    [self.containerView addSubview:self.lLabel];
    [self.containerView addSubview:self.moneylineLabel];
    [self.containerView addSubview:self.ouLabel];
    NSArray *labels = @[self.aveLabel, self.lLabel, self.moneylineLabel, _ouLabel];
    [labels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:20 tailSpacing:20];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.winLabel.mas_bottom).offset(29);
    }];
}

- (void)handleSetAttributedWithLabel: (UILabel *)label
                                str1: (NSString *)str1
                                str2: (NSString *)str2
                                str3: (NSString *)str3{
    // 创建NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    // 创建第一段文字的属性
    NSString *firstString = str1;
    NSDictionary *firstAttributes = @{
        NSForegroundColorAttributeName: UIColor.blackColor,
        NSFontAttributeName: AX_PingFangSemibold_Font(12)
    };
    NSAttributedString *firstAttributedString = [[NSAttributedString alloc] initWithString:firstString attributes:firstAttributes];
    
    // 创建第二段文字的属性
    NSString *secondString = [NSString stringWithFormat:@"\n\n%@", str2];
    NSDictionary *secondAttributes = @{
        NSForegroundColorAttributeName: UIColor.blackColor,
        NSFontAttributeName: AX_PingFangSemibold_Font(14)
    };
    NSAttributedString *secondAttributedString = [[NSAttributedString alloc] initWithString:secondString attributes:secondAttributes];
    
    // 创建第二段文字的属性
    NSString *thirdString = [NSString stringWithFormat:@"\n\n%@", str3];
    NSDictionary *thirdAttributes = @{
        NSForegroundColorAttributeName: rgb(130, 134, 163),
        NSFontAttributeName: AX_PingFangMedium_Font(12)
    };
    NSAttributedString *thirdAttributedString = [[NSAttributedString alloc] initWithString:thirdString attributes:thirdAttributes];
    
    // 将两段文字添加到NSMutableAttributedString中
    [attributedString appendAttributedString:firstAttributedString];
    [attributedString appendAttributedString:secondAttributedString];
    [attributedString appendAttributedString:thirdAttributedString];
    
    // 将富文本赋值给UILabel
    label.attributedText = attributedString;
}

// MARK: setter & getter
- (void)setRivalryRecordModel:(AXMatchAnalysisRivalryRecordModel *)rivalryRecordModel{
    CGFloat winlostTotalWidth = ScreenWidth - 16 * 4 - 5;
    CGFloat totalCount = rivalryRecordModel.win.floatValue + rivalryRecordModel.lose.floatValue;
    CGFloat winPrecent = rivalryRecordModel.win.floatValue / totalCount;
    // 兼容服务器返回异常数据，例如“-”，会导致算出的数值为“NaN”
    if (isnan(winPrecent)) {
        winPrecent = 0.5;
    }
    
    // 兼容全胜、全负的情况
    winPrecent = MIN(winPrecent, 0.9);
    winPrecent = MAX(winPrecent, 0.1);
    
    [self.winLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(winlostTotalWidth * winPrecent);
    }];
    
    self.winLabel.text = rivalryRecordModel.win.intValue == 0 ? @"0" : [NSString stringWithFormat:@"%@ Win", rivalryRecordModel.win];
    self.loseLabel.text = rivalryRecordModel.lose.intValue == 0 ? @"0" :  [NSString stringWithFormat:@"%@ Lose", rivalryRecordModel.lose];
    [self handleSetAttributedWithLabel:self.aveLabel str1:@"AVE" str2:rivalryRecordModel.ave str3:@"points"];
    [self handleSetAttributedWithLabel:self.lLabel str1:@"AL" str2:rivalryRecordModel.l str3:@"points"];
    [self handleSetAttributedWithLabel:self.moneylineLabel str1:@"Moneyline" str2:rivalryRecordModel.games str3:@"home win"];
    [self handleSetAttributedWithLabel:self.ouLabel str1:@"O/U" str2:rivalryRecordModel.point str3:@"Over"];
    _rivalryRecordModel = rivalryRecordModel;
}

- (void)setTeamRecordModel:(AXMatchAnalysisTeamRecordModel *)teamRecordModel{
    CGFloat winlostTotalWidth = ScreenWidth - 16 * 4 - 5;
    CGFloat totalCount = teamRecordModel.win.floatValue + teamRecordModel.lose.floatValue;
    CGFloat winPrecent = teamRecordModel.win.floatValue / totalCount;
    // 兼容服务器返回异常数据，例如“-”，会导致算出的数值为“NaN”
    if (isnan(winPrecent)) {
        winPrecent = 0.5;
    }
    
    // 兼容全胜、全负的情况
    winPrecent = MIN(winPrecent, 0.9);
    winPrecent = MAX(winPrecent, 0.1);
    
    [self.winLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(winlostTotalWidth * winPrecent);
    }];
    
    self.winLabel.text = teamRecordModel.win.intValue == 0 ? @"0" : [NSString stringWithFormat:@"%@ Win", teamRecordModel.win];
    self.loseLabel.text = teamRecordModel.lose.intValue == 0 ? @"0" : [NSString stringWithFormat:@"%@ Lose", teamRecordModel.lose];
    [self handleSetAttributedWithLabel:self.aveLabel str1:@"AVE" str2:teamRecordModel.ave str3:@"points"];
    [self handleSetAttributedWithLabel:self.lLabel str1:@"AL" str2:teamRecordModel.l str3:@"points"];
    [self handleSetAttributedWithLabel:self.moneylineLabel str1:@"Moneyline" str2:teamRecordModel.games str3:@"home win"];
    [self handleSetAttributedWithLabel:self.ouLabel str1:@"O/U" str2:teamRecordModel.point str3:@"Over"];
    _teamRecordModel = teamRecordModel;
}

- (void)setIsRequest10:(BOOL)isRequest10{
    NSString *team = self.isHost ? @"HOME-led" : @"AWAY-led";
    self.titleLabel.text = [NSString stringWithFormat:@"%@ performance from the last %d matches", team, isRequest10 ? 10: 6];
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.layer.cornerRadius = 8;
        _containerView.layer.borderColor = rgb(234, 241, 245).CGColor;
        _containerView.layer.borderWidth = 1;
    }
    return _containerView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UILabel *)winLabel{
    if (!_winLabel) {
        _winLabel = [UILabel new];
        _winLabel.backgroundColor = rgb(29, 209, 0);
        _winLabel.textColor = UIColor.whiteColor;
        _winLabel.textAlignment = NSTextAlignmentCenter;
        _winLabel.font = AX_PingFangSemibold_Font(12);
        _winLabel.layer.cornerRadius = 8;
        _winLabel.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMinXMaxYCorner;
        _winLabel.layer.masksToBounds = true;
    }
    return _winLabel;
}

- (UILabel *)loseLabel{
    if (!_loseLabel) {
        _loseLabel = [UILabel new];
        _loseLabel.backgroundColor = rgb(209, 0, 0);
        _loseLabel.textColor = UIColor.whiteColor;
        _loseLabel.textAlignment = NSTextAlignmentCenter;
        _loseLabel.font = AX_PingFangSemibold_Font(12);
        _loseLabel.layer.cornerRadius = 8;
        _loseLabel.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner;
        _loseLabel.layer.masksToBounds = true;
    }
    return _loseLabel;
}

- (UILabel *)aveLabel{
    if (!_aveLabel) {
        _aveLabel = [UILabel new];
        _aveLabel.numberOfLines = 10;
        _aveLabel.font = [UIFont systemFontOfSize:12];
        _aveLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _aveLabel;
}

- (UILabel *)lLabel{
    if (!_lLabel) {
        _lLabel = [UILabel new];
        _lLabel.numberOfLines = 10;
        _lLabel.font = [UIFont systemFontOfSize:12];
        _lLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lLabel;
}

- (UILabel *)moneylineLabel{
    if (!_moneylineLabel) {
        _moneylineLabel = [UILabel new];
        _moneylineLabel.numberOfLines = 10;
        _moneylineLabel.font = [UIFont systemFontOfSize:12];
        _moneylineLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneylineLabel;
}

- (UILabel *)ouLabel{
    if (!_ouLabel) {
        _ouLabel = [UILabel new];
        _ouLabel.numberOfLines = 10;
        _ouLabel.font = [UIFont systemFontOfSize:12];
        _ouLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _ouLabel;
}

@end
