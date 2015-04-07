//
//  SongListAViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/4/5.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
#import "MusicViewController.h"
#import "SongDBController.h"
#import "SongListDBController.h"
#import "AddSongToSongListViewController.h"
@interface SongListAViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * songList;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSString * SongListName;
-(void)getSongListBySongListName:(NSString *)SongListName;
@end
