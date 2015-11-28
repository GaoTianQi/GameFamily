//
//  DataPersistence.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPersistence : NSObject

+ (DataPersistence *)defaultDataPersistence;

- (void)writeToLibraryOfName:(NSString *)name contents:(NSString *)arr;
-(void)createPlistByCode;
- (void)removeBookWithKey:(NSString *)key;
@property (nonatomic, strong) NSString *dataPath;

@end
