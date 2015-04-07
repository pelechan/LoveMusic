//
//  SongDBController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/13.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Song.h"
#import "StyleDBController.h"
#import "CountryDBController.h"
#import "SingerDBController.h"
#import "AlbumDBController.h"
#import "SongListDBController.h"
#import "JSONKit.h"
@interface SongDBController : NSObject
{
    sqlite3 *db;
}
-(NSMutableArray *)getSongListByListName:(NSString *)listName;
-(NSMutableArray *)getSongListByAlbumName:(int)albumID;
-(NSMutableArray *)getSongListByStyle:(NSString *)style;
-(NSMutableArray *)getSongListBySingerID:(int)SingerID;
-(NSMutableArray *)getSonglistbySongListName:(NSString *)SongListName;
-(NSMutableArray *)getFavoriteSongList;
-(NSMutableArray *)getAllSong;
-(int)addSongToLocal:(Song *)song;
-(int)deleteSongFromLocal:(int)SongID;
-(int)haveSongOrNot:(int)SongID;
-(void)setFavorite:(Song *)song;
-(void)setNFavorite:(int)SongID;
-(int)initDB;

@end
