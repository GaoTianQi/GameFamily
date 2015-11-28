//
//  TuWanNetManager.h
//  BaseProject
//
//  Created by jiyingxin on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "TuWanModel.h"
#import "TuWanPicModel.h"
//只要公用一个解析类的请求，就可以合起来写，只需要使用枚举变量，来决定不同的请求地址即可
//如果不会 可以参考汽车之家接口

typedef NS_ENUM(NSUInteger, InfoType) {
    InfoTypeTouTiao = 0,        //头条
    InfoTypeDuJia,          //独家
    InfoTypeTuPian,         //图片
    InfoTypeGongLue,        //攻略
    InfoTypeHuanHua,        //幻化
    InfoTypeQuWen,          //趣闻
    InfoTypeCos,            //COS
    InfoTypeMeiNv,          //美女
};

typedef NS_ENUM(NSUInteger, TuWanDataType) {
    TuWanDataTypeAnHei3 = 0, //暗黑3 dtid
    TuWanDataTypeMoShou, //魔兽
    TuWanDataTypeFengBao, //风暴
    TuWanDataTypeLuShi, //炉石
    TuWanDataTypeXingJi2, //星际2
    TuWanDataTypeShouWang, //守望者传说
};

@interface TuWanNetManager : BaseNetManager

//下方注释是 VVDocumenter 插件生成的。 安装此插件，在任何需要注释的位置 写///   三个/ 就可以自动弹出注释模板了

/**
 *  获取某种类型的资讯
 *
 *  @param type  资讯类型
 *  @param start 当前资讯起始索引值，最小为0。 eg 0,11,22,33,44...
 *
 *  @return 请求所在任务
 */
+ (id)getTuWanInfoWithType:(NSUInteger)type start:(NSInteger)start kCompletionHandle;

/**
 *  获取兔玩相关的信息
 *
 *  @param type             获取界面的类型，这是一个枚举值
 *  @param start            当前资讯起始索引值，最小为0。 eg 0,11,22,33,44...
 *  @param completionHandle 一个block，用于返回从服务器返回的数据
 *
 *  @return 返回当前请求的任务
 */
+ (id)getTuWanDataType:(TuWanDataType)type start:(NSInteger)start CompletionHandle:(void(^)(TuWanModel *model, NSError *error))completionHandle;

/**
 *  获取视频类资讯的详情页
 *
 *  @param aid 资讯aid
 *
 *  @return 任务
 */
//+ (id)getVideoDetailWithId:(NSString *)aid kCompletionHandle;

/**
 *  获取图片类资讯的详情页
 *
 *  @param aid 资讯aid
 *
 *  @return 任务
 */
+ (id)getPicDetailWithId:(NSString *)aid kCompletionHandle;

@end











