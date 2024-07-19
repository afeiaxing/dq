//
//  UIView+AXToast.m
//  QYZY
//
//  Created by 22 on 2024/6/1.
//

#import "UIView+AXToast.h"
#import "UIView+CSToast.h"

@implementation UIView (AXToast)

+ (NSString *)ax_viewId {
    return NSStringFromClass([self class]);
}

- (void)ax_showLoading {
    [self ax_showLoadingToast:AXToastText
                         type:AXToastTypeLoadingWithBG
                       offset:0
                     duration:0];
}

- (void)ax_showNoBGLoading{
    [self ax_showLoadingToast:AXToastText
                         type:AXToastTypeLoadingWithoutBG
                       offset:0
                     duration:0];
}

- (void)ax_showLoadingToast:(NSString *)toast {
    [self ax_showLoadingToast:toast
                         type:AXToastTypeLoadingWithBG
                       offset:0
                     duration:0];
}

- (void)ax_showLoadingToast:(NSString *)toast
                       type:(AXToastType)type
                     offset:(CGFloat)offset
                   duration:(CGFloat)duration {
    [self ax_hideLoading];
    AXToastView * toastView = [[AXToastView alloc] initWithToastType:type
                                                               toast:toast
                                                              offset:offset];
    toastView.frame = CGRectMake(0, 0, 150, 160);
    [toastView setAutoresizingMask:
     (UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin |
      UIViewAutoresizingFlexibleTopMargin |
      UIViewAutoresizingFlexibleBottomMargin)];
    [self cs_showToast:toastView
              duration:duration == 0 ? AXLoadingDuration : duration
              position:CSToastPositionCenter
            completion:nil backgroundEnabled:true];
}

- (void)ax_hideLoading {
    [self cs_hideAllToasts];
}

- (void)ax_showToast:(NSString *)toast {
    [self ax_hideLoading];
    CSToastStyle *style = [CSToastStyle new];
    style.titleAlignment = NSTextAlignmentCenter;
    style.messageAlignment = NSTextAlignmentCenter;
    [self cs_makeToast:toast
              duration:AXToastDuration
              position:CSToastPositionCenter
                 style:style];
}

@end
