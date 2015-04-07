//
//  AlbumDBController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Album.h"
@interface AlbumDBController : NSObject
{
    sqlite3 *db;
}
-(NSMutableArray *)getAllAlbum;
-(int)addAlbumToLocal:(Album *)album;
-(int)addAlbum_SongToLocal:(int)AlbumID:(int)SongID;
-(int)initDB;
@end
