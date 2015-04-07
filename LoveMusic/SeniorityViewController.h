//
//  SeniorityViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seniority.h"
#import "SongListViewController.h"
@interface SeniorityViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray * seniorityList;
-(void)getALLSeniorityTI;
@end
