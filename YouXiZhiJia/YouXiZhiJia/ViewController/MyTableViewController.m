//
//  MyTableViewController.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyTableViewController.h"
#import "TuWanViewController.h"
#import "MiddleViewController.h"
#import "UMSocial.h"

@interface MyTableViewController ()<UMSocialUIDelegate>

@end

@implementation MyTableViewController

+ (MyTableViewController *)defaultTabBar
{
    static MyTableViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[MyTableViewController alloc]init];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *first = [TuWanViewController standardTuWanNavi];
    first.tabBarItem.title = @"游戏资讯";
    first.tabBarItem.image = [UIImage imageNamed:@"tabbar_company_home"];
    [first.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_company_home_select"]];
    
    UINavigationController *second = nil;
    second = kVCFromSb(@"StoryboardStart", @"Main");
    second.tabBarItem.title = @"游戏简介";
    second.tabBarItem.image = [UIImage imageNamed:@"tabbar_position_oringin"];
    [second.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_position_selected"]];
    
    MiddleViewController *middle = [[MiddleViewController alloc] init];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"middleImage"] highlightImage:nil];
    
    self.tabBar.translucent = NO;
    
    self.viewControllers = @[first,middle,second];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//添加中间按钮
- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    [self.view addSubview:button];

}

- (void)buttonClick
{
    NSLog(@"点击中间按钮");
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5632e65ae0f55a556a0013d9"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToSms,UMShareToEmail,UMShareToWechatTimeline,nil]
                                       delegate:self];
}

@end
