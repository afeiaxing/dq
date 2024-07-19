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
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *dataLabels;

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
    
    
    CGFloat titleW = ScreenWidth / self.titles.count;
    CGFloat titleH = 30;
    
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [self getLabel];
        label.font = AX_PingFangSemibold_Font(12);
        NSString *str = self.titles[i];
        label.text = str;
        label.backgroundColor = rgb(255, 247, 239);
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(titleW * i);
            make.top.equalTo(self.scheduleTitleLabel.mas_bottom).offset(20);
            make.size.mas_equalTo(CGSizeMake(titleW, titleH));
        }];
    }
}

- (UILabel *)getLabel{
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    return label;
}


// MARK: setter & getter
- (void)setViewType:(AXMatchAnalysisTraditionalMatchViewType)viewType{
    _viewType = viewType;
    self.scheduleTitleLabel.text = viewType == AXMatchAnalysisTraditionalMatchViewType_host ? @"Home Schedule" : @"Away Schedule";
}

- (void)setScheduleMatchs:(NSArray<AXMatchAnalysisTeamRecordItemModel *> *)scheduleMatchs{
    if (!scheduleMatchs || scheduleMatchs.count == 0) {return;}
    
    for (UILabel *label in self.dataLabels) {
        [label removeFromSuperview];
    }
    [self.dataLabels removeAllObjects];
    
    CGFloat titleW = ScreenWidth / self.titles.count;
    CGFloat titleH = 30;
    CGFloat dataH = 40;
    
    for (int i = 0; i < scheduleMatchs.count; i++) {
        AXMatchAnalysisTeamRecordItemModel *model = scheduleMatchs[i];
        for (int j = 0; j < self.titles.count; j++) {
            UILabel *label = [self getLabel];
            label.font = AX_PingFangMedium_Font(12);
            switch (j) {
                case 0:
                    label.text = model.matchDate;
                    break;
                case 1:
                    label.text = model.competitionName;
                    break;
                case 2:
                    label.text = model.games;
                    break;
                case 3:
                    label.text = model.interval;
                    break;
                    
                default:
                    break;
            }
            
            [self addSubview:label];
            [self.dataLabels addObject:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(titleW * j);
                make.top.equalTo(self.scheduleTitleLabel.mas_bottom).offset(20 + titleH + dataH * i);
                make.size.mas_equalTo(CGSizeMake(titleW, dataH));
            }];
        }
    }
    
    _scheduleMatchs = scheduleMatchs;
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
        _scheduleTitleLabel.font = AX_PingFangSemibold_Font(16);
        _scheduleTitleLabel.textColor = rgb(17, 17, 17);
    }
    return _scheduleTitleLabel;
}

- (NSArray *)titles{
    return @[@"Date", @"League", @"Games", @"Interval"];
}

- (NSMutableArray *)dataLabels{
    if (!_dataLabels) {
        _dataLabels = [NSMutableArray array];
    }
    return _dataLabels;
}

@end
