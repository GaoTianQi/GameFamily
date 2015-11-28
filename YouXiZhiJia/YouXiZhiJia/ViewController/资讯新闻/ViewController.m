//
//  ViewController.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "TuWanViewModel.h"
#import "CategoryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

+ (UINavigationController *)standardMyTuWanNavi
{
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ViewController *vc = [[ViewController alloc]initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        //     例如设置第一个控制器的某个属性的值
        //     [vc setValue:[values[0]] forKey:keys[0]];
        vc.keys = [self vcKeys];
        vc.values = [self vcValues];
        
        navi = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return navi;
}

/** 提供每个vc对应的key值数组 */
+ (NSArray *)vcKeys
{
    NSMutableArray *arr = [NSMutableArray array];
    for (id obj in [self itemNames]) {
        [arr addObject:@"TuWanType"];
    }
    return [arr copy];
}

+ (NSArray *)vcValues
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<[self itemNames].count; i++) {
        //    数值上每个vc的TuWanType的枚举值恰好和i值相同
        [arr addObject:@(i)];
    }
    return [arr copy];
}


/**
 *  提供题目数组
 *
 *  @return 这个数组
 */
+ (NSArray *)itemNames
{
    return @[@"暗黑3", @"魔兽", @"风暴", @"炉石", @"星际2", @"守望"];
}

/**
 *  提供每个题目对应的控制器的类型，必须和题目一一对应
 *
 *  @return 这个控制器数组
 */
+ (NSArray *)viewControllerClasses
{
    NSMutableArray *arr = [NSMutableArray array];
    for (id obj in [self itemNames]) {
        [arr addObject:[CategoryViewController class]];
    }
    return [arr copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenSeaColor];
    self.title = @"游戏分类";
    
    [Factory addMenuItemToVC:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
