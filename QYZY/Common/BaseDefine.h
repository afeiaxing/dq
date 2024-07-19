//
//  BaseDefine.h
//  QYZY
//
//  Created by jspollo on 2022/9/29.
//

#ifndef BaseDefine_h
#define BaseDefine_h

typedef NS_ENUM(NSInteger ,QYZYMatchType) {
    QYZYMatchTypeFootball = 1,
    QYZYMatchTypeBasketball = 2
};

typedef enum : NSUInteger {
    AXMatchStatusAll,
    AXMatchStatusLive,
    AXMatchStatusSchedule,
    AXMatchStatusResult,
//    AXMatchStatusFavorite,
} AXMatchStatus;

typedef void(^AXVoldBlock) (void);
typedef void(^AXIntBlock) (int num);
typedef void(^AXBoolBlock) (BOOL isValue);
typedef void(^AXStringBlock) (NSString *string);

#define ScreenWidth UIScreen.mainScreen.bounds.size.width
#define ScreenHeight UIScreen.mainScreen.bounds.size.height

#define rgba(r,g,b,a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define rgb(r,g,b) rgba(r,g,b,1)

#define PingFangSC_Regular @"PingFangSC-Regular"
#define PingFangSC_Medium @"PingFangSC-Medium"
#define PingFangSC_Semibold @"PingFangSC-Semibold"


//MARK: - font
// System font.
#define AX_System_Font(value)   [UIFont systemFontOfSize:(value)]

// Bold system font.
#define AX_BoldSystemFont(value)    [UIFont boldSystemFontOfSize:(value)]

// 设计图上 用到的 BarlowCondensed-Medium
#define AX_BarlowMedium_Font(value) [UIFont fontWithName:@"BarlowCondensed-Medium" size:(value)];

// 设计图上 用到的 DINCondensed-Bold 字体
#define AX_Condensed_Bold_Font(value)   [UIFont fontWithName:@"DINCondensed-Bold" size:(value)]

// 设计图上 用到的 DINAlternate-Bold 字体
#define AX_DINAlternate_Bold_Font(value)    [UIFont fontWithName:@"DINAlternate-Bold" size:(value)]

// PingFangSC
#define AX_PingFangLight_Font(value)    [UIFont fontWithName:@"PingFangSC-Light" size:(value)]
#define AX_PingFangRegular_Font(value)  [UIFont fontWithName:@"PingFangSC-Regular" size:(value)]
#define AX_PingFangMedium_Font(value)   [UIFont fontWithName:@"PingFangSC-Medium" size:(value)]
#define AX_PingFangSemibold_Font(value) [UIFont fontWithName:@"PingFangSC-Semibold" size:(value)]
#define AX_PingFangHKSemibold_Font(value)   [UIFont fontWithName:@"PingFang-HK-Semibold" size:(value)]
#define AX_PingFangHKRegular_Font(value)   [UIFont fontWithName:@"PingFangHK-Regular" size:(value)]

#define  AXSelectColor rgb(255,88,0)
#define  AXUnSelectColor rgb(130,134,163)

#define AXToastText @"Loading..."

// 在主线程延迟若干秒执行block
NS_INLINE void AXRunAfter(NSTimeInterval time,dispatch_block_t x){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time) * NSEC_PER_SEC)), dispatch_get_main_queue(), x);
}

/// log
#ifdef __OPTIMIZE__
#define AXLog(...) {}
#else
#define AXLog(...) NSLog(__VA_ARGS__)
#endif

#define AXProductTypeKey @2

#define AXLeaguePlaceholderLogo [UIImage imageNamed:@"match_team_placeholder"]
#define AXTeamPlaceholderLogo [UIImage imageNamed:@"match_team_placeholder"]

#define weakSelf(type)  __weak typeof(type) weak##type = type;
#define strongSelf(type)  __strong typeof(weak##type) type = weak##type;

// 宽度比例适配
#define QYZY_SCALE(value)           ceil(1.0 * (value) * SCREEN_WIDTH / 375.0)

// 高度比例适配
#define QYZY_HEIGHT_SCALE(value)    ceil(1.0 * (value) * SCREEN_HEIGHT / 667.0)

#define QYZY_DEFAULT_AVATAR [UIImage imageNamed:@"avatar_placeholder"]
#define QYZY_DEFAULT_LOGO [UIImage imageNamed:@"logo_placeholder"]

#define ReadLoginAgreementKey @"ReadLoginAgreementKey"

#endif /* BaseDefine_h */


#ifndef EnableRequestEncrpt
#define EnableRequestEncrpt 1
#endif

