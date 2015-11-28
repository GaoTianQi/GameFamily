//
//  DataPersistence2.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPersistence2 : NSObject

+ (DataPersistence2 *)defaultDataPersistence;

- (void)writeToLibraryOfName:(NSString *)name contents:(NSNumber *)number;
-(void)createPlistByCode;
- (void)removeBookWithKey:(NSString *)key;
@property (nonatomic, strong) NSString *dataPath;

@end
