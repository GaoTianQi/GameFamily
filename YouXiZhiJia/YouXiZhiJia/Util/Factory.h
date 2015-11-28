//
//  Factory.h
//  BaseProject
//
//  Created by ios－54 on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject

/** 向某个控制器添加菜单按钮 */
+ (void)addMenuItemToVC:(UIViewController *)vc;

/** 想某个控制器，添加返回按钮 */
+ (void)addBackItemToVC:(UIViewController *)vc;

@end
