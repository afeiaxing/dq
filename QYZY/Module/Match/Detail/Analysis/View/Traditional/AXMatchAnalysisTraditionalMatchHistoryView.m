//
//  AXMatchAnalysisTraditionalMatchHistoryView.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisTraditionalMatchHistoryView.h"

@interface AXMatchAnalysisTraditionalMatchHistoryView()

@property (nonatomic, strong) NSArray <NSArray *>*dataSource;

@end

@implementation AXMatchAnalysisTraditionalMatchHistoryView

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
    CGFloat titleW = ScreenWidth / self.dataSource.firstObject.count;
    CGFloat titleH = 40;
    CGFloat dataH = 50;
    
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
                make.top.offset(i == 0 ? 0 : (titleH + dataH * (i - 1)));
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
- (NSArray *)dataSource{
    return @[@[@"Date", @"Home", @"Score", @"Away", @"Handicap", @"O/U"],
             @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
             @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
             @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
             @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
             @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
             @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"]];
}

@end
