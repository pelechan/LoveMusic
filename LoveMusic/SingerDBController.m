//
//  SingerDBController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/15.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SingerDBController.h"

@implementation SingerDBController
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
-(NSMutableArray *)getAllSinger{
    NSMutableArray * SingerList = [NSMutableArray arrayWithCapacity:20];
    Singer * singer;
    NSLog(@"b");

    if(self.initDB){
        NSLog(@"u");

        NSString *sql = @"select * from Singer";
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                NSLog(@"H");
                singer=[[Singer alloc]init];
                int singerid=sqlite3_column_int(statement, 0);
                char * singerName = (char  *)sqlite3_column_text(statement, 1);
                NSString *singername = [[NSString alloc]initWithUTF8String:singerName];
                char * countryName = (char  *)sqlite3_column_text(statement, 2);
                NSString *countryname = [[NSString alloc]initWithUTF8String:countryName];
                singer.SingerID=singerid;
                singer.SingerName=singername;
                singer.CountryName=countryname;
                [SingerList addObject:singer];
            }
            return SingerList;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(int)addSingerToLocal:(Singer *)singer{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "INSERT INTO Singer VALUES(?,?,?,?)";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to insert:channels");
            return 0;
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 1, singer.SingerID);
        sqlite3_bind_text(statement,2, [singer.SingerName UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,3, [singer.CountryName UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 4, singer.MorF);
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
@end
