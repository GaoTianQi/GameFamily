//
//  MyFootprintViewModel.m
//  资讯通·天下
//
//  Created by ios－54 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyFootprintViewModel.h"

@implementation MyFootprintViewModel

- (NSInteger)rowNumber
{
    return self.keyArr.count;
}

- (void)getDataArr
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kDataPath];
    NSMutableArray *kArr = [NSMutableArray array];
    NSMutableArray *vArr = [NSMutableArray array];
    
    for (NSString *key in dic.allKeys) {
        if (![key isEqualToString:@"names"]) {
            [kArr addObject:key];
            [vArr addObject:[dic valueForKey:key]];
        }
    }
    self.keyArr = kArr;
    self.dataArr = vArr;
}

- (NSString *)titleForRow:(NSInteger)row
{
    return self.keyArr[row];
}
- (NSURL *)urlForRow:(NSInteger)row
{
    return [NSURL URLWithString:self.dataArr[row]];
}

- (NSMutableArray *)keyArr {
    if(_keyArr == nil) {
        _keyArr = [[NSMutableArray alloc] init];
    }
    return _keyArr;
}

@end
