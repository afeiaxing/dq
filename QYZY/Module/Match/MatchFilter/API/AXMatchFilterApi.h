//
//  AXMatchFilterApi.h
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import "AXRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchFilterApi : AXRequest

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *sign;

@end

NS_ASSUME_NONNULL_END
