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
@property (nonatomic, strong) NSMutableArray *performersPlayerViews;

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
        make.width.mas_equalTo(60);
    }];

    [self.containerView addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayLogo);
        make.centerY.equalTo(self.hostName);
        make.width.equalTo(self.hostName);
    }];
}

// MARK: setter & setter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    [self.hostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    [self.awayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostName.text = matchModel.homeTeamName;
    self.awayName.text = matchModel.awayTeamName;
    _matchModel = matchModel;
}

- (void)setLineupModel:(AXMatchLineupModel *)lineupModel{
    if (!lineupModel) {return;}
    
    for (AXMatchLineupPerformersPlayerView *view in self.performersPlayerViews) {
        [view removeFromSuperview];
    }
    [self.performersPlayerViews removeAllObjects];
    
    CGFloat viewH = 120;
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        AXMatchLineupPerformersPlayerView *view = [AXMatchLineupPerformersPlayerView new];
        view.index = i;
        if (i == 0) {
            view.hostModel = lineupModel.hostTop1Mpdel;
            view.awayModel = lineupModel.awayTop1Mpdel;
        } else if (i == 1) {
            view.hostModel = lineupModel.hostTop2Mpdel;
            view.awayModel = lineupModel.awayTop2Mpdel;
        } else {
            view.hostModel = lineupModel.hostTop3Mpdel;
            view.awayModel = lineupModel.awayTop3Mpdel;
        }
        [self.containerView addSubview:view];
        [views addObject:view];
    }
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:viewH leadSpacing:118 tailSpacing:0];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
    }];
    _lineupModel = lineupModel;
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
        _statsTitleLabel.font = AX_PingFangSemibold_Font(16);
        _statsTitleLabel.textColor = rgb(17, 17, 17);
        _statsTitleLabel.text = @"Top Performers";
    }
    return _statsTitleLabel;
}

- (UIImageView *)hostLogo{
    if (!_hostLogo) {
        _hostLogo = [UIImageView new];
        _hostLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo{
    if (!_awayLogo) {
        _awayLogo = [UIImageView new];
        _awayLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _awayLogo;
}

- (UILabel *)hostName {
    if (!_hostName) {
        _hostName = [[UILabel alloc] init];
        _hostName.font = AX_PingFangSemibold_Font(14);
        _hostName.textAlignment = NSTextAlignmentCenter;
        _hostName.textColor = rgb(17, 17, 17);
    }
    return _hostName;
}

- (UILabel *)awayName {
    if (!_awayName) {
        _awayName = [[UILabel alloc] init];
        _awayName.font = AX_PingFangSemibold_Font(14);
        _awayName.textAlignment = NSTextAlignmentCenter;
        _awayName.textColor = rgb(17, 17, 17);
    }
    return _awayName;
}

- (NSMutableArray *)performersPlayerViews{
    if (!_performersPlayerViews) {
        _performersPlayerViews = [NSMutableArray array];
    }
    return _performersPlayerViews;
}

@end
