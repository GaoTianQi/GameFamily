//
//  DataPersistence.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DataPersistence.h"

@implementation DataPersistence

+ (DataPersistence *)defaultDataPersistence
{
    static DataPersistence *DP = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DP = [DataPersistence new];
    });
    return DP;
}

- (void)writeToLibraryOfName:(NSString *)name contents:(NSString *)arr
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:kDataPath]) {
        [self createPlistByCode];
    }
    
    NSMutableDictionary *userDic=[NSMutableDictionary dictionaryWithContentsOfFile:kDataPath];
    [userDic setValue:arr forKey:name];
    [userDic writeToFile:kDataPath atomically:YES];
}

//用代码创建plist文件
-(void)createPlistByCode{
    //准备要写入到plist中的数据
    NSDictionary *userDic=@{@"names":@"我的浏览记录"};
    //写入
    [userDic writeToFile:kDataPath atomically:YES];
}


//判断key的书是否存在
-(BOOL)isBookExistsForKey:(NSString*)key{
    NSMutableDictionary *DataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:kDataPath];
    
    //根目录下存在名为bookname的字典
    if ([DataDic objectForKey:key]) {
        return YES;
    }else{
        return NO;
    }
}


//根据key值删除对应书籍
- (void)removeBookWithKey:(NSString *)key{
    NSMutableDictionary *DataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:kDataPath];
    
    [DataDic removeObjectForKey:key];
    [DataDic writeToFile:kDataPath atomically:YES]; //删除后重新写入
    
}


@end
