//
//  SongDBController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/13.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SongDBController.h"

@implementation SongDBController
-(Singer *)getSingerBySingerID:(int)SingerID{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8888/getSingerBySingerID/%d",SingerID]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    Singer * s = [[Singer alloc]init];
    NSDictionary *singer = [arr objectAtIndex:0];
    s.SingerID = [[singer objectForKey:@"SingerID"] intValue];
    s.SingerName=[singer objectForKey:@"SingerName"];
    s.CountryName =[singer objectForKey:@"CountryName"];
    s.MorF =[[singer objectForKey:@"MorF"] intValue];
    return  s;
}

-(NSMutableArray *)getAlbumListBySongID:(int)SongID{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8888/getAlbumBySongID/%d",SongID]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    NSMutableArray * albumList = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        NSLog(@"in");
        Album * a = [[Album alloc]init];
        NSDictionary *album = [arr objectAtIndex:i];
        a.AlbumID = [[album objectForKey:@"AlbumID"] intValue];
        a.AlbumName=[album objectForKey:@"AlbumName"];
        a.SingerID =[[album objectForKey:@"SingerID"]intValue];
        [albumList addObject:a];
    }
    return albumList;
}

-(void)setFavorite:(Song *)song{
    if ([self haveSongOrNot:song.SongID]!=1) {
        //通过Song的StyleName添加Style
        [[[StyleDBController alloc]init] addStyleToLocal:song.StyleName];
        //通过Song的SingerID添加Singer
        Singer * singer = [self getSingerBySingerID:song.SingerID];
        //通过Singer的CountryName添加Country
        [[[CountryDBController alloc]init] addCountryToLocal:singer.CountryName];
        //添加Singer
        [[[SingerDBController alloc]init]addSingerToLocal:singer];
        //添加Song
        [[[SongDBController alloc]init] addSongToLocal:song];
        //通过Song的SongID添加专辑
        NSMutableArray * albumList = [self getAlbumListBySongID:song.SongID];
        AlbumDBController * albumDB = [[AlbumDBController alloc]init];
        for(int i=0;i<albumList.count;i++){
            Album * album = albumList[i];
            [albumDB addAlbumToLocal:album];
            [albumDB addAlbum_SongToLocal:album.AlbumID :song.SongID];
        }
    }
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "UPDATE Song SET IsFavorite = 1 where SongID = ?";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to UPDATE");
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement,1, song.SongID);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to UPDATE into the database with message.");
        }
        NSLog(@"UPDATE One Channel#############:id = _");
    }
}
-(void)setNFavorite:(int)SongID{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "UPDATE Song SET IsFavorite = 0 where SongID = ?";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to UPDATE");
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement,1, SongID);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to UPDATE into the database with message.");
        }
        NSLog(@"UPDATE One Channel#############:id = _");
    }
}
-(int)haveSongOrNot:(int)SongID{
    if(self.initDB){
        NSString *sql = [NSString stringWithFormat:@"select * from Song where SongID=%d",SongID];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            return 1;
        }
        else
            return 0;
    }
    else
        return 0;
}


