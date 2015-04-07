//
//  AlbumListViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/14.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDBController.h"
#import "SongListViewController.h"
#import "Album.h"
@interface AlbumListViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray * albumList;
-(void)getAlbumList;
@end
