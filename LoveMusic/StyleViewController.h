//
//  StyleViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyleDBController.h"
#import "SongListViewController.h"
#import "StyleC.h"
@interface StyleViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray * stylefList;
@property int isTI;
-(void)getAllStyle;
-(void)getAllStyleTI;

@end
