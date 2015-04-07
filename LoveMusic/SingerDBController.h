//
//  SingerDBController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/15.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Singer.h"
@interface SingerDBController : NSObject
{
    sqlite3 *db;
}
-(NSMutableArray *)getAllSinger;
-(int)addSingerToLocal:(Singer *)singer;
-(int)initDB;
@end
