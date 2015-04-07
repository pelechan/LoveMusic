//
//  SeniorityDBController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Seniority.h"
#import <sqlite3.h>
@interface SeniorityDBController : NSObject{
    sqlite3 *db;
}
-(NSMutableArray *)getAllSeniority;
-(int)initDB;
@end
