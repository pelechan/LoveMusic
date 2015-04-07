//
//  CountryDBController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/4/4.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Country.h"
@interface CountryDBController : NSObject
{
    sqlite3 *db;
}
-(NSMutableArray *)getAllCountry;
-(int)addCountryToLocal:(NSString *)CountryName;
-(int)initDB;
@end
