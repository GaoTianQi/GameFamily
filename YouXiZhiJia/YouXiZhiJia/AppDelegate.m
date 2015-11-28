//
//  AppDelegate.m
//  YouXiZhiJia
//
//  Created by ios－54 on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "LeftViewController.h"
#import "MyTableViewController.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeWithApplication:application];
    
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = infoDict[key];
    NSString *runVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    if (runVersion == nil || ![runVersion isEqualToString:currentVersion]) {
        [[NSUserDefaults standardUserDefaults]setValue:currentVersion forKey:key];
        // 显示欢迎界面面
        self.window.rootViewController =[[WelcomeViewController alloc]init];
    }else{
        self.window.rootViewController = self.sideMenu;
    }
    
    [self configGlobalUIStyle]; // 配置全局UI样式
    
    return YES;
}

/** 配置全局UI的样式 */
- (void)configGlobalUIStyle
{
    /** 设置导航栏不透明 */
    [[UINavigationBar appearance] setTranslucent:NO];
    /** 设置导航栏的背景图 */
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navi3"] forBarMetrics:UIBarMetricsDefault];
    /** 配置导航栏题目的样式 */
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont flatFontOfSize:kNaviTitleFontSize], NSForegroundColorAttributeName:kNaviTitleColor}];
}

/** 代码重构：用代码把功能实现以后，考虑代码结构如何编写可以更加方便后期维护*/
- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (RESideMenu *)sideMenu
{
    
    if (!_sideMenu) {
        _sideMenu = [[RESideMenu alloc]initWithContentViewController:[MyTableViewController defaultTabBar] leftMenuViewController:[LeftViewController new] rightMenuViewController:nil];
        
        //  为sideMenu设置背景图
        _sideMenu.backgroundImage = [UIImage imageNamed:@"Stars"];
        //  隐藏菜单的现实栏
        _sideMenu.menuPrefersStatusBarHidden = YES;
        
        // 不允许菜单栏缩小到边缘还可以继续缩小
        _sideMenu.bouncesHorizontally = NO;
    }
    return _sideMenu;
}

@end

