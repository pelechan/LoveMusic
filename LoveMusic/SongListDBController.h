//
//  SongListDBController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SongList.h"
@interface SongListDBController : NSObject
{
    sqlite3 *db;
}
-(NSMutableArray *)getAllSingList;

-(void)addSongList:(NSString *)SongListName;
-(void)deleteSongList:(NSString *)SongListName;
-(void)addSongList_Song:(NSString *)SongListName:(int)SongID;
-(void)deleteSongList:(NSString *)SongListName:(int)SongID;
-(int)initDB;
@end
