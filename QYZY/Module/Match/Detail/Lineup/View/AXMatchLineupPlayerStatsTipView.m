//
//  AXMatchLineupPlayerStatsTipView.m
//  QYZY
//
//  Created by 22 on 2024/7/8.
//

#import "AXMatchLineupPlayerStatsTipView.h"

@interface AXMatchLineupPlayerStatsTipView()

@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation AXMatchLineupPlayerStatsTipView

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
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    UILabel *titleLabel = [self getLabelWithFont:AX_PingFangMedium_Font(14)];
    titleLabel.text = @"Player Statistics";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(14);
    }];

    NSArray *titles = @[@"MIN", @"FG", @"PTS", @"3PT", @"REB", @"FT", @"AST", @"OREB", @"BLK", @"DREB", @"STL", @"TOV", @"PF"];
    NSArray *values = @[@"Minutes Played", @"Field Goal", @"Points", @"3-Point", @"Rebounds", @"Free Throw", @"Assist", @"Offensive Rebound", @"Blocks", @"Defensive Rebounds", @"Steals", @"Turnovers", @"Fouls"];
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *titleL = [self getLabelWithFont:AX_PingFangSemibold_Font(12)];
        titleL.text = titles[i];
        [self addSubview:titleL];
        int row = i / 2;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i % 2 == 0 ? 15 : 145);
            make.top.offset(45 + 20 * row);
        }];
        
        UILabel *valueL = [self getLabelWithFont:AX_PingFangMedium_Font(10)];
        valueL.text = values[i];
        [self addSubview:valueL];
        [valueL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i % 2 == 0 ? 53 : 183);
            make.centerY.equalTo(titleL);
        }];
    }
}

- (UILabel *)getLabelWithFont: (UIFont *)font{
    UILabel *label = [UILabel new];
    label.font = font;
    label.textColor = UIColor.whiteColor;
    return label;
}

// MARK: setter & getter
- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [UIImageView new];
        _bgView.image = [UIImage imageNamed:@"match_detail_statstips"];
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformRotate(transform, -M_PI);
        _bgView.transform = transform;
    }
    return _bgView;
}


@end
