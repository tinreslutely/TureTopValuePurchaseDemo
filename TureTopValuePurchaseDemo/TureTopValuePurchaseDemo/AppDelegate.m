//
//  AppDelegate.m
//  TureTopValuePurchaseDemo
//
//  Created by 李晓毅 on 16/1/12.
//  Copyright © 2016年 铭道超值购. All rights reserved.
//

#import "AppDelegate.h"
#import "MDTabBarController.h"
#import "Reachability.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    Reachability *_hostReach;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupWindow];
    [self setupCheckNetwork];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark private methods
/*!
 *  配置window
 */
-(void)setupWindow{
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    [self.window setRootViewController:[[MDTabBarController alloc] init]];
    [self.window makeKeyAndVisible];
}
/*!
 *  配置网络检查通知
 */
-(void)setupCheckNetwork{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    _hostReach = [Reachability reachabilityWithHostName:@"weilinli.turetop.com"];
    [_hostReach startNotifier];
}
/*!
 *  网络状态检测方法
 *
 *  @param note 通知对象
 */
-(void)reachabilityChanged:(NSNotification*)note{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            APPDATA.networkStatus = -1;
            break;
        case ReachableViaWiFi:
        case ReachableViaWWAN:
            APPDATA.networkStatus = 2;
            break;
        case ReachableVia2G:
        case ReachableVia3G:
            APPDATA.networkStatus = 0;
            break;
        case ReachableVia4G:
            APPDATA.networkStatus = 1;
            break;
    }
}
@end
