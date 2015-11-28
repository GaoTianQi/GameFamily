//
//  XGGameListViewModel.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "XGGameNetManager.h"

@interface XGGameListViewModel : BaseViewModel

/** 返回游戏列表中行数 */
@property (nonatomic, assign) NSInteger rowNumber;

/** 返回游戏图片 */
- (NSURL *)iconURLWithForRow:(NSInteger)row;

/** 返回游戏名称*/
- (NSString *)nameWithForRow:(NSInteger)row;

/**  返回游戏的编号 cate_id */
- (NSString *)cateIdForRow:(NSInteger)row;

@end
