//
//  AddSongToSongListViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/4/4.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
#import "SongDBController.h"
#import "MusicViewController.h"
#import "SongListDBController.h"
#import "SongListAViewController.h"
@interface AddSongToSongListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * songLists;
@property (nonatomic,strong)NSString * SongListName;
@property (nonatomic,strong)NSMutableArray * selectList;
-(void)getSongList;
@end
