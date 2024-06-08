//
//  AXMatchDetailHeaderView.h
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchDetailHeaderView : UIView

@property (nonatomic, strong) AXMatchListItemModel *matchModel;

+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
