//
//  AXMatchListApi.h
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

#define AXMatchListRequestPageSize @100

@interface AXMatchListApi : AXRequest

/// 缺省是全部；1是live；2是scheduled；3是result
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *filter;

@end

NS_ASSUME_NONNULL_END
