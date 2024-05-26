//
//  AXMatchListScoreCustomView.h
//  QYZY
//
//  Created by 22 on 2024/5/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,AXMatchListScoreCustomViewType) {
    AXMatchListScoreCustomViewQ1,
    AXMatchListScoreCustomViewQ2,
    AXMatchListScoreCustomViewQ3,
    AXMatchListScoreCustomViewQ4,
    AXMatchListScoreCustomViewOT1,
    AXMatchListScoreCustomViewOT2,
    AXMatchListScoreCustomViewTot,
    AXMatchListScoreCustomViewHandicap,
    AXMatchListScoreCustomViewOU,
    AXMatchListScoreCustomViewMoneyline,
};

@interface AXMatchListScoreCustomView : UIView

@property (nonatomic, assign) AXMatchListScoreCustomViewType viewType;
@property (nonatomic, strong) NSArray *datas;

@end

NS_ASSUME_NONNULL_END
