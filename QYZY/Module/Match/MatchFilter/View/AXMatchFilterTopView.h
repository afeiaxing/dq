//
//  AXMatchFilterTopView.h
//  QYZY
//
//  Created by 22 on 2024/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchFilterTopView : UIView

@property (nonatomic, copy) AXIntBlock block;
@property (nonatomic, copy) AXStringBlock searchBlock;

@end

NS_ASSUME_NONNULL_END
