//
//  XGGameListViewModel.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "XGGameListViewModel.h"

@implementation XGGameListViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [XGGameNetManager getGameListCompletionHandle:^(GameListModel *model, NSError *error) {
        self.dataArr = [model.data copy];
        completionHandle(error);
    }];
}
- (GameListDataModel *)getModelFromRow:(NSInteger)row
{
    return self.dataArr[row];
}

- (NSInteger)rowNumber
{
    return self.dataArr.count;
}

- (NSURL *)iconURLWithForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self getModelFromRow:row].game_icon];
}
- (NSString *)nameWithForRow:(NSInteger)row
{
    return [self getModelFromRow:row].game_name;
}
- (NSString *)cateIdForRow:(NSInteger)row
{
    return [self getModelFromRow:row].cate_id;
}

@end
