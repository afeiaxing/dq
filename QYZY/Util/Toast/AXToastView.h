//
//  AXToastView.h
//  QYZY
//
//  Created by 22 on 2024/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AXToastType) {
    AXToastTypeLoadingWithBG,
    AXToastTypeLoadingWithoutBG,
};

@interface AXToastView : UIView

- (instancetype)initWithToastType:(AXToastType)type
                            toast:(NSString *)toast
                           offset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
