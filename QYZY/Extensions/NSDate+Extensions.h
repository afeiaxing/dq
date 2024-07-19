//
//  NSDate+Extensions.h
//  QYZY
//
//  Created by jsmaster on 9/28/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extensions)

- (NSUInteger)getDay;
- (NSDate *)endOfMonth;
- (NSInteger)weekday;
- (NSString *)xm_stringWithFormat:(NSString *)format;
+ (NSInteger)qyzy_getCurrentMillisecondTimestamp;
+ (NSString *)getDateStringWithDate:(NSDate *)date formatter:(NSString *)formatter;
+ (NSInteger)getDaysInMonthFromDate:(NSDate*)date;

/// 获取某一天的开始时间戳（0点）
+ (NSTimeInterval)getDayStartTimestampWithDateString: (NSString *)dateString;
/// 获取某一天的结束时间戳（23:59:59）
+ (NSTimeInterval)getDayEndTimestampWithDateString: (NSString *)dateString;
// 将时间由"2024-06-08"转换成 "Sat, 8 Jun"
+ (NSString *)getScheduleMatchTimeWithDatestring: (NSString *)datestring;
// 将时间由"1717831800"转换成 "Sat, 8 Jun"
+ (NSString *)getScheduleMatchTimeWithTimestamp: (NSString *)timestamp;
// 将时间由"1717831800"转换成 "Jun 8"
+ (NSString *)getScheduleMatchTime2WithTimestamp: (NSString *)timestamp;

@end

NS_ASSUME_NONNULL_END
