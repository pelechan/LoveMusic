//
//  CountryViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/31.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "Country.h"
#import "SingerListViewController.h"

@interface CountryViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray * countryList;

-(void)getCountryListTI;
@end