-(NSMutableArray *)getAllSong{
    NSMutableArray * SongList = [NSMutableArray arrayWithCapacity:200];
    Song * song;
    if(self.initDB){
        NSString *sql = [NSString stringWithFormat:@"select * from Song "];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                song=[[Song alloc]init];
                int songid=sqlite3_column_int(statement, 0);
                int singerid=sqlite3_column_int(statement, 1);
                char * songName = (char  *)sqlite3_column_text(statement, 2);
                NSString *songname = [[NSString alloc]initWithUTF8String:songName];
                char * songStyle = (char  *)sqlite3_column_text(statement, 3);
                NSString *style = [[NSString alloc]initWithUTF8String:songStyle];
                char * songAddress = (char  *)sqlite3_column_text(statement, 4);
                NSString *songaddress = [[NSString alloc]initWithUTF8String:songAddress];
                int songlength=sqlite3_column_int(statement, 5);
                int isfavorite =sqlite3_column_int(statement, 6);
                song.SongID=songid;
                song.SingerID=singerid;
                song.SongName=songname;
                song.StyleName=style;
                song.SongAddress=songaddress;
                song.SongLength=songlength;
                song.IsFavorite=isfavorite;
                [SongList addObject:song];
            }
            return SongList;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(NSMutableArray *)getSongListByListName:(NSString *)listName{
    NSMutableArray * SongList = [NSMutableArray arrayWithCapacity:20];
    Song * song;
    if(self.initDB){
        NSString *sql = [NSString stringWithFormat:@"select SongID from SongList_Song where SongListName='%@'",listName];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                int songID=sqlite3_column_int(statement, 0);
                NSString *sql1 =[NSString stringWithFormat:@"select * from Song where SongID=%d",songID];
                sqlite3_stmt * statement1;
                if(sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement1, nil)==SQLITE_OK){
                    while(sqlite3_step(statement1)==SQLITE_ROW){
                        song=[[Song alloc]init];
                        int songid=sqlite3_column_int(statement1, 0);
                        int singerid=sqlite3_column_int(statement1, 1);
                        char * songName = (char  *)sqlite3_column_text(statement1, 2);
                        NSString *songname = [[NSString alloc]initWithUTF8String:songName];
                        char * songStyle = (char  *)sqlite3_column_text(statement1, 3);
                        NSString *style = [[NSString alloc]initWithUTF8String:songStyle];
                        char * songAddress = (char  *)sqlite3_column_text(statement1, 4);
                        NSString *songaddress = [[NSString alloc]initWithUTF8String:songAddress];
                        int songlength=sqlite3_column_int(statement1, 5);
                        int isfavorite =sqlite3_column_int(statement, 6);
                        song.SongID=songid;
                        song.SingerID=singerid;
                        song.SongName=songname;
                        song.StyleName=style;
                        song.SongAddress=songaddress;
                        song.SongLength=songlength;
                        song.IsFavorite=isfavorite;
                        [SongList addObject:song];
                    }
                }
            }
            return SongList;
        }
        else{
            return nil;
        }
    }
    else
        return nil;
}
-(NSMutableArray *)getSongListByAlbumName:(int)albumID{
    NSMutableArray * SongList = [NSMutableArray arrayWithCapacity:20];
    Song * song;
    if(self.initDB){
        NSString *sql = [NSString stringWithFormat:@"select SongID from Album_Song where AlbumID=%d",albumID];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                int songID=sqlite3_column_int(statement, 0);
                NSLog(@"%d",songID);
                NSString *sql1 =[NSString stringWithFormat:@"select * from Song where SongID=%d",songID];
                sqlite3_stmt * statement1;
                if(sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement1, nil)==SQLITE_OK){
                    while(sqlite3_step(statement1)==SQLITE_ROW){
                        NSLog(@"albumSong");
                        song=[[Song alloc]init];
                        int songid=sqlite3_column_int(statement1, 0);
                        int singerid=sqlite3_column_int(statement1, 1);
                        char * songName = (char  *)sqlite3_column_text(statement1, 2);
                        NSString *songname = [[NSString alloc]initWithUTF8String:songName];
                        char * songStyle = (char  *)sqlite3_column_text(statement1, 3);
                        NSString *style = [[NSString alloc]initWithUTF8String:songStyle];
                        char * songAddress = (char  *)sqlite3_column_text(statement1, 4);
                        NSString *songaddress = [[NSString alloc]initWithUTF8String:songAddress];
                        int songlength=sqlite3_column_int(statement1, 5);
                        int isfavorite =sqlite3_column_int(statement, 6);
                        song.SongID=songid;
                        song.SingerID=singerid;
                        song.SongName=songname;
                        song.StyleName=style;
                        song.SongAddress=songaddress;
                        song.SongLength=songlength;
                        song.IsFavorite=isfavorite;
                        [SongList addObject:song];
                    }
                }
            }
            return SongList;
        }
        else{
            return nil;
        }
    }
    else
        return nil;
}
-(NSMutableArray *)getSongListByStyle:(NSString *)style{
    NSMutableArray * SongList = [NSMutableArray arrayWithCapacity:20];
    Song * song;
    if(self.initDB){
        NSLog(@"1");
        NSString *sql = [NSString stringWithFormat:@"select * from Song where StyleName='%@'",style];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            NSLog(@"2");
            while(sqlite3_step(statement)==SQLITE_ROW){
                song=[[Song alloc]init];
                int songid=sqlite3_column_int(statement, 0);
                int singerid=sqlite3_column_int(statement, 1);
                char * songName = (char  *)sqlite3_column_text(statement, 2);
                NSString *songname = [[NSString alloc]initWithUTF8String:songName];
                char * songStyle = (char  *)sqlite3_column_text(statement, 3);
                NSString *style = [[NSString alloc]initWithUTF8String:songStyle];
                char * songAddress = (char  *)sqlite3_column_text(statement, 4);
                NSString *songaddress = [[NSString alloc]initWithUTF8String:songAddress];
                int songlength=sqlite3_column_int(statement, 5);
                int isfavorite =sqlite3_column_int(statement, 6);
                song.SongID=songid;
                song.SingerID=singerid;
                song.SongName=songname;
                song.StyleName=style;
                song.SongAddress=songaddress;
                song.SongLength=songlength;
                song.IsFavorite=isfavorite;
                [SongList addObject:song];
            }
            return SongList;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(NSMutableArray *)getSongListBySingerID:(int)SingerID{
    NSMutableArray * SongList = [NSMutableArray arrayWithCapacity:20];
    Song * song;
    if(self.initDB){
        NSLog(@"1111");
        NSString *sql = [NSString stringWithFormat:@"select * from Song where SingerID = %d ",SingerID];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            NSLog(@"2");
            while(sqlite3_step(statement)==SQLITE_ROW){
                song=[[Song alloc]init];
                int songid=sqlite3_column_int(statement, 0);
                int singerid=sqlite3_column_int(statement, 1);
                char * songName = (char  *)sqlite3_column_text(statement, 2);
                NSString *songname = [[NSString alloc]initWithUTF8String:songName];
                char * songStyle = (char  *)sqlite3_column_text(statement, 3);
                NSString *style = [[NSString alloc]initWithUTF8String:songStyle];
                char * songAddress = (char  *)sqlite3_column_text(statement, 4);
                NSString *songaddress = [[NSString alloc]initWithUTF8String:songAddress];
                int songlength=sqlite3_column_int(statement, 5);
                int isfavorite =sqlite3_column_int(statement, 6);
                song.SongID=songid;
                song.SingerID=singerid;
                song.SongName=songname;
                song.StyleName=style;
                song.SongAddress=songaddress;
                song.SongLength=songlength;
                song.IsFavorite=isfavorite;
                [SongList addObject:song];
            }
            return SongList;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(NSMutableArray *)getSonglistbySongListName:(NSString *)SongListName{
    NSMutableArray * SongList = [NSMutableArray arrayWithCapacity:20];
    Song * song;
    if(self.initDB){
        NSString *sql = [NSString stringWithFormat:@"select SongID from SongList_Song where SongListName='%@'",SongListName];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                int songID=sqlite3_column_int(statement, 0);
                NSString *sql1 =[NSString stringWithFormat:@"select * from Song where SongID=%d",songID];
                sqlite3_stmt * statement1;
                if(sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement1, nil)==SQLITE_OK){
                    while(sqlite3_step(statement1)==SQLITE_ROW){
                        song=[[Song alloc]init];
                        int songid=sqlite3_column_int(statement1, 0);
                        int singerid=sqlite3_column_int(statement1, 1);
                        char * songName = (char  *)sqlite3_column_text(statement1, 2);
                        NSString *songname = [[NSString alloc]initWithUTF8String:songName];
                        char * songStyle = (char  *)sqlite3_column_text(statement1, 3);
                        NSString *style = [[NSString alloc]initWithUTF8String:songStyle];
                        char * songAddress = (char  *)sqlite3_column_text(statement1, 4);
                        NSString *songaddress = [[NSString alloc]initWithUTF8String:songAddress];
                        int songlength=sqlite3_column_int(statement1, 5);
                        int isfavorite =sqlite3_column_int(statement, 6);
                        song.SongID=songid;
                        song.SingerID=singerid;
                        song.SongName=songname;
                        song.StyleName=style;
                        song.SongAddress=songaddress;
                        song.SongLength=songlength;
                        song.IsFavorite=isfavorite;
                        [SongList addObject:song];
                    }
                }
            }
            return SongList;
        }
        else{
            return nil;
        }
    }
    else
        return nil;
}
-(NSMutableArray *)getFavoriteSongList{
    NSMutableArray * SongList = [NSMutableArray arrayWithCapacity:20];
    Song * song;
    if(self.initDB){
        NSLog(@"1111");
        NSString *sql = [NSString stringWithFormat:@"select * from Song where IsFavorite = %d ",1];
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            NSLog(@"2");
            while(sqlite3_step(statement)==SQLITE_ROW){
                song=[[Song alloc]init];
                int songid=sqlite3_column_int(statement, 0);
                int singerid=sqlite3_column_int(statement, 1);
                char * songName = (char  *)sqlite3_column_text(statement, 2);
                NSString *songname = [[NSString alloc]initWithUTF8String:songName];
                char * songStyle = (char  *)sqlite3_column_text(statement, 3);
                NSString *style = [[NSString alloc]initWithUTF8String:songStyle];
                char * songAddress = (char  *)sqlite3_column_text(statement, 4);
                NSString *songaddress = [[NSString alloc]initWithUTF8String:songAddress];
                int songlength=sqlite3_column_int(statement, 5);
                int isfavorite =sqlite3_column_int(statement, 6);
                song.SongID=songid;
                song.SingerID=singerid;
                song.SongName=songname;
                song.StyleName=style;
                song.SongAddress=songaddress;
                song.SongLength=songlength;
                song.IsFavorite=isfavorite;
                [SongList addObject:song];
            }
            return SongList;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(int)addSongToLocal:(Song *)song{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char *sql = "INSERT INTO Song VALUES(?,?,?,?,?,?,?)";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to insert:channels");
            return 0;
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 1, song.SongID);
        sqlite3_bind_int(statement, 2, song.SingerID);
        sqlite3_bind_text(statement,3, [song.SongName UTF8String], -1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,4, [song.StyleName UTF8String], -1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,5, [song.SongAddress UTF8String], -1,SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 6, song.SongLength);
        sqlite3_bind_int(statement, 7, 0);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to insert into the database with message.");
            return 1;
        }
        NSLog(@"Insert One Channel#############:id = _");
    }
    return 0;
}
-(int)deleteSongFromLocal:(int)SongID{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char *sql = "Delete From Song where SongID = ?";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to insert:channels");
            return 0;
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 1, SongID);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to deleteSongFromLocal");
            return 1;
        }
        NSLog(@"Insert One Channel#############:id = _");
    }
    return 0;
}
-(int)initDB{
    NSString *database_path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.sqlite"];
    if(sqlite3_open([database_path UTF8String],&db)!=SQLITE_OK){
        sqlite3_close(db);
        NSLog(@"失败");
        return 0;
    }
    else
        return 1;
}@end
