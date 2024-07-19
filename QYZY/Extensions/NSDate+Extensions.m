//
//  NSDate+Extensions.m
//  QYZY
//
//  Created by jsmaster on 9/28/22.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

/// 获取当前时间戳 【毫秒级】
+ (NSInteger)qyzy_getCurrentMillisecondTimestamp {
    NSTimeInterval interval = [NSDate.date timeIntervalSince1970];
    long long milliseconds = interval * 1000;
    return milliseconds;
}

+ (NSString *)getDateStringWithDate:(NSDate *)date formatter:(NSString *)formatter {
    NSDateFormatter *forM = [[NSDateFormatter alloc] init];
    [forM setDateFormat:formatter];
    
    return [forM stringFromDate:date];
}

+ (NSInteger)getDaysInMonthFromDate:(NSDate*)date {
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days  = [c rangeOfUnit:NSCalendarUnitDay
                            inUnit:NSCalendarUnitMonth
                           forDate:date];
    return days.length;
}

- (NSUInteger)getDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    return [dayComponents day];
}

- (NSDate *)dateAfterDay:(NSUInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
}

- (NSDate *)dateafterMonth:(int)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterMonth;
}

- (NSDate *)beginningOfMonth {
    NSUInteger i = - [self getDay] + 1;
    return [self dateAfterDay: i];
}

- (NSDate *)nextBeginningOfMonth {
    return [[self beginningOfMonth] dateafterMonth:1];
}

- (NSDate *)endOfMonth {
    return [[self nextBeginningOfMonth] dateAfterDay:-1];
}

- (NSString *)xm_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSDateComponents *)dateComponents:(NSUInteger)components {
    return [[NSCalendar currentCalendar] components:components fromDate:self];
}

- (NSDateComponents *)dateComponentsWeekday {
    NSUInteger components = (NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekday |
                             NSCalendarUnitMonth | NSCalendarUnitYear);
    return [self dateComponents:components];
}

- (NSInteger)weekday {
    return [self dateComponentsWeekday].weekday;
}

+ (NSTimeInterval)getDayStartTimestampWithDateString: (NSString *)dateString{
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // 将字符串转换为日期
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    // 获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取日期的开始和结束时间
    NSDate *startOfDay;
    
    // 获取这一天的起始时间
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&startOfDay interval:NULL forDate:date];
    
    // 获取时间戳
    NSTimeInterval startOfDayTimestamp = [startOfDay timeIntervalSince1970];
    
    return startOfDayTimestamp;
}

+ (NSTimeInterval)getDayEndTimestampWithDateString: (NSString *)dateString{
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // 将字符串转换为日期
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    // 获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取日期的开始和结束时间
    NSDate *startOfDay;
    NSDate *endOfDay;
    
    // 获取这一天的起始时间
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&startOfDay interval:NULL forDate:date];
    
    // 获取这一天的结束时间（次日0点）
    endOfDay = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startOfDay options:0];
    
    // 获取时间戳
    NSTimeInterval endOfDayTimestamp = [endOfDay timeIntervalSince1970];
    return endOfDayTimestamp - 1;
}

// 将时间
+ (NSString *)getScheduleMatchTimeWithDatestring: (NSString *)datestring{
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置输入日期格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // 将字符串转换为日期对象
    NSDate *date = [dateFormatter dateFromString:datestring];
    
    // 设置输出日期格式
    [dateFormatter setDateFormat:@"EEE, d MMM"];
    
    // 将日期对象转换为目标格式字符串
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    return formattedDateString;
}

+ (NSString *)getScheduleMatchTimeWithTimestamp: (NSString *)timestamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.integerValue];
    
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置输出日期格式
    [dateFormatter setDateFormat:@"EEE, d MMM"];
    
    // 将日期对象转换为目标格式字符串
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    return formattedDateString;
}

+ (NSString *)getScheduleMatchTime2WithTimestamp: (NSString *)timestamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.integerValue];
    
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置输出日期格式
    [dateFormatter setDateFormat:@"MMM-dd"];
    
    // 将日期对象转换为目标格式字符串
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    return formattedDateString;
}

@end
