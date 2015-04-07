//
//  SingerListViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/14.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singer.h"
#import "SingerDBController.h"
#import "SongListViewController.h"
#import "JSONKit.h"
@interface SingerListViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray * singerList;
@property int isTI;
-(void)getSingerList;
-(void)getSingerListTI;
-(void)getSingerListByCountryNameTI:(NSString *)CountryName;
@end
