//
//  AXMatchAnalysisTraditionalMatchHistoryView.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisTraditionalMatchHistoryView.h"

@interface AXMatchAnalysisTraditionalMatchHistoryView()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *dataLabels;

@end

#define AXMatchAnalysisTraditionalMatchHistoryTitleHeight 40
#define AXMatchAnalysisTraditionalMatchHistoryDataHeight 50

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
    CGFloat titleW = ScreenWidth / self.titles.count;
    
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [self getLabel];
        NSString *str = self.titles[i];
        label.text = str;
        label.backgroundColor = rgb(255, 247, 239);
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(titleW * i);
            make.top.offset(0);
            make.size.mas_equalTo(CGSizeMake(titleW, AXMatchAnalysisTraditionalMatchHistoryTitleHeight));
        }];
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
- (void)setRecords:(NSArray<AXMatchAnalysisRivalryRecordItemModel *> *)records{
    if (!records || records.count == 0) {return;}
    for (UILabel *label in self.dataLabels) {
        [label removeFromSuperview];
    }
    [self.dataLabels removeAllObjects];
    
    CGFloat width = ScreenWidth / self.titles.count;
    for (int i = 0; i < records.count; i++) {
        AXMatchAnalysisRivalryRecordItemModel *model = records[i];
        for (int j = 0; j < self.titles.count; j++) {
            UILabel *label = [self getLabel];
            switch (j) {
                case 0:
                    label.text = model.matchDate;
                    break;
                case 1:
                    label.text = model.homeTeamName;
                    break;
                case 2:
                    label.text = model.score;
                    break;
                case 3:
                    label.text = model.awayTeamName;
                    break;
                case 4:
                    label.text = [NSString stringWithFormat:@"%@\n%@", model.handicap, model.handicapResult];
                    break;
                case 5:
                    label.text = [NSString stringWithFormat:@"%@\n%@", model.ou, model.ouResult];
                    break;
                    
                default:
                    break;
            }
            
            [self addSubview:label];
            [self.dataLabels addObject:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(width * j);
                make.top.offset(AXMatchAnalysisTraditionalMatchHistoryTitleHeight + AXMatchAnalysisTraditionalMatchHistoryDataHeight * i);
                make.size.mas_equalTo(CGSizeMake(width, AXMatchAnalysisTraditionalMatchHistoryDataHeight));
            }];
        }
    }
    _records = records;
}

- (NSArray *)titles{
    return @[@"Date", @"Home", @"Score", @"Away", @"Handicap", @"O/U"];
}

- (NSMutableArray *)dataLabels{
    if (!_dataLabels) {
        _dataLabels = [NSMutableArray array];
    }
    return _dataLabels;
}

/**
 - (NSArray *)dataSource{
     return @[@[@"Date", @"Home", @"Score", @"Away", @"Handicap", @"O/U"],
              @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
              @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
              @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
              @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
              @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"],
              @[@"Nov 27\n23", @"LAL", @"102:117", @"ATL", @"1.5/Lose", @"219 U"]];
 }
 */

@end
