//
//  MyFootprintViewModel.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DataPersistence.h"

@interface MyFootprintViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *keyArr;

@property (nonatomic, assign) NSInteger rowNumber;

- (NSString *)titleForRow:(NSInteger)row;

- (NSURL *)urlForRow:(NSInteger)row;

@property (nonatomic, strong) DataPersistence *DP;

- (void)getDataArr;


@end
