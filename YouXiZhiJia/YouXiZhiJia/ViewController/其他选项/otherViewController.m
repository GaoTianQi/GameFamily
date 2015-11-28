//
//  otherViewController.m
//  YouXiZhiJia
//
//  Created by ios－54 on 15/11/17.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "otherViewController.h"
#import "WelcomeViewController.h"

@interface otherViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation otherViewController

+ (UINavigationController *)defaultOtherVC
{
    static UINavigationController *navi = nil;
    otherViewController *vc = [[otherViewController alloc]init];
    navi = [[UINavigationController alloc]initWithRootViewController:vc];
    return navi;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"其他设置";
    [Factory addMenuItemToVC:self];
    [self tableView];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"显示欢迎界面";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"非Wi-Fi下关闭网络";
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"3D显示缓存图片";
    }
    cell.accessoryType = 1;
    return cell;
}

kRemoveCellSeparator;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        WelcomeViewController *vc = [[WelcomeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController setToolbarHidden:YES];
    }else{
        [self showErrorMsg:@"该功能正在完善"];
    }
}

@end
