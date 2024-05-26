//
//  AXMatchLineupPerformersCell.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchLineupPerformersCell.h"
#import "AXMatchLineupPerformersPlayerView.h"

@interface AXMatchLineupPerformersCell()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *statsTitleLabel;
@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;

@end

@implementation AXMatchLineupPerformersCell

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
    
    [self.containerView addSubview:self.statsTitleLabel];
    [self.statsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(34);
    }];
    
    [self.containerView addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.left.offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.containerView addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.hostLogo);
        make.right.offset(-20);
    }];
    
    [self.containerView addSubview:self.hostName];
    [self.hostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hostLogo);
        make.top.equalTo(self.hostLogo.mas_bottom).offset(10);
    }];

    [self.containerView addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayLogo);
        make.centerY.equalTo(self.hostName);
    }];
    
    
    CGFloat viewH = 120;
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        AXMatchLineupPerformersPlayerView *view = [AXMatchLineupPerformersPlayerView new];
        view.index = i;
        [self.containerView addSubview:view];
        [views addObject:view];
    }
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:viewH leadSpacing:118 tailSpacing:0];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
    }];
}

// MARK: setter & setter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    _matchModel = matchModel;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;
}

- (UILabel *)statsTitleLabel {
    if (!_statsTitleLabel) {
        _statsTitleLabel = [[UILabel alloc] init];
        _statsTitleLabel.font = [UIFont systemFontOfSize:16];
        _statsTitleLabel.textColor = rgb(17, 17, 17);
        _statsTitleLabel.text = @"Top Performers";
    }
    return _statsTitleLabel;
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

@end
