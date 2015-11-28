//
//  ViewController.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMPageController.h"

@interface ViewController : WMPageController

// 内容的首页应该是单例的，每次进程只初始化一次
+ (UINavigationController *)standardMyTuWanNavi;

@end
