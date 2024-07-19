//
//  AXMatchAnalysisTraditionalRankTipView.m
//  QYZY
//
//  Created by 22 on 2024/7/8.
//

#import "AXMatchAnalysisTraditionalRankTipView.h"

@interface AXMatchAnalysisTraditionalRankTipView()

@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation AXMatchAnalysisTraditionalRankTipView

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
    titleLabel.text = @"Team Ranking";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(30);
    }];

    NSArray *titles = @[@"AVE", @"W/L", @"WP", @"AL", @"WS"];
    NSArray *values = @[@"Average Field Goal", @"Win/Lose", @"Winning Rate", @"Average Lose Point", @"Winning Streak"];
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *titleL = [self getLabelWithFont:AX_PingFangSemibold_Font(12)];
        titleL.text = titles[i];
        [self addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(55 + 20 * i);
        }];
        
        UILabel *valueL = [self getLabelWithFont:AX_PingFangMedium_Font(10)];
        valueL.text = values[i];
        [self addSubview:valueL];
        [valueL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(53);
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
        _bgView.image = [UIImage imageNamed:@"match_detail_ranktips"];
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformRotate(transform, -M_PI);
        _bgView.transform = transform;
    }
    return _bgView;
}

@end
