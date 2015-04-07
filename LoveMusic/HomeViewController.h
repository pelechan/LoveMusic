//
//  HomeViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/11.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeList.h"
#import "SongDBController.h"
#import "ShowListViewController.h"
#import "ShowSongListViewController.h"
@interface HomeViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray * homeLists;

@end
