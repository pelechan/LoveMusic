//
//  HomeLibraryViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/30.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeList.h"
#import "SongDBController.h"
#import "ShowListViewController.h"
#import "ShowSongListViewController.h"
#import "SingerListViewController.h"
#import "CountryViewController.h"
#import "StyleViewController.h"
#import "SeniorityViewController.h"
@interface HomeLibraryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * homeLists;

@end
