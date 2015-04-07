//
//  DBcontroller.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/12.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBcontroller : NSObject
{
    sqlite3 *db;
}
-(void)execSql:(NSString *)sql;
-(void)closeDB;
-(int)initDB;
@end
