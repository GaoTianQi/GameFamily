//
//  AppDelegate.h
//  YouXiZhiJia
//
//  Created by ios－54 on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RESideMenu.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) RESideMenu *sideMenu;

@property (nonatomic,getter=isOnLine) BOOL onLine; //网络状态

@end

