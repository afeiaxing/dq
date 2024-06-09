//
//  AXMatchDetailNavigationView.m
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import "AXMatchDetailNavigationView.h"
#import "AXMarqueeView.h"

@interface AXMatchDetailNavigationView()

@property (nonatomic ,strong) UIView *statusView;
@property (nonatomic ,strong) UIView *navigationView;
@property (nonatomic ,strong) UIImageView *headerBgView;
@property (nonatomic, strong) AXMarqueeView *hostName;
@property (nonatomic, strong) AXMarqueeView *awayName;
@property (nonatomic, strong) UIImageView *topHostLogo;
@property (nonatomic, strong) UIImageView *topAwayLogo;
@property (nonatomic ,strong) UIButton *backButton;

@end

@implementation AXMatchDetailNavigationView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: public
+ (CGFloat)viewHeight{
    CGFloat height = StatusBarHeightConstant + NavigationBarHeight;
    return height;
}

// MARK: private
- (void)setupSubviews{
    [self addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(StatusBarHeightConstant);
    }];
    [self addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.statusView.mas_bottom);
        make.height.mas_equalTo(NavigationBarHeight);
    }];
    
    [self.navigationView addSubview:self.hostName];
    self.hostName.frame = CGRectMake(100, 3, 100, 40);
    
    [self.navigationView addSubview:self.topHostLogo];
    [self.topHostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.hostName.mas_left).offset(-8);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.navigationView addSubview:self.topAwayLogo];
    [self.topAwayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(50);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.navigationView addSubview:self.awayName];
    self.awayName.frame = CGRectMake((ScreenWidth / 2) + 50 + 15, 3, 100, 40);
    
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self).offset(StatusBarHeightConstant + 8);
        make.height.width.mas_equalTo(28);
    }];
}

- (void)backAction {
    !self.block ? : self.block();
}

// MARK: setter & getter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{
    [self.topHostLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.hostName.text = matchModel.homeTeamName;
    [self.topAwayLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayTeamLogo] placeholderImage:AXTeamPlaceholderLogo];
    self.awayName.text = matchModel.awayTeamName;
    
    _matchModel = matchModel;
}

- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = UIColor.blackColor;
    }
    return _statusView;
}

- (UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [UIView new];
        _navigationView.backgroundColor = UIColor.blackColor;
    }
    return _navigationView;;
}

- (UIImageView *)topHostLogo{
    if (!_topHostLogo) {
        _topHostLogo = [UIImageView new];
        _topHostLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _topHostLogo;
}

- (AXMarqueeView *)hostName{
    if (!_hostName) {
        _hostName = [AXMarqueeView new];
    }
    return _hostName;
}

- (UIImageView *)topAwayLogo{
    if (!_topAwayLogo) {
        _topAwayLogo = [UIImageView new];
        _topAwayLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _topAwayLogo;
}

- (AXMarqueeView *)awayName{
    if (!_awayName) {
        _awayName = [AXMarqueeView new];
    }
    return _awayName;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"live_detail_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


@end
