//
//  AXMatchListRequest.h
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import <Foundation/Foundation.h>
#import "AXMatchListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchListRequest : NSObject

- (void)requestMatchListWithType: (AXMatchStatus)type
                          pageNo: (int)pageNo
                       startTime: (NSString *)startTime
                         endTime: (NSString *)endTime
                          filter: (NSString *)filter
                      completion: (void(^)(AXMatchListModel *matchModel))completion;

@end

NS_ASSUME_NONNULL_END
