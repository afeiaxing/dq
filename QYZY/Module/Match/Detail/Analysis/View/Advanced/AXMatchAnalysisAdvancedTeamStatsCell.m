//
//  AXMatchAnalysisAdvancedTeamStatsCell.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisAdvancedTeamStatsCell.h"
#import "AXMatchAnalysisAdvancedTeamStatsView.h"

@interface AXMatchAnalysisAdvancedTeamStatsCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *vsLabel;
@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;

@property (nonatomic, strong) UIView *statView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation AXMatchAnalysisAdvancedTeamStatsCell

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
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(22);
        make.left.offset(15);
    }];
    
    [self addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(45);
        make.left.offset(33);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self addSubview:self.hostName];
    [self.hostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hostLogo);
        make.left.equalTo(self.hostLogo.mas_right).offset(10);
    }];
    
    [self addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.equalTo(self.hostLogo);
        make.right.offset(-33);
    }];

    [self addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awayLogo);
        make.right.equalTo(self.awayLogo.mas_left).offset(-10);
    }];
    
    [self addSubview:self.vsLabel];
    [self.vsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.equalTo(self.hostLogo);
    }];
    
    CGFloat topMargin = 24;
    CGFloat viewH = 42;
    for (int i = 0; i < self.datas.count; i++) {
        NSString *str = self.datas[i];
        AXMatchAnalysisAdvancedTeamStatsView *view = [AXMatchAnalysisAdvancedTeamStatsView new];
        view.data = str;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.hostLogo.mas_bottom).offset(topMargin + i * viewH);
            make.height.mas_equalTo(viewH);
        }];
    }
}

// MARK: setter & getter- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    _matchModel = matchModel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = rgb(17, 17, 17);
        _titleLabel.text = @"Team Statistics";
    }
    return _titleLabel;
}

- (UILabel *)vsLabel {
    if (!_vsLabel) {
        _vsLabel = [[UILabel alloc] init];
        _vsLabel.font = [UIFont systemFontOfSize:16];
        _vsLabel.textColor = rgb(17, 17, 17);
        _vsLabel.text = @"VS";
    }
    return _vsLabel;
}

- (UIImageView *)hostLogo{
    if (!_hostLogo) {
        _hostLogo = [UIImageView new];
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo{
    if (!_awayLogo) {
        _awayLogo = [UIImageView new];
    }
    return _awayLogo;
}

- (UILabel *)hostName {
    if (!_hostName) {
        _hostName = [[UILabel alloc] init];
        _hostName.font = [UIFont systemFontOfSize:12];
        _hostName.textColor = rgb(17, 17, 17);
        _hostName.text = @"LAL";
    }
    return _hostName;
}

- (UILabel *)awayName {
    if (!_awayName) {
        _awayName = [[UILabel alloc] init];
        _awayName.font = [UIFont systemFontOfSize:12];
        _awayName.textColor = rgb(17, 17, 17);
        _awayName.text = @"BOS";
    }
    return _awayName;
}

- (NSArray *)datas{
    return @[@"Field Goal \n Point", @"Rebound \n Amount", @"Assist \n Amount", @"Block \n Amount", @"Steal \n Amount",  @"Turnovers \n Amount", @"Field Goal \n %", @"3-Point \n %", @"Free Throw \n %"];
}

@end
