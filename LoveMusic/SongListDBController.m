//
//  SongListDBController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SongListDBController.h"

@implementation SongListDBController

-(NSMutableArray *)getAllSingList{
    NSMutableArray * SongLists = [NSMutableArray arrayWithCapacity:20];
    SongList * songList;
    if(self.initDB){
        NSLog(@"11");
        NSString *sql = @"select * from SongList where SongListName != '我的最爱'";
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            NSLog(@"22");
            while(sqlite3_step(statement)==SQLITE_ROW){
                NSLog(@"33");
                songList=[[SongList alloc]init];
                char * songListName = (char  *)sqlite3_column_text(statement, 0);
                NSString *songlistname = [[NSString alloc]initWithUTF8String:songListName];
                songList.SongListName=songlistname;
                [SongLists addObject:songList];
            }
            return SongLists;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(void)addSongList:(NSString *)SongListName{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "INSERT INTO SongList VALUES(?)";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to insert:channels");
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,1, [SongListName UTF8String],-1,SQLITE_TRANSIENT);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to insert into the database with message.");
        }
        NSLog(@"Insert One Channel#############:id = _");
    }
}
-(void)deleteSongList:(NSString *)SongListName{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "DELETE FROM SongList where SongListName = ?";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to delte");
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,1, [SongListName UTF8String],-1,SQLITE_TRANSIENT);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to delete into the database with message.");
        }
        NSLog(@"delete One Channel#############:id = _");
    }
}
-(void)addSongList_Song:(NSString *)SongListName :(int)SongID{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "INSERT INTO SongList_Song VALUES(?,?)";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to delte");
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,1, [SongListName UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 2, SongID);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to delete into the database with message.");
        }
        NSLog(@"delete One Channel#############:id = _");
    }
}
-(void)deleteSongList:(NSString *)SongListName :(int)SongID{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "DELETE FROM SongList_Song where SongListName = ? and SongID = ?";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to delte");
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,1, [SongListName UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 2, SongID);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to delete into the database with message.");
        }
        NSLog(@"delete One Channel#############:id = _");
    }
}
-(void)setFavorite:(int)SongID{
    
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
        sqlite3_bind_int(statement,1, SongID);
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

-(int)initDB{
    NSString *database_path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.sqlite"];
    if(sqlite3_open([database_path UTF8String],&db)!=SQLITE_OK){
        sqlite3_close(db);
        NSLog(@"失败");
        return 0;
    }
    else
        return 1;
}
@end
