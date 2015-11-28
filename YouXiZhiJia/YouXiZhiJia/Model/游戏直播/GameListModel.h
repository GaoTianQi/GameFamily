//
//  GameListModel.h
//  Day07_GameLive
//
//  Created by ios－54 on 15/10/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface GameListModel : BaseModel

@property (nonatomic, strong) NSArray *data;

@end

/*
 "cate_id": "1",
 "game_icon": "http://staticlive.douyutv.com/upload/game_cate/bf21a79139fc499aff52adecd702207b.jpg",
 "game_name": "英雄联盟",
 "game_src": "http://staticlive.douyutv.com/upload/game_cate/be8db394d66ec6f51c12d287141ff99e.jpg",
 "game_url": "/directory/game/LOL",
 "online_room": "390",
 "online_room_ios": "28",
 "short_name": "LOL" */
// 新建类的命名 上层类名＋对应Key＋Model
@interface GameListDataModel : BaseModel

@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, strong) NSString *game_icon;
@property (nonatomic, strong) NSString *game_name;
@property (nonatomic, strong) NSString *game_src;
@property (nonatomic, strong) NSString *game_url;
@property (nonatomic, strong) NSString *online_room;
@property (nonatomic, strong) NSString *online_room_ios;
@property (nonatomic, strong) NSString *short_name;

//+ (GameListDataModel *)parse:(NSDictionary *)responseObj;

@end
