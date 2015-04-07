//
//  ShowListViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/14.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeList.h"
#import "SongListViewController.h"
#import "SingerListViewController.h"
#import "AlbumListViewController.h"
#import "StyleViewController.h"
@interface ShowListViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray * homeLists;
@end
