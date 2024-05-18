//
//  AXMatchStandingPBPStatsSubCell.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchStandingPBPStatsSubCell.h"

@interface AXMatchStandingPBPStatsSubCell()

@property (nonatomic, strong) UILabel *homeValueLabel;
@property (nonatomic, strong) UILabel *awayValueLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *homeBackView;
@property (nonatomic, strong) UIView *awayBackView;
@property (nonatomic, strong) UIView *homeTintView;
@property (nonatomic, strong) UIView *awayTintView;

@end

#define AXMatchStandingPBPStatsSubCellMargin 16

@implementation AXMatchStandingPBPStatsSubCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

// MARK: pravite
- (void)setupSubviews{
    CGFloat backViewWidth = (ScreenWidth - AXMatchStandingPBPStatsSubCellMargin * 2 - 2) / 2;
    [self.contentView addSubview:self.homeValueLabel];
        [self.contentView addSubview:self.awayValueLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.homeBackView];
        [self.contentView addSubview:self.awayBackView];
        [self.contentView addSubview:self.homeTintView];
        [self.contentView addSubview:self.awayTintView];
    
    [self.homeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(AXMatchStandingPBPStatsSubCellMargin);
        }];
        
        [self.awayValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.homeValueLabel);
            make.right.equalTo(self.contentView).offset(-AXMatchStandingPBPStatsSubCellMargin);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.homeValueLabel);
            make.centerX.equalTo(self.contentView);
        }];
        
        [self.homeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.homeValueLabel.mas_bottom).offset(4);
            make.left.equalTo(self.homeValueLabel);
            make.size.mas_equalTo(CGSizeMake(backViewWidth, 8));
        }];
        
        [self.awayBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.height.equalTo(self.homeBackView);
            make.right.equalTo(self.awayValueLabel);
        }];
        
        [self.homeTintView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.height.equalTo(self.homeBackView);
            make.width.mas_equalTo(50);
        }];
        
        [self.awayTintView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.height.equalTo(self.awayBackView);
            make.width.mas_equalTo(70);
        }];
}

// MARK: setter & getter
- (void)setData:(NSString *)data{
    self.titleLabel.text = data;
}

- (UILabel *)homeValueLabel {
    if (!_homeValueLabel) {
        _homeValueLabel = [[UILabel alloc] init];
        _homeValueLabel.text = @"146";
        _homeValueLabel.textColor = rgb(17, 17, 17);
        _homeValueLabel.font = [UIFont systemFontOfSize:12];
    }
    return _homeValueLabel;
}

- (UILabel *)awayValueLabel {
    if (!_awayValueLabel) {
        _awayValueLabel = [[UILabel alloc] init];
        _awayValueLabel.text = @"90";
        _awayValueLabel.textColor = rgb(17, 17, 17);
        _awayValueLabel.font = [UIFont systemFontOfSize:12];
    }
    return _awayValueLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Field Goal";
        _titleLabel.textColor = rgb(153, 153, 153);
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UIView *)homeBackView {
    if (!_homeBackView) {
        _homeBackView = [[UIView alloc] init];
        _homeBackView.backgroundColor = rgb(255, 247, 239);
        _homeBackView.layer.cornerRadius = 4;
    }
    return _homeBackView;
}

- (UIView *)awayBackView {
    if (!_awayBackView) {
        _awayBackView = [[UIView alloc] init];
        _awayBackView.backgroundColor = rgb(255, 247, 239);
        _awayBackView.layer.cornerRadius = 4;
    }
    return _awayBackView;
}

- (UIView *)homeTintView {
    if (!_homeTintView) {
        _homeTintView = [[UIView alloc] init];
        _homeTintView.backgroundColor = rgb(143, 0, 255);
        _homeTintView.layer.cornerRadius = 4;
    }
    return _homeTintView;
}

- (UIView *)awayTintView {
    if (!_awayTintView) {
        _awayTintView = [[UIView alloc] init];
        _awayTintView.backgroundColor = rgb(0, 162, 36);
        _awayTintView.layer.cornerRadius = 4;
    }
    return _awayTintView;
}


@end
