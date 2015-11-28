//
//  GameIntroViewController.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "GameIntroViewController.h"


@interface GameINtroCell : UITableViewCell

@property (nonatomic, strong) UILabel *label;

@end

@implementation GameINtroCell

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:18];
        //自动换行
        _label.numberOfLines = 0;
    }
    return _label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return self;
}

@end


@interface GameIntroViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation GameIntroViewController

- (instancetype)initWithNumber:(NSInteger)number
{
    if (self = [super init]) {
        self.number = number;
    }
    return self;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView=[UIView new];
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[GameINtroCell class] forCellReuseIdentifier:@"DetailCell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"GameIntro" ofType:@"plist"];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    self.datas = [NSMutableArray array];
    for (NSDictionary *dic in dataArr) {
        [self.datas addObjectsFromArray:dic.allValues];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[@"游戏简介", @"游戏背景"][section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameINtroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    NSArray *arr = self.datas[self.number];
    cell.label.text = @[arr.firstObject, arr.lastObject][indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
