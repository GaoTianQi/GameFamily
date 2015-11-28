//
//  AppDelegate+Category.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate+Category.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "MobClick.h"
#import "DataPersistence.h"
#import "DataPersistence2.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import <MLTransition.h>
//友盟统计中的
#define AppKey @"5632e65ae0f55a556a0013d9"

@implementation AppDelegate (Category)

- (void)initializeWithApplication:(UIApplication *)application{
    //  注册DDLog 取代 NSLog
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    //    电池条显示网络活动
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //    检测网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        DDLogVerbose(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.onLine = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                self.onLine = NO;
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //  注册友盟分析
    //  参数二：报告的频率， BATCH默认值，每次启动时发送
    [MobClick startWithAppkey:AppKey reportPolicy:BATCH channelId:nil];
    [UMSocialData setAppKey:AppKey];
    [UMSocialWechatHandler setWXAppId:@"wx945b58aef3a271f0" appSecret:@"0ae78dd42761fd9681b04833c79a857b" url:@"http://www.umeng.com/social"];
    
//  友盟统计会默认的关闭系统的崩溃提示,在这里我们将其打开
    [MobClick setLogEnabled:YES];
    
    //解决因为使用leftItem导致iOS7自带的右划返回前一页失效问题（保密）
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    
    [self createPlist];
}

/** 创建本地存储数据的plist问价 */
- (void)createPlist
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:kDataPath]) {
        [[DataPersistence defaultDataPersistence] createPlistByCode];
    } 
    if (![manager fileExistsAtPath:kDataPath2]) {
        [[DataPersistence2 defaultDataPersistence] createPlistByCode];
    }
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
