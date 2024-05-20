//
//  AppDelegate.m
//  QYZY
//
//  Created by jsmaster on 9/27/22.
//

#import "AppDelegate.h"
#import "QYZYLiveViewController.h"
#import "QYZYMatchViewController.h"
#import "QYZYAppConfig.h"
#import "JPUSHService.h"
#import "QYZYCustomNavigationController.h"
#import "QYZYUserManager.h"
#import "AXStreamViewController.h"
#import "AXProfileViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [QYZYAppConfig configWithapplication:application didFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [self setupTabbarVC];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UITabBarController *)setupTabbarVC {
    UITabBarController * tabbarVC = [[UITabBarController alloc]init];
    tabbarVC.tabBar.barTintColor = UIColor.whiteColor;
    if (@available(iOS 15.0, *)) {
        tabbarVC.tabBar.scrollEdgeAppearance = tabbarVC.tabBar.standardAppearance;
    }
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : rgba(130, 134, 163,1)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : AXSelectColor} forState:UIControlStateSelected];
    
//    tabbarVC.tabBar.tintColor = rgba(130, 134, 163,1);
//    tabbarVC.tabBar.unselectedItemTintColor = rgba(255, 88, 0,1);
    
    [self addChildVCWithTabbarVC:tabbarVC vc:QYZYMatchViewController.new title:@"For You" selectedImage:@"tabSaichengH" image:@"tabSaichengN"];
    [self addChildVCWithTabbarVC:tabbarVC vc:AXStreamViewController.new title:@"Top Games" selectedImage:@"tabZhiboH" image:@"tabZhiboN"];
    [self addChildVCWithTabbarVC:tabbarVC vc:QYZYLiveViewController.new title:@"News" selectedImage:@"tabZixunH" image:@"tabZixunN"];
    [self addChildVCWithTabbarVC:tabbarVC vc:AXProfileViewController.new title:@"Profile" selectedImage:@"tabWodeH" image:@"tabWodeN"];
    
    tabbarVC.selectedIndex = 0;
    
    return tabbarVC;
}

- (void)addChildVCWithTabbarVC:(UITabBarController *)tabbaeVC vc:(UIViewController *)vc title:(NSString *)title selectedImage:(NSString *)selectedImage image:(NSString *)image {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabbaeVC addChildViewController:[[QYZYCustomNavigationController alloc] initWithRootViewController:vc]];
}

//- (void)exitUser:(NSNotification *)note {
//    [QYZYUserManager.shareInstance saveUserModel:nil];
//    NSString *info = note.userInfo[QYZYUserExitNotificationInfoKey];
//    [UIView qyzy_showMsg:info];
//    self.window.rootViewController = [self setupTabbarVC];
//}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
     [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
     completionHandler(UIBackgroundFetchResultNewData);
}

@end
