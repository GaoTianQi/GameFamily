//
//  CategoryViewController.h
//  史蒂夫
//
//  Created by ios－54 on 15/11/17.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UITableViewController
/** 接收外部传参，决定当前控制器显示哪种类型的信息 */
@property(nonatomic,strong) NSNumber *TuWanType;
@end
