//
//  AXMatchFilterBottomView.m
//  QYZY
//
//  Created by 22 on 2024/6/4.
//

#import "AXMatchFilterBottomView.h"

@interface AXMatchFilterBottomView()

@property (nonatomic, strong) UIButton *selectAllBtn;
@property (nonatomic, strong) UIButton *reverseBtn;
@property (nonatomic, strong) UILabel *selectCountLabel;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, assign) int currentCount;

@end

@implementation AXMatchFilterBottomView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: Public
- (void)handleUpdateCount: (int)count
               isIncrease: (BOOL)isIncrease{
    int currentCount;
    if (isIncrease) {
        currentCount = self.currentCount += count;
    } else {
        currentCount = self.currentCount -= count;
    }
    
    [self handleSetAttributedWithLabel:self.selectCountLabel selectCount:currentCount totalCount:self.totalMatchCount];
}

// MARK: private
- (void)setupSubviews{
    [self setShadow];
    
    [self addSubview:self.selectAllBtn];
    [self.selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.offset(22);
        make.size.mas_equalTo(CGSizeMake(61, 16));
    }];
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = rgb(226, 226, 226);
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(22);
        make.size.mas_equalTo(CGSizeMake(1, 12));
        make.centerY.equalTo(self.selectAllBtn);
    }];
    
    [self addSubview:self.reverseBtn];
    [self.reverseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV.mas_right).offset(22);
        make.centerY.equalTo(self.selectAllBtn);
        make.size.mas_equalTo(CGSizeMake(120, 16));
    }];
    
    [self addSubview:self.selectCountLabel];
    [self.selectCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn);
        make.top.equalTo(self.selectAllBtn.mas_bottom).offset(8);
    }];
    
    [self addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.size.mas_equalTo(CGSizeMake(100, 32));
        make.top.offset(22);
    }];
}

- (void)setShadow{
    self.layer.shadowColor = rgba(160, 175, 201, 0.16).CGColor;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    self.layer.shadowRadius = 5;
    // 单边阴影 顶边
    float shadowPathWidth = self.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(-shadowPathWidth/2.0, 0-shadowPathWidth/2.0, ScreenWidth + shadowPathWidth, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
}

- (void)handleSelectAll{
    [self handleSetAttributedWithLabel:self.selectCountLabel selectCount:self.totalMatchCount totalCount:self.totalMatchCount];
    self.currentCount = self.totalMatchCount;
    !self.block ? : self.block(AXMatchFilterBottomEvent_selectall);
}

- (void)handleReverse{
    int reverseCount = self.totalMatchCount - self.currentCount;
    [self handleSetAttributedWithLabel:self.selectCountLabel selectCount:reverseCount totalCount:self.totalMatchCount];
    self.currentCount = reverseCount;
    !self.block ? : self.block(AXMatchFilterBottomEvent_reverse);
}

- (void)handleConfirm{
    !self.block ? : self.block(AXMatchFilterBottomEvent_confirm);
}

- (void)handleSetAttributedWithLabel: (UILabel *)label
                         selectCount: (int)selectCount
                          totalCount: (int)totalCount{
    // 创建NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    // 创建第一段文字的属性
    NSString *firstString = [NSString stringWithFormat:@"%d", selectCount];
    NSDictionary *firstAttributes = @{
        NSForegroundColorAttributeName: AXSelectColor,
        NSFontAttributeName: AX_PingFangMedium_Font(12)
    };
    NSAttributedString *firstAttributedString = [[NSAttributedString alloc] initWithString:firstString attributes:firstAttributes];
    
    // 创建第二段文字的属性
    NSString *secondString = [NSString stringWithFormat:@" / %d", totalCount];
    NSDictionary *secondAttributes = @{
        NSForegroundColorAttributeName: AXUnSelectColor,
    };
    NSAttributedString *secondAttributedString = [[NSAttributedString alloc] initWithString:secondString attributes:secondAttributes];
    
    // 将两段文字添加到NSMutableAttributedString中
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Selected "]];
    [attributedString appendAttributedString:firstAttributedString];
    [attributedString appendAttributedString:secondAttributedString];
    
    // 将富文本赋值给UILabel
    label.attributedText = attributedString;
}

// MARK: setter & getter
- (void)setTotalMatchCount:(int)totalMatchCount{
    [self handleSetAttributedWithLabel:self.selectCountLabel selectCount:totalMatchCount totalCount:totalMatchCount];
    self.currentCount = totalMatchCount;
    _totalMatchCount = totalMatchCount;
}

- (UIButton *)selectAllBtn{
    if (!_selectAllBtn) {
        _selectAllBtn = [UIButton new];
        [_selectAllBtn setTitle:@"Select All" forState:UIControlStateNormal];
        [_selectAllBtn setTitleColor:AXSelectColor forState:UIControlStateNormal];
        _selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_selectAllBtn addTarget:self action:@selector(handleSelectAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

- (UIButton *)reverseBtn{
    if (!_reverseBtn) {
        _reverseBtn = [UIButton new];
        [_reverseBtn setTitle:@"Reverse Selection" forState:UIControlStateNormal];
        [_reverseBtn setTitleColor:AXSelectColor forState:UIControlStateNormal];
        _reverseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_reverseBtn addTarget:self action:@selector(handleReverse) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reverseBtn;
}

- (UILabel *)selectCountLabel{
    if (!_selectCountLabel) {
        _selectCountLabel = [UILabel new];
        _selectCountLabel.font = AX_PingFangRegular_Font(12);
        _selectCountLabel.textColor = AXUnSelectColor;
    }
    return _selectCountLabel;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton new];
        [_confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(handleConfirm) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.backgroundColor = AXSelectColor;
        _confirmBtn.titleLabel.font = AX_PingFangSemibold_Font(15);
        _confirmBtn.layer.cornerRadius = 16;
        _confirmBtn.layer.masksToBounds = true;
    }
    return _confirmBtn;
}

@end
