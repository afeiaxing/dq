//
//  AXMatchLineupPlayerStatsView.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchLineupPlayerStatsView.h"

@interface AXMatchLineupPlayerStatsView()

@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) NSArray *stats;

@property (nonatomic, strong) UILabel *playerTitleLabel;
@property (nonatomic, strong) UIScrollView *containerView;

@end

@implementation AXMatchLineupPlayerStatsView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self;
}

// MARK: private
- (void)setupSubviews{
    CGFloat titleW = 108;
    CGFloat titleH = 38;
    
    [self addSubview:self.playerTitleLabel];
    [self.playerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(titleW, titleH));
    }];
    
    for (int i = 0; i < self.players.count; i++) {
        NSString *player = self.players[i];
        UILabel *label = [self getLabel];
        label.text = player;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.size.mas_equalTo(CGSizeMake(titleW, titleH));
            make.top.offset(titleH * (i + 1));
        }];
    }
    
    
    CGFloat dataLabelW = 70;
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.left.equalTo(self.playerTitleLabel.mas_right);
    }];
    self.containerView.contentSize = CGSizeMake(dataLabelW * self.stats.count, self.bounds.size.height);
    
    for (int i = 0; i < self.stats.count; i++) {
        NSString *stat = self.stats[i];
        UILabel *statsTitleLabel = [self getLabel];
        statsTitleLabel.text = stat;
        statsTitleLabel.backgroundColor = rgb(255, 247, 239);
        [self.containerView addSubview:statsTitleLabel];
        [statsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(dataLabelW * i);
            make.size.mas_equalTo(CGSizeMake(dataLabelW, titleH));
        }];
        
        for (int j = 0; j < self.players.count; j++) {
            UILabel *statsDataLabel = [self getLabel];
            statsDataLabel.text = [NSString stringWithFormat:@"%d+%d", i, j];
            [self.containerView addSubview:statsDataLabel];
            [statsDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(titleH * (j + 1));
                make.left.offset(dataLabelW * i);
                make.size.mas_equalTo(CGSizeMake(dataLabelW, titleH));
            }];
        }
    }
}

- (UILabel *)getLabel{
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    return label;
}

- (void)handleSetLabelBorder: (UILabel *)label
                       width: (CGFloat)width
                      height: (CGFloat)height
                     corners: (CACornerMask)corners {
    // 创建一个单层边框
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, 0, width, height);
    border.backgroundColor = [UIColor clearColor].CGColor;
    border.borderColor = rgb(180, 180, 180).CGColor; // 设置边框颜色为黑色
    border.borderWidth = 1.0f; // 设置边框宽度为1.0

    // 将边框添加到label的layer
    [label.layer addSublayer:border];

    // 隐藏不需要的边框
    border.maskedCorners = kCALayerMinXMaxYCorner;
}

// MARK: setter & getter
- (UILabel *)playerTitleLabel{
    if (!_playerTitleLabel) {
        _playerTitleLabel = [UILabel new];
        _playerTitleLabel.text = @"Player";
        _playerTitleLabel.textAlignment = NSTextAlignmentCenter;
        _playerTitleLabel.font = [UIFont systemFontOfSize:12];
        _playerTitleLabel.backgroundColor = rgb(255, 247, 239);
//        _playerTitleLabel.layer.borderColor = rgb(180, 180, 180).CGColor;
//        _playerTitleLabel.layer.borderWidth = 1;
//        _playerTitleLabel.layer.maskedCorners = kCALayerMaxXMaxYCorner;
    }
    return _playerTitleLabel;
}

- (UIScrollView *)containerView{
    if (!_containerView) {
        _containerView = [UIScrollView new];
        _containerView.showsHorizontalScrollIndicator = false;
    }
    return _containerView;
}

- (NSArray *)players {
    return @[@"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24", @"K.Bryant 24"];
}

- (NSArray *)stats{
    return @[@"Started", @"MIN", @"PTS", @"ATS", @"STL", @"STL1", @"STL2", @"STL3", @"STL4", @"STL5", @"STL6", ];
}

@end
