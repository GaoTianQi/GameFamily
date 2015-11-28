//
//  MyFootprint2ViewModel.h
//  资讯通·天下
//
//  Created by ios－54 on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DataPersistence2.h"

@interface MyFootprint2ViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *keyArr;

@property (nonatomic, assign) NSInteger rowNumber;

- (NSString *)titleForRow:(NSInteger)row;

- (NSInteger)numberForRow:(NSInteger)row;

- (void)getDataArr;

@end
