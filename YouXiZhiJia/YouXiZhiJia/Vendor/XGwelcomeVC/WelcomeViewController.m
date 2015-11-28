//
//  WelcomeViewController.m
//  欢迎界面
//
//  Created by ios－54 on 15/9/17.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UIView+Extension.h"
#import "AppDelegate.h"

#define IMAGECOUNT 2

@interface WelcomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建滚动视图实例
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    // 设置滚动视图的代理
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    
    // 2.添加滚动视图到self.view中
    [self.view addSubview:scrollView];
    
    // 3.配置滚动视图
    // 配置边缘不可以弹跳
    scrollView.bounces = NO;
    // 设置整页滚动
    scrollView.pagingEnabled = YES;
    // 大小中，竖直不想滚动可以设置为0；
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * IMAGECOUNT, 0);
    
    // 4.向滚动视图中添加图片
    for (NSInteger i = 0; i < IMAGECOUNT; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = YES;
        NSString *imageName = [NSString stringWithFormat:@"welcome%ld",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        
        imageView.frame = CGRectMake(i*scrollView.frame.size.width, 0, self.view.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:imageView];
        if (i == IMAGECOUNT - 1) {
            [self creatButtonEnterMainVC:imageView];
        }
    }
    // 配置UIPageController
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.frame = CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 40);
    // 设置圆点没有选中时的颜色
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    // 设置圆点选中时的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    // 设置一共有几个点
    pageControl.numberOfPages = IMAGECOUNT;
    // 禁止与用户交互（用户点击后无响应）
    // 将分页控件添加到self.view中
    pageControl.userInteractionEnabled = NO;
    
    // 修改被选中圆点的位置
    
    [self.view addSubview:pageControl];
}

//  滚动视图协议中的方法：一滚动就执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    double i = offset.x/scrollView.frame.size.width;
    self.pageControl.currentPage = round(i);
    //NSLog(@"%lf", i);
    //NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

// 创建按钮进入主界面
- (void)creatButtonEnterMainVC:(UIImageView *)imageView
{
    UIButton *button = [[UIButton alloc]init];
    button.font = [UIFont boldFlatFontOfSize:30];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    [imageView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView);
        make.bottom.mas_equalTo(-50);
    }];
    [button bk_addEventHandler:^(id sender) {
        UIWindow *window = [[UIApplication sharedApplication]keyWindow];
        window.rootViewController = [AppDelegate new].sideMenu;
    } forControlEvents:UIControlEventTouchUpInside];
}

@end
