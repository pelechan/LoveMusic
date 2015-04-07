//
//  HomeViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/11.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack.png"];
    background.alpha=0.4;
    [self.view addSubview:background];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
        self.homeLists = [NSMutableArray arrayWithCapacity:20];
    HomeList * homeList = [[HomeList alloc]init];
    homeList.ListName=@"本地音乐";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"我喜欢";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"我的歌单";
    [[self homeLists] addObject:homeList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self homeLists].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localMusic"];
    HomeList * homelist = (self.homeLists)[indexPath.row];
    cell.textLabel.text=homelist.ListName;
    cell.detailTextLabel.text=homelist.ListDetail;
    if(indexPath.row==0)
        cell.image=[UIImage imageNamed:@"LocalMusic.png"];
    else if(indexPath.row==1)
        cell.image=[UIImage imageNamed:@"Favorite.png"];
    else if(indexPath.row==2)
        cell.image=[UIImage imageNamed:@"SongList.png"];
    return cell;
}
//实现didSelectRowAtIndexPath
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSString *imageName = [NSString stringWithFormat:@"%d",[indexPath row]+1];
    //    NSString *appName = [[self songs] objectAtIndex:[indexPath row]];
    //初始化appViewController
    
    //    NSString *imageName = [NSString stringWithFormat:@"%d",[indexPath row]+1];
    //    NSString *appName = [[self songs] objectAtIndex:[indexPath row]];
    //初始化appViewController
    if([indexPath row]+1==1){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ShowListViewController* showList =[story instantiateViewControllerWithIdentifier:@"showList"];    //传递参数
        //跳转到appViewController
        [self.navigationController pushViewController:showList animated:YES];
    }
    else if([indexPath row]+1==2){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SongListViewController* songList =[story instantiateViewControllerWithIdentifier:@"songList"];    //传递参数
        //跳转到appViewController
        [songList getFavoriteSongList];
        [self.navigationController pushViewController:songList animated:YES];

    }
    else if([indexPath row]+1==3){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ShowSongListViewController* songLists =[story instantiateViewControllerWithIdentifier:@"showsongList"];    //传递参数
        //跳转到appViewController
        [songLists getSongLists];
        [self.navigationController pushViewController:songLists animated:YES];
    }
    
}
@end
