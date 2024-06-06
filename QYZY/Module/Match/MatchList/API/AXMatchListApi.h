//
//  AXMatchListApi.h
//  QYZY
//
//  Created by 22 on 2024/5/23.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchListApi : AXRequest

/// 缺省是全部；1是live；2是scheduled；3是result
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int pageNo;

@end

NS_ASSUME_NONNULL_END
