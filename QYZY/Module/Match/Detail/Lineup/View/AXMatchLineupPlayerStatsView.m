//
//  AXMatchLineupPlayerStatsView.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchLineupPlayerStatsView.h"
#import <objc/runtime.h>

@interface AXMatchLineupPlayerStatsView()

@property (nonatomic, strong) UILabel *playerTitleLabel;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) NSMutableArray *playerLabels;
@property (nonatomic, strong) NSArray *statsTitles;

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
    
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.left.equalTo(self.playerTitleLabel.mas_right);
    }];
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

- (NSArray *)getAllProperties: (AXMatchLineupStatsModel *)model{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(properties);
    
    return propertiesArray;
}

- (void)handleSetAttributedWithLabel: (UILabel *)label
                          playerName: (NSString *)playerName
                            playerNo: (NSString *)playerNo{
    // 创建NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    // 创建第一段文字的属性
    NSString *firstString = playerName;
    NSDictionary *firstAttributes = @{
        NSForegroundColorAttributeName: UIColor.blackColor,
        NSFontAttributeName: [UIFont systemFontOfSize:12]
    };
    NSAttributedString *firstAttributedString = [[NSAttributedString alloc] initWithString:firstString attributes:firstAttributes];
    
    // 创建第二段文字的属性
    NSString *secondString = [NSString stringWithFormat:@" %@", playerNo];
    NSDictionary *secondAttributes = @{
        NSForegroundColorAttributeName: rgb(130, 134, 163),
        NSFontAttributeName: [UIFont systemFontOfSize:10]
    };
    NSAttributedString *secondAttributedString = [[NSAttributedString alloc] initWithString:secondString attributes:secondAttributes];
    
    // 将两段文字添加到NSMutableAttributedString中
    [attributedString appendAttributedString:firstAttributedString];
    [attributedString appendAttributedString:secondAttributedString];
    
    // 将富文本赋值给UILabel
    label.attributedText = attributedString;
}

// MARK: setter & getter
- (void)setPlayerStats:(NSArray *)playerStats{
    if (!playerStats.count || playerStats.count == 0) {return;}
    
    for (UILabel *label in self.playerLabels) {
        [label removeFromSuperview];
    }
    [self.playerLabels removeAllObjects];
    
    CGFloat titleW = 108;
    CGFloat titleH = 38;
    
    // 纵向球员列
    for (int i = 0; i < playerStats.count; i++) {
        NSDictionary *model = playerStats[i];
        UILabel *label = [self getLabel];
        NSString *playerName = model[@"playerName"];
        if (playerName.length > 10) {
            playerName = [playerName substringToIndex:9];
        }
        [self handleSetAttributedWithLabel:label playerName:playerName playerNo:model[@"shirtNumber"]];
        [self addSubview:label];
        [self.playerLabels addObject:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.size.mas_equalTo(CGSizeMake(titleW, titleH));
            make.top.offset(titleH * (i + 1));
        }];
    }
    
    // 数据
    CGFloat dataLabelW = 70;
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:playerStats.firstObject];
    [temp removeObjectsForKeys:@[@"playerName", @"shirtNumber"]];  // 移除不需要的key
    
//    NSDictionary *model = temp.copy;
    NSArray *statsTitles = self.statsTitles;
//    NSArray *statsTitles = model.allKeys;
    self.containerView.contentSize = CGSizeMake(dataLabelW * statsTitles.count, self.bounds.size.height);
    
    for (int i = 0; i < statsTitles.count; i++) {
        NSString *stat = statsTitles[i];
        // 横向stats标题
        UILabel *statsTitleLabel = [self getLabel];
        statsTitleLabel.text = i == 0 ? @"Started" : [stat uppercaseString];
        statsTitleLabel.backgroundColor = rgb(255, 247, 239);
        statsTitleLabel.font = AX_PingFangSemibold_Font(12);
        [self.containerView addSubview:statsTitleLabel];
        [statsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(dataLabelW * i);
            make.size.mas_equalTo(CGSizeMake(dataLabelW, titleH));
        }];
        
        for (int j = 0; j < playerStats.count; j++) {
            // stats数据
            NSDictionary *model = playerStats[j];
            UILabel *statsDataLabel = [self getLabel];
            if ([stat isEqualToString:@"started"]) {
                NSString *str = [model valueForKey:stat];
                statsDataLabel.text = [str isEqualToString:@"yes"] ? @"Y" : @"N";
            } else {
                statsDataLabel.text = [model valueForKey:stat];
            }
            statsDataLabel.font = AX_PingFangMedium_Font(12);
            
            [self.containerView addSubview:statsDataLabel];
            [statsDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(titleH * (j + 1));
                make.left.offset(dataLabelW * i);
                make.size.mas_equalTo(CGSizeMake(dataLabelW, titleH));
            }];
        }
    }
    
    _playerStats = playerStats;
}

- (UILabel *)playerTitleLabel{
    if (!_playerTitleLabel) {
        _playerTitleLabel = [UILabel new];
        _playerTitleLabel.text = @"Player";
        _playerTitleLabel.textAlignment = NSTextAlignmentCenter;
        _playerTitleLabel.font = AX_PingFangSemibold_Font(12);
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

- (NSMutableArray *)playerLabels{
    if (!_playerLabels) {
        _playerLabels = [NSMutableArray array];
    }
    return _playerLabels;
}

- (NSArray *)statsTitles{
    return @[@"started", @"min", @"pts", @"reb", @"ast", @"fg", @"threePt", @"ft", @"oreb", @"dreb", @"stl", @"blk", @"tov", @"pf"];
}

@end
