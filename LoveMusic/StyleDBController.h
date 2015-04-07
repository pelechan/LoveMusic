//
//  StyleDBController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "StyleC.h"
@interface StyleDBController : NSObject
{
    sqlite3 *db;
}
-(NSMutableArray *)getAllStyle;
-(int)addStyleToLocal:(NSString *)StyleName;
-(int)initDB;
@end
