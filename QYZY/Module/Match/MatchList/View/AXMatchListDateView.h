//
//  AXMatchListDateView.h
//  QYZY
//
//  Created by 22 on 2024/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AXMatchListDateViewBlock)(AXMatchStatus status, NSString *dateString);

@interface AXMatchListDateView : UIView

@property (nonatomic, copy) AXMatchListDateViewBlock block;

- (instancetype)initWithStatus: (AXMatchStatus)status;

@end

NS_ASSUME_NONNULL_END
