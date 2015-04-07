//
//  SeniorityDBController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SeniorityDBController.h"

@implementation SeniorityDBController
-(NSMutableArray *)getAllSeniority{
//    NSMutableArray * SingerList = [NSMutableArray arrayWithCapacity:20];
//    Seniority * seniority;
//    if(self.initDB){
//        NSString *sql = @"select  from Singer";
//        sqlite3_stmt * statement;
//        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
//            while(sqlite3_step(statement)==SQLITE_ROW){
//                singer=[[Singer alloc]init];
//                int singerid=sqlite3_column_int(statement, 0);
//                char * singerName = (char  *)sqlite3_column_text(statement, 1);
//                NSString *singername = [[NSString alloc]initWithUTF8String:singerName];
//                char * countryName = (char  *)sqlite3_column_text(statement, 2);
//                NSString *countryname = [[NSString alloc]initWithUTF8String:countryName];
//                singer.SingerID=singerid;
//                singer.SingerName=singername;
//                singer.CountryName=countryname;
//                [SingerList addObject:singer];
//            }
//            return SingerList;
//        }
//        else
//            return nil;
//    }
//    else
        return nil;
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
