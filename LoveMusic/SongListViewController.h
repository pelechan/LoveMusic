//
//  SongListViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/14.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongDBController.h"
#import "StyleDBController.h"
#import "CountryDBController.h"
#import "MusicViewController.h"
#import "SingerDBController.h"
#import "AlbumDBController.h"
#import "Song.h"
#import "Singer.h"
#import "Album.h"
#import "JSONKit.h"
@interface SongListViewController : UITableViewController{
    NSString * getSongType;
    int Album_ID;
    NSString *Style_Name;
    int Singer_ID;
    NSString * SongList_Name;
    
}
@property (nonatomic,strong)NSMutableArray * songLists;
@property(nonatomic,strong)NSString * listName;
@property int isTI;
@property int isF;
-(void)getSongList;
-(void)getSongListByAlbumID:(int)albumid;
-(void)getSongListByStyleName:(NSString *)StyleName;
-(void)getSongListBySingerID:(int)SingerID;
-(void)getSongListBySongListName:(NSString *)SongListName;
-(void)getFavoriteSongList;

-(void)getSongListBySingerIDTI:(int)SingerID;
-(void)getSongListByStyleNameTI:(NSString *)StyleName;
-(void)getSongListBySeniorityNameTI:(NSString *)SeniorityName;
@end
