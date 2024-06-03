//
//  AXMatchListDateView.m
//  QYZY
//
//  Created by 22 on 2024/5/27.
//

#import "AXMatchListDateView.h"

@interface AXMatchListDateView()

@property (nonatomic, assign) AXMatchStatus status;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIButton *lastSelectedBtn;

@end

@implementation AXMatchListDateView

// MARK: lifecycle
- (instancetype)initWithStatus:(AXMatchStatus)status{
    if (self = [super init]) {
        self.status = status;
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    self.backgroundColor = rgb(234, 241, 245);
    [self handleDateData];
    
    CGFloat btnW = ScreenWidth / self.dataSource.count;
    for (int i = 0; i < self.dataSource.count; i++) {
        NSString *str = self.dataSource[i];
        UIButton *dateBtn = [UIButton new];
        [dateBtn setTitleColor:AXUnSelectColor forState:UIControlStateNormal];
        [dateBtn setTitleColor:AXSelectColor forState:UIControlStateSelected];
        dateBtn.backgroundColor = rgb(234, 241, 245);
        [dateBtn setTitle:str forState:UIControlStateNormal];
        
        if ((i == 0 && self.status == AXMatchStatusSchedule) || (i == (self.dataSource.count - 1) && self.status == AXMatchStatusResult)) {
            self.lastSelectedBtn = dateBtn;
            dateBtn.selected = true;
        } else {
            dateBtn.selected = false;
        }
        
        [dateBtn addTarget:self action:@selector(handleDateEvent:) forControlEvents:UIControlEventTouchUpInside];
        dateBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        dateBtn.titleLabel.numberOfLines = 2;
        dateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        dateBtn.tag = i;
        [self addSubview:dateBtn];
        
        [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(btnW);
            make.centerY.top.bottom.offset(0);
            make.left.offset(btnW * i);
        }];
        
//        if (i == 0) {
//
//        }
    }
    
    
    
}

- (void)handleDateEvent: (UIButton *)sender{
    if (self.lastSelectedBtn == sender) {return;}
    sender.selected = true;
    self.lastSelectedBtn.selected = false;
    self.lastSelectedBtn = sender;
    NSLog(@"handleDateEvent");
}

- (void)handleDateData{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * currentDate = [NSDate date];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    
    NSMutableArray *temp = [NSMutableArray array];

    if (self.status == AXMatchStatusResult) {
        for (int i = 6; i >= 0; i --) {
            [comps setDay:-i];
            NSDate * date = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            NSString *dateStr = i == 0 ? @"Today" : [self dateChangeToDataTimeString:date];
            [temp addObject:dateStr];
        }
    } else {
        for (int i = 0; i<7; i++) {
            [comps setDay:i];
            NSDate * date = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            NSString *dateStr = i == 0 ? @"Today" : [self dateChangeToDataTimeString:date];
            [temp addObject:dateStr];
        }
    }
    self.dataSource = temp.copy;
}

//转成 dateFormat
- (NSString *)dateChangeToDataTimeString:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"dd_EEEE";
    NSString *stringDate = [fmt stringFromDate:date];
    
    NSArray <NSString *>*temp = [stringDate componentsSeparatedByString:@"_"];
    NSString *subStr = @"";
    if (temp.count == 2) {
        NSString *t = [temp[1] substringToIndex:3];
        subStr = [NSString stringWithFormat:@"%@\n%@", temp.firstObject, t];
    }
    return subStr;
}

// MARK: setter & getter


@end
