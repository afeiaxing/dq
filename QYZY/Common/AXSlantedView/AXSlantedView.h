//
//  AXSlantedView.h
//  QYZY
//
//  Created by 22 on 2024/6/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXSlantedView : UIView

@property (nonatomic, copy) NSString *text;

- (instancetype)initWithFillColor:(UIColor *)fillColor
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
