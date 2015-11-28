//
//  GameIntroViewController.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameIntroViewController : UIViewController

@property (nonatomic, strong) NSString *gameName;

- (instancetype)initWithNumber:(NSInteger)number;
@property (nonatomic, assign) NSInteger number;

@end
