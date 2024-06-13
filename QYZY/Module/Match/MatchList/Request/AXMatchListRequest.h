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

@property (nonatomic, strong) NSString *batchMatchIds;

- (void)requestMatchListWithType: (AXMatchStatus)type
                          pageNo: (int)pageNo
                       startTime: (NSString *)startTime
                         endTime: (NSString *)endTime
                          filter: (NSString *)filter
                      completion: (void(^)(AXMatchListModel *matchModel, BOOL hasMoreData))completion;

- (void)requestBatchMatchWithMatchId: (NSString *)matchIds
                          completion: (void(^)(NSArray <AXMatchListItemModel *> *matchArray))completion;

@end

NS_ASSUME_NONNULL_END
