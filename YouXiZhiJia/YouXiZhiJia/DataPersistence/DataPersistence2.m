//
//  DataPersistence2.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DataPersistence2.h"

@implementation DataPersistence2

+ (DataPersistence2 *)defaultDataPersistence
{
    static DataPersistence2 *DP = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DP = [DataPersistence2 new];
    });
    return DP;
}

- (void)writeToLibraryOfName:(NSString *)name contents:(NSNumber *)number
{

    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:kDataPath2]) {
        [self createPlistByCode];
    }
    
    NSMutableDictionary *userDic=[NSMutableDictionary dictionaryWithContentsOfFile:kDataPath2];
    [userDic setValue:number forKey:name];
    [userDic writeToFile:kDataPath2 atomically:YES];
}

//用代码创建plist文件
-(void)createPlistByCode{
    //准备要写入到plist中的数据
    NSDictionary *userDic=@{@"names":@"我的浏览记录"};
    //写入
    [userDic writeToFile:kDataPath2 atomically:YES];
}


//判断key的书是否存在
-(BOOL)isBookExistsForKey:(NSString*)key{
    NSMutableDictionary *DataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:kDataPath2];
    
    //根目录下存在名为bookname的字典
    if ([DataDic objectForKey:key]) {
        return YES;
    }else{
        return NO;
    }
}


//根据key值删除对应书籍
- (void)removeBookWithKey:(NSString *)key{
    NSMutableDictionary *DataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:kDataPath2];
    
    [DataDic removeObjectForKey:key];
    [DataDic writeToFile:kDataPath2 atomically:YES]; //删除后重新写入
    
}

@end