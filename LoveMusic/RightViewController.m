//
//  RightViewController.m
//  MusicPlayer
//
//  Created by 千里马LZZ on 13-10-20.
//  Copyright (c) 2013年 Lizizheng. All rights reserved.
//

#import "RightViewController.h"
#import "MusicViewController.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.semiTableView.alpha = 0.6f;
    self.semiTitleLabel.alpha = 0.6f;
        self.dateSourceArray = self.myMusic.musicArray;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
//    cell.backgroundColor = [UIColor blackColor];
    Song *music = (self.dateSourceArray)[indexPath.row];
    cell.textLabel.text = music.SongName;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;//该表格选中后没有颜色
    cell.textLabel.textColor = [UIColor blackColor];
//    cell.textLabel.backgroundColor = [UIColor blackColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.myMusic playTable:indexPath.row];
}
@end
