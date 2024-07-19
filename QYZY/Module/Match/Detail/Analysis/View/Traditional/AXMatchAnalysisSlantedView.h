//
//  AXMatchAnalysisSlantedView.h
//  QYZY
//
//  Created by 22 on 2024/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisSlantedView : UIView

@property (nonatomic, strong) NSString *title;

- (instancetype)initWithIsHost: (BOOL)isHost;

// 禁用不应该使用的初始化方法
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
