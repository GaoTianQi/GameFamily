//
//  XGGameNetManager.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "XGGameNetManager.h"

#define kGameListPath @"http://www.douyutv.com/api/v1/game"

@implementation XGGameNetManager

+ (id)getGameListCompletionHandle:(void (^)(GameListModel *, NSError *))completionHandle
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"ios" forKey:@"client_sys"];
    [dic setObject:@"ios" forKey:@"aid"];
    [dic setObject:@"1427694374" forKey:@"time"];
    [dic setObject:@"a7f87aa94fa4d2cc1b549ba9389533e8" forKey:@"auth"];
    return [self GET:kGameListPath parameters:dic completionHandler:^(id responseObj, NSError *error) {
        completionHandle([GameListModel mj_objectWithKeyValues:responseObj], error);
    }];
}


@end
