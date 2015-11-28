//
//  XGGameNetManager.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "GameListModel.h"

@interface XGGameNetManager : BaseNetManager

/**
 *  获取游戏列表
 *
 *  @param completionHandle 返回请求的网络数据模型
 *
 *  @return 返回当前任务
 */
+ (id)getGameListCompletionHandle:(void(^)(GameListModel *model, NSError *error))completionHandle;


@end
