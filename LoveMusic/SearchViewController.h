//
//  SearchViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/4/1.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "Song.h"
#import "Singer.h"
#import "SingerDBController.h"
#import "SongDBController.h"
#import "SongListAViewController.h"
#import "SingerListViewController.h"
@interface SearchViewController : UIViewController
@property (nonatomic,strong)NSMutableArray * singerList;
@property (nonatomic,strong)NSMutableArray * songList;
@property (strong, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong,nonatomic)SongListAViewController *sdf;
@end
