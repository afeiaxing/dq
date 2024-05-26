//
//  AXMatchTools.m
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import "AXMatchTools.h"

@implementation AXMatchTools

// 1:未开赛，2:第1节，3:第1节完，4:第2节，5:第2节完，6:第3节，:第3节完，8:第4节，9:加时，10:完
+ (NSString *)handleMatchStatusText: (NSInteger)matchStatus{
    NSString *statusText;
    switch (matchStatus) {
        case 1:
            statusText = nil;
            break;
        case 2:
            statusText = @"Q1";
            break;
        case 3:
            statusText = @"Q1";
            break;
        case 4:
            statusText = @"Q2";
            break;
        case 5:
            statusText = @"Q2";
            break;
        case 6:
            statusText = @"Q3";
            break;
        case 7:
            statusText = @"Q3";
            break;
        case 8:
            statusText = @"Q4";
            break;
        case 9:
            statusText = @"OT";
            break;
        default:
            break;
    }
    return statusText;
}

@end
