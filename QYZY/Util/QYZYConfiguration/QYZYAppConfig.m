//
//  QYZYAppConfig.m
//  QYZY
//
//  Created by jsmaster on 9/29/22.
//

#import "QYZYAppConfig.h"
#import "IQKeyboardManager.h"
#import "QYZYRIMManager.h"
#import "JPUSHService.h"
#import <UMCommon/UMCommon.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface QYZYAppConfig () <JPUSHRegisterDelegate>

@end

@implementation QYZYAppConfig


+ (void)configWithapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configNetwork];
//    [QYZYRIMManager.shareInstace requestKeyData];
    [self configKeyboard];
//    [self configUmeng];
//    [self configJiGugangWithapplication:application didFinishLaunchingWithOptions:launchOptions];
    
}

#pragma mark - network
+ (void)configNetwork {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = @"http://114.55.36.227:48084";  // TODO: 域名待配置
    /**
     * UAT：https://bifenh5.c66uat.com
     * Prod：https://bifenh5.arenaplus.org
     */
    config.baseUrl = @"https://bifenh5.arenaplus.org";  // TODO: 域名待配置
    
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if ((status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:QYZYNetworkingFirstAvaliableNotification object:nil];
//        }
//
//    }];
}

#pragma mark - Keyboard
+ (void)configKeyboard {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

#pragma mark - JiGugang
+ (void)configJiGugangWithapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    
    if (@available(iOS 12.0, *)) {
       entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
     } else {
       entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
     }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    NSString *appKey  = @"09986335d73a3d8569c0023b";
    NSString *channel = nil;
    BOOL isProduction = NO;
#ifdef DEBUG
    channel = nil;
    isProduction = NO;
#else
    channel = @"App Store";
    isProduction = YES;
#endif
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
      
    }];
    
    [JPUSHService setBadge:0];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
+ (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler(0 /*UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert*/); //
}

// iOS 10 Support
+ (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
}



#ifdef __IPHONE_12_0
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification  API_AVAILABLE(ios(10.0)){
    
}
#endif

#pragma mark - Umeng
+ (void)configUmeng {
    [UMConfigure initWithAppkey:@"5e43ceaacb23d2efa7000076" channel:@"Apple Store"];
}

@end
