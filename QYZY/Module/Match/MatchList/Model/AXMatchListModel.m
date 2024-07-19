//
//  AXMatchListModel.m
//  QYZY
//
//  Created by 22 on 2024/5/25.
//

#import "AXMatchListModel.h"

@implementation AXMatchListItemModel

@end



@implementation AXMatchListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"schedule":[AXMatchListItemModel class],
        @"live":[AXMatchListItemModel class],
        @"result":[AXMatchListItemModel class],
    };
}

@end
