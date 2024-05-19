//
//  AXMatchAnalysisTraditionalMatchScheduleView.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisTraditionalMatchScheduleView.h"

@interface AXMatchAnalysisTraditionalMatchScheduleView()

@property (nonatomic, strong) UIView *BgView;
@property (nonatomic, strong) UILabel *scheduleTitleLabel;
@property (nonatomic, strong) NSArray <NSArray *>*dataSource;

@end

@implementation AXMatchAnalysisTraditionalMatchScheduleView

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
    self.backgroundColor = rgb(247, 247, 247);
    
    [self addSubview:self.BgView];
    [self.BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(4);
    }];
    
    [self.BgView addSubview:self.scheduleTitleLabel];
    [self.BgView addSubview:self.scheduleTitleLabel];
    [self.scheduleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(23);
    }];
    
    
    CGFloat titleW = ScreenWidth / self.dataSource.firstObject.count;
    CGFloat titleH = 30;
    CGFloat dataH = 40;
    
    for (int i = 0; i < self.dataSource.count; i++) {
        NSArray *datas = self.dataSource[i];
        for (int j = 0; j < datas.count; j++) {
            UILabel *label = [self getLabel];
            NSString *str = datas[j];
            label.text = str;
            label.backgroundColor = i == 0 ? rgb(255, 247, 239) : UIColor.whiteColor;
            [self addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(titleW * j);
                make.top.equalTo(self.scheduleTitleLabel.mas_bottom).offset(i == 0 ? 20 : 20 + (titleH + dataH * (i - 1)));
                make.size.mas_equalTo(CGSizeMake(titleW, i == 0 ? titleH : dataH));
            }];
        }
    }
}

- (UILabel *)getLabel{
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:12];
    return label;
}


// MARK: setter & getter
- (void)setViewType:(AXMatchAnalysisTraditionalMatchViewType)viewType{
    _viewType = viewType;
    self.scheduleTitleLabel.text = viewType == AXMatchAnalysisTraditionalMatchViewType_host ? @"Home Schedule" : @"Away Schedule";
}

- (UIView *)BgView{
    if (!_BgView) {
        _BgView = [UIView new];
        _BgView.backgroundColor = UIColor.whiteColor;
    }
    return _BgView;
}

- (UILabel *)scheduleTitleLabel {
    if (!_scheduleTitleLabel) {
        _scheduleTitleLabel = [[UILabel alloc] init];
        _scheduleTitleLabel.font = [UIFont systemFontOfSize:16];
        _scheduleTitleLabel.textColor = rgb(17, 17, 17);
    }
    return _scheduleTitleLabel;
}

- (NSArray *)dataSource{
    return @[@[@"Date", @"League", @"Games", @"Interval"],
             @[@"Nov 2 24", @"NBA", @"Lakers VS Rockets", @"15:50"],
             @[@"Nov 2 24", @"NBA", @"Lakers VS Warriors", @"3 Days"]];
}

@end
