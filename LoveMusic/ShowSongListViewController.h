//
//  ShowSongListViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/4/4.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongList.h"
#import "SongListDBController.h"
#import "AddSongToSongListViewController.h"
#import "SongListAViewController.h"
@interface ShowSongListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong)NSMutableArray * songLists;
-(void)getSongLists;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIAlertView * alert;
@end
