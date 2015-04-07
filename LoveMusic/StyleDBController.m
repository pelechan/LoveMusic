//
//  StyleDBController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "StyleDBController.h"

@implementation StyleDBController
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
-(NSMutableArray *)getAllStyle{
    NSMutableArray * StyleList = [NSMutableArray arrayWithCapacity:20];
    StyleC * style;
    if(self.initDB){
        NSString *sql = @"select StyleName from Style";
        sqlite3_stmt * statement;
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                style=[[StyleC alloc]init];
                char * styleName = (char  *)sqlite3_column_text(statement, 0);
                NSString *styename = [[NSString alloc]initWithUTF8String:styleName];
                style.StyleName=styename;
                [StyleList addObject:style];
            }
            return StyleList;
        }
        else
            return nil;
    }
    else
        return nil;
}
-(int)addStyleToLocal:(NSString *)StyleName{
    if(self.initDB){
        sqlite3_stmt *statement;
        static char*sql = "INSERT INTO Style VALUES(?)";
        //问号的个数要和(cid,title,imageData,imageLen)里面字段的个数匹配，代表未知的值，将在下面将值和字段关 联。
        int success =sqlite3_prepare_v2(db, sql, -1, &statement,NULL);
        if (success !=SQLITE_OK) {
            NSLog(@"Error: failed to insert:channels");
            return 0;
        }
        //这里的数字1，2，3，4代表第几个问号
        //sqlite3_bind_text(statement, 1, stime, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,1, [StyleName UTF8String],-1,SQLITE_TRANSIENT);
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
