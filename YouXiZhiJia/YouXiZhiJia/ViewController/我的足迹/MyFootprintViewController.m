//
//  MyFootprintViewController.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyFootprintViewController.h"
#import "MyFootprintViewModel.h"
#import "MyFootprint2ViewModel.h"
#import "DataPersistence.h"
#import "DataPersistence2.h"
#import "TuWanPicViewController.h"
#import "TuWanHtmlViewController.h"
#import "GameIntroViewController.h"

@interface MyFootprintCell : SWTableViewCell

@end

@implementation MyFootprintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //  添加右侧滑出三个按钮
        NSMutableArray *btns = [NSMutableArray array];
        [btns sw_addUtilityButtonWithColor:[UIColor redColor] title:@"删除"];
        [btns sw_addUtilityButtonWithColor:[UIColor greenSeaColor] title:@"标为关心"];
        [self setRightUtilityButtons:btns];
        
    }
    return self;
}

@end

@interface MyFootprintViewController ()<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyFootprintViewModel *MFVM;
@property (nonatomic, strong) MyFootprint2ViewModel *MFVM2;

@property (nonatomic, getter=isXg) BOOL xg;

@end

@implementation MyFootprintViewController

+ (UINavigationController *)defaultMyFootprintVC
{
    static UINavigationController *navi = nil;
    MyFootprintViewController *vc = [[MyFootprintViewController alloc]init];
    navi = [[UINavigationController alloc]initWithRootViewController:vc];
    return navi;
}

- (MyFootprintViewModel *)MFVM
{
    if (!_MFVM) {
        _MFVM = [[MyFootprintViewModel alloc]init];
    }
    return _MFVM;
}
- (MyFootprint2ViewModel *)MFVM2
{
    if (!_MFVM2) {
        _MFVM2 = [[MyFootprint2ViewModel alloc]init];
    }
    return _MFVM2;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        //去掉头部的section和脚步section的显示范围
        _tableView.contentInset=UIEdgeInsetsMake(-40, 0, -1, 0);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"XGCell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[MyFootprintCell class] forCellReuseIdentifier:@"Cell"];
    self.title = @"我的足迹";
    [Factory addMenuItemToVC:self];
    //self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.MFVM getDataArr];
    [self.MFVM2 getDataArr];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        if (self.MFVM.rowNumber == 0) {
            return 1;
        }else{
            return self.MFVM.rowNumber;
        }
    }else{
        if (self.MFVM2.rowNumber == 0) {
            return 1;
        }else{
            return self.MFVM2.rowNumber;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XGCell"];
        cell.textLabel.text = @"我的浏览记录";
        return cell;
    }else if (indexPath.section == 1){
        if (self.MFVM.rowNumber == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XGCell"];
            cell.textLabel.text = @"暂无纪录～～～";
            cell.textColor = [UIColor lightGrayColor];
            return cell;
        }else{
            MyFootprintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.textLabel.text = [self.MFVM titleForRow:indexPath.row];
            cell.accessoryType = 1;
            cell.delegate = self;
            return cell;
        }
    }else{
        if (self.MFVM2.rowNumber == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XGCell"];
            cell.textLabel.text = @"暂无纪录～～～";
            cell.textColor = [UIColor lightGrayColor];
            return cell;
        }else{
            MyFootprintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.textLabel.text = [self.MFVM2 titleForRow:indexPath.row];
            cell.accessoryType = 1;
            cell.delegate = self;
            return cell;
        }
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (section == 0)?@"":(section == 1)?@"新闻历史":@"简介历史";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

kRemoveCellSeparator;

#pragma mark - 跳转方法-----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }else if(indexPath.section == 1 && self.MFVM.rowNumber != 0){
        NSString *data = self.MFVM.dataArr[indexPath.row];
        if (!([data rangeOfString:@"http"].location != NSNotFound) && !([data rangeOfString:@"://"].location != NSNotFound)) {
            TuWanPicViewController *vc = [[TuWanPicViewController alloc]initWithAid:data];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            TuWanHtmlViewController *vc = [[TuWanHtmlViewController alloc]initWithURL:[NSURL URLWithString:data]];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section == 2 && self.MFVM2.rowNumber != 0){
        GameIntroViewController *vc = [[GameIntroViewController alloc]initWithNumber:[self.MFVM2 numberForRow:indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DDLogVerbose(@"index %ld", index);
    if (index == 0 && indexPath.section == 1) {
        [UIAlertView bk_showAlertViewWithTitle:@"警告" message:@"确定删除？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex) {
                [self.MFVM.keyArr removeObjectAtIndex:indexPath.row];
                [self.MFVM.dataArr removeObjectAtIndex:indexPath.row];
                [[DataPersistence defaultDataPersistence] removeBookWithKey:cell.textLabel.text];
                [self.tableView reloadData];
            }
        }];
    }else if(index == 0 && indexPath.section == 2){
        
        [UIAlertView bk_showAlertViewWithTitle:@"警告" message:@"确定删除？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex) {
                [self.MFVM2.keyArr removeObjectAtIndex:indexPath.row];
                [self.MFVM2.dataArr removeObjectAtIndex:indexPath.row];
                [[DataPersistence2 defaultDataPersistence] removeBookWithKey:cell.textLabel.text];
                [self.tableView reloadData];
            }
        }];
        
    }else{
        _xg = !_xg;
        if (_xg) {
            cell.backgroundColor = kRGBColor(244, 160, 255);
        }else{
            cell.backgroundColor = [UIColor clearColor];
        }
    }
}
- (BOOL)isXg{
    return YES;
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}
@end
