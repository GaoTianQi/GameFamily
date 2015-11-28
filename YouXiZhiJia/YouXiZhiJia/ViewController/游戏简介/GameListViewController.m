//
//  GameListViewController.m
//  Day07_GameLive
//
//  Created by ios－54 on 15/10/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "GameListViewController.h"
#import "XGGameListViewModel.h"
#import "GameIntroViewController.h"
#import "DataPersistence2.h"

@interface GameListViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) XGGameListViewModel *gameListVM;
@property (nonatomic) NSInteger number;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation GameListViewController

- (XGGameListViewModel *)gameListVM
{
    if (!_gameListVM) {
        _gameListVM = [XGGameListViewModel new];
    }
    return _gameListVM;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameIntroViewController *vc = segue.destinationViewController;
    NSIndexPath *ind = [self.collectionView indexPathForCell:sender];
    vc.gameName = [self.gameListVM nameWithForRow:ind.row];
}


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Factory addMenuItemToVC:self];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.gameListVM getDataFromNetCompleteHandle:^(NSError *error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.collectionView.mj_header  endRefreshing];
            }
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.gameListVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:100];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:200];
    label.text = [self.gameListVM nameWithForRow:indexPath.row];
    [imageView setImageWithURL:[self.gameListVM iconURLWithForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"noNet_"]];
    cell.layer.cornerRadius = 10;
    imageView.layer.cornerRadius = 10;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 9) {
        [[DataPersistence2 defaultDataPersistence] writeToLibraryOfName:[self.gameListVM nameWithForRow:indexPath.row] contents:@(indexPath.row)];
        GameIntroViewController *vc = [[GameIntroViewController alloc]initWithNumber:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self showErrorMsg:@"我们正在抓紧时间收集中"];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 四周边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 9;
}
// 每个cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.bounds.size.width - 4 * 10) / 3;
//  220 * 365 宽＊高
    
    CGFloat height = width * 365.0/220.0;
    return CGSizeMake(width, height);
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
