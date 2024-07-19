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
    AXMatchListScoreCustomViewOT,
    AXMatchListScoreCustomViewTot,
};

typedef NS_ENUM(NSInteger ,AXMatchListScoreCustomMarketType) {
    AXMatchListScoreCustomMarketTypeHandicap,
    AXMatchListScoreCustomMarketTypeOU,
    AXMatchListScoreCustomMarketTypeMoneyline,
};

@interface AXMatchListScoreCustomView : UIView

@property (nonatomic, assign) AXMatchListScoreCustomViewType viewType;
@property (nonatomic, assign) AXMatchListScoreCustomMarketType marketType;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) BOOL isNeedHighlight;

/// init
/// - Parameters:
///   - hostscoreTopMargin: 顶部间隔，详情页会设置，为了适配UI
///   - isNeedScoreSize: 比分数值Label是否需要宽高，赛事列表，进行中的比分需要设置
- (instancetype)initWithHostscoreTopMargin: (CGFloat)hostscoreTopMargin
                           isNeedScoreSize: (BOOL)isNeedScoreSize;

// 禁用不应该使用的初始化方法
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

// 处理变色逻辑
- (void)handleScoreChangeColor: (BOOL)isHost;

@end

NS_ASSUME_NONNULL_END
