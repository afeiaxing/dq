//
//  AXMatchListDateView.h
//  QYZY
//
//  Created by 22 on 2024/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AXMatchListDateViewBlock)(AXMatchStatus status, int index);

typedef enum : NSUInteger {
    AXMatchStatusAll,
    AXMatchStatusSchedule,
    AXMatchStatusLive,
    AXMatchStatusResult,
//    AXMatchStatusFavorite,
} AXMatchStatus;

@interface AXMatchListDateView : UIView

@property (nonatomic, assign) AXMatchStatus status;
@property (nonatomic, copy) AXMatchListDateViewBlock block;

@end

NS_ASSUME_NONNULL_END
