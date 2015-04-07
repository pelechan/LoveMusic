//
//  DBcontroller.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/12.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "DBcontroller.h"

@implementation DBcontroller
-(void)execSql:(NSString *)sql
{
    char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSLog(@"数据库操作数据失败!");
        }
        else{
            NSLog(@"1");
        }
    
}
-(void)closeDB{
    sqlite3_close(db);
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
