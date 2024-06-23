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
        label.font = AX_PingFangSemibold_Font(12);
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
    return label;
}

- (NSString *)handleGetDateString: (NSString *)dateStr{
    // 输入日期字符串
    NSString *inputDateString = dateStr;
    
    // 创建日期格式化器，用于解析输入的日期字符串
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // 将字符串转换为NSDate对象
    NSDate *date = [inputFormatter dateFromString:inputDateString];
    
    // 创建日期格式化器，用于格式化输出的日期字符串
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM dd \n yyyy"];
    
    // 将NSDate对象转换为所需格式的字符串
    NSString *outputDateString = [outputFormatter stringFromDate:date];
    
    return outputDateString;
}

- (void)handleSetAttributedWithLabel: (UILabel *)label
                           hostScore: (NSString *)hostScore
                           awayScore: (NSString *)awayScore{
    if (hostScore.intValue == awayScore.intValue) {  // 中立信息，不需要富文本
        label.text = [NSString stringWithFormat:@"%@:%@", hostScore, awayScore];
        return;
    }
    
    // 创建NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    BOOL isHost = hostScore.intValue > awayScore.intValue;
    
    // 创建第一段文字的属性
    NSString *firstString = hostScore;
    NSDictionary *firstAttributes = @{
        NSForegroundColorAttributeName: isHost ? AXSelectColor : UIColor.blackColor,
//        NSFontAttributeName: [UIFont systemFontOfSize:12]
    };
    NSAttributedString *firstAttributedString = [[NSAttributedString alloc] initWithString:firstString attributes:firstAttributes];
    
    // 创建第二段文字的属性
    NSString *secondString = awayScore;
    NSDictionary *secondAttributes = @{
        NSForegroundColorAttributeName: isHost ? UIColor.blackColor : AXSelectColor,
//        NSFontAttributeName: [UIFont systemFontOfSize:10]
    };
    NSAttributedString *secondAttributedString = [[NSAttributedString alloc] initWithString:secondString attributes:secondAttributes];
    
    // 将两段文字添加到NSMutableAttributedString中
    [attributedString appendAttributedString:firstAttributedString];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@":"]];
    [attributedString appendAttributedString:secondAttributedString];
    
    // 将富文本赋值给UILabel
    label.attributedText = attributedString;
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
        NSArray *scores = [model.score componentsSeparatedByString:@"-"];
        NSString *hostScore = scores.firstObject;
        NSString *awayScore = scores.lastObject;
        for (int j = 0; j < self.titles.count; j++) {
            UILabel *label = [self getLabel];
            label.font = AX_PingFangMedium_Font(12);
            switch (j) {
                case 0:
                    label.text = [self handleGetDateString:model.matchDate];
                    label.textColor = rgb(130, 134, 163);
                    break;
                case 1:
                    label.text = model.homeTeamName;
                    label.textColor = hostScore.intValue > awayScore.intValue ? AXSelectColor : UIColor.blackColor;
                    break;
                case 2:
                    [self handleSetAttributedWithLabel:label hostScore:hostScore awayScore:awayScore];
                    break;
                case 3:
                    label.text = model.awayTeamName;
                    label.textColor = hostScore.intValue > awayScore.intValue ? UIColor.blackColor : AXSelectColor;
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
