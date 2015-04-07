//
//  AlbumDBController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "AlbumDBController.h"

@implementation AlbumDBController
-(NSMutableArray *)getAllAlbum{
    NSMutableArray * AlbumList = [NSMutableArray arrayWithCapacity:20];
    Album * album;
    if(self.initDB){
        NSString *sql = @"select * from Album";
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                album=[[Album alloc]init];
                int albumid=sqlite3_column_int(statement, 0);
                char * albumName = (char  *)sqlite3_column_text(statement, 1);
                NSString *albumname = [[NSString alloc]initWithUTF8String:albumName];
                int singerid=sqlite3_column_int(statement, 2);
                album.AlbumID=albumid;
                album.AlbumName=albumname;
                album.SingerID=singerid;
                [AlbumList addObject:album];
            }
            return AlbumList;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(int)addAlbumToLocal:(Album *)album{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "INSERT INTO Album VALUES(?,?,?)";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to insert:channels");
            return 0;
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 1, album.AlbumID);
        sqlite3_bind_text(statement,2, [album.AlbumName UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 3, album.SingerID);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to insert into the database with message.");
            return 0;
        }
        NSLog(@"Insert One Channel#############:id = _");
        return 1;
    }
    else
        return 0;
}
-(int)addAlbum_SongToLocal:(int)AlbumID :(int)SongID{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "INSERT INTO Album_Song VALUES(?,?)";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to insert:channels");
            return 0;
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 1, AlbumID);
        sqlite3_bind_int(statement, 2, SongID);
        success =sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success ==SQLITE_ERROR) {
            NSLog(@"Error: failed to insert into the database with message.");
            return 0;
        }
        NSLog(@"Insert One Channel#############:id = _");
        return 1;
    }
    else
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
}
@end
