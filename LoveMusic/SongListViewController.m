//
//  SongListViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/14.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SongListViewController.h"

@interface SongListViewController ()

@end

@implementation SongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack3.png"];
    background.alpha=0.4;
    [self.view insertSubview:background belowSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    if(self.isF==1){
    [self getFavoriteSongList];
    [self.tableView reloadData];
    }
}
//获取音乐列表
-(void)getSongList{
    SongDBController *db = [[SongDBController alloc]init];
    self.songLists=[db getAllSong];
    getSongType =@"getSongList";
}
-(void)getSongListByAlbumID:(int)albumid{
    Album_ID=albumid;
    SongDBController *db = [[SongDBController alloc]init];
    self.songLists=[db getSongListByAlbumName:albumid];
    getSongType =@"getSongListByAlbumID";
}
-(void)getSongListByStyleName:(NSString *)StyleName{
    Style_Name=StyleName;
    SongDBController *db = [[SongDBController alloc]init];
    self.songLists=[db getSongListByStyle:StyleName];
    getSongType =@"getSongListByStyleName";
}
-(void)getSongListBySingerID:(int)SingerID{
    Singer_ID=SingerID;
    SongDBController *db = [[SongDBController alloc]init];
    self.songLists=[db getSongListBySingerID:SingerID];
    getSongType =@"getSongListBySingerID";
}
-(void)getFavoriteSongList{
    self.isF=1;
    SongDBController *db = [[SongDBController alloc]init];
    self.songLists=[db getFavoriteSongList];
    getSongType =@"getFavoriteSongList";
}
-(void)getSongListBySongListName:(NSString *)SongListName{
    SongList_Name=SongListName;
    SongDBController *db = [[SongDBController alloc]init];
    self.songLists=[db getSonglistbySongListName:SongListName];
    getSongType =@"getSongListBySongListName";
}

-(void)getSongListBySingerIDTI:(int)SingerID{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8888/getSongListBySingerID/%d",SingerID]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    self.songLists = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        Song * s = [[Song alloc]init];
        NSDictionary *singer = [arr objectAtIndex:i];
        s.SongID = [[singer objectForKey:@"SongID"] intValue];
        s.SingerID=[[singer objectForKey:@"SingerID"] intValue];
        s.SongName =[singer objectForKey:@"SongName"];
        s.StyleName =[singer objectForKey:@"StyleName"];
        s.SongAddress =[singer objectForKey:@"SongAddress"];
        s.SongLength = [[singer objectForKey:@"SongLength"] intValue];
        [self.songLists addObject:s];
    }
    self.isTI=1;
}
-(void)getSongListByStyleNameTI:(NSString *)StyleName{
    NSLog(@"getSongListByStyleNameTI");
    NSString *str =@"http://127.0.0.1:8888/getSongListByStyleName/";
    str = [str stringByAppendingString:StyleName];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    self.songLists = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        Song * s = [[Song alloc]init];
        NSDictionary *singer = [arr objectAtIndex:i];
        s.SongID = [[singer objectForKey:@"SongID"] intValue];
        s.SingerID=[[singer objectForKey:@"SingerID"] intValue];
        s.SongName =[singer objectForKey:@"SongName"];
        s.StyleName =[singer objectForKey:@"StyleName"];
        s.SongAddress =[singer objectForKey:@"SongAddress"];
        s.SongLength = [[singer objectForKey:@"SongLength"] intValue];
        [self.songLists addObject:s];
    }
    self.isTI=1;
}
-(void)getSongListBySeniorityNameTI:(NSString *)SeniorityName{
    NSString *str =@"http://127.0.0.1:8888/getSongListBySeniorityName/";
    str = [str stringByAppendingString:SeniorityName];
    NSLog(str);
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    self.songLists = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        Song * s = [[Song alloc]init];
        NSDictionary *singer = [arr objectAtIndex:i];
        s.SongID = [[singer objectForKey:@"SongID"] intValue];
        s.SingerID=[[singer objectForKey:@"SingerID"] intValue];
        s.SongName =[singer objectForKey:@"SongName"];
        s.StyleName =[singer objectForKey:@"StyleName"];
        s.SongAddress =[singer objectForKey:@"SongAddress"];
        s.SongLength = [[singer objectForKey:@"SongLength"] intValue];
        [self.songLists addObject:s];
    }
    self.isTI=1;
}
-(Singer *)getSingerBySingerID:(int)SingerID{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8888/getSingerBySingerID/%d",SingerID]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    Singer * s = [[Singer alloc]init];
    NSDictionary *singer = [arr objectAtIndex:0];
    s.SingerID = [[singer objectForKey:@"SingerID"] intValue];
    s.SingerName=[singer objectForKey:@"SingerName"];
    s.CountryName =[singer objectForKey:@"CountryName"];
    s.MorF =[[singer objectForKey:@"MorF"] intValue];
    return  s;
}

-(NSMutableArray *)getAlbumListBySongID:(int)SongID{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8888/getAlbumBySongID/%d",SongID]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    NSMutableArray * albumList = [NSMutableArray arrayWithCapacity:arr.count];
    NSLog(@"arrlength%d",arr.count);
    for(int i=0;i<arr.count;i++)
    {
        NSLog(@"in");
        Album * a = [[Album alloc]init];
        NSDictionary *album = [arr objectAtIndex:i];
        a.AlbumID = [[album objectForKey:@"AlbumID"] intValue];
        a.AlbumName=[album objectForKey:@"AlbumName"];
        a.SingerID =[[album objectForKey:@"SingerID"]intValue];
        [albumList addObject:a];
    }
    return albumList;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songcell"];
    Song* song = (self.songLists)[indexPath.row];
    cell.textLabel.text=song.SongName;
    if(self.isTI==1){
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn3 addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        btn3.frame = CGRectMake(200.0f, 0.0f, 150.0f, 44.0f);
//        [btn3 setTitle:@"+" forState:UIControlStateNormal];
        [btn3 setImage:[UIImage imageNamed:@"AddSong.png"] forState:UIControlStateNormal];
        [btn3 setTag:indexPath.row];
        [cell addSubview:btn3];
    }
    return cell;
}
-(void)Click:(id)sant
{   //获取Song
    int number=[sant tag];
    Song* song = (self.songLists)[number];
    //通过Song的StyleName添加Style
    [[[StyleDBController alloc]init] addStyleToLocal:song.StyleName];
    //通过Song的SingerID添加Singer
    Singer * singer = [self getSingerBySingerID:song.SingerID];
    //通过Singer的CountryName添加Country
    [[[CountryDBController alloc]init] addCountryToLocal:singer.CountryName];
    //添加Singer
    [[[SingerDBController alloc]init]addSingerToLocal:singer];
    //添加Song
    [[[SongDBController alloc]init] addSongToLocal:song];
    //通过Song的SongID添加专辑
    NSMutableArray * albumList = [self getAlbumListBySongID:song.SongID];
    AlbumDBController * albumDB = [[AlbumDBController alloc]init];
    for(int i=0;i<albumList.count;i++){
        Album * album = albumList[i];
        [albumDB addAlbumToLocal:album];
        [albumDB addAlbum_SongToLocal:album.AlbumID :song.SongID];
    }
    
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MusicViewController* musicView =[MusicViewController sharedInstance];    //传递参数
    [musicView getMusicArray:self.songLists :[indexPath row]];
    [self.navigationController pushViewController:musicView animated:YES];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if(self.isTI==0)
        return YES;
    else
        return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (editingStyle == UITableViewCellEditingStyleDelete) {
    //        // Delete the row from the data source
    //        [self.game removeObjectAtIndex:indexPath.row];
    //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //    }
    //    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    //        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //    }
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Song * song =self.songLists[indexPath.row];
        [[[SongDBController alloc]init]deleteSongFromLocal:song.SongID];
        if ([getSongType isEqualToString:@"getSongList"]) {
            [self getSongList];
        }
        else if([getSongType isEqualToString:@"getSongListByAlbumID"]){
            [self getSongListByAlbumID:Album_ID];
        }
        else if([getSongType isEqualToString:@"getSongListByStyleName"]){
            [self getSongListByStyleName:Style_Name];
        }
        else if([getSongType isEqualToString:@"getSongListBySingerID"]){
            [self getSongListBySingerID:Singer_ID];
        }
        else if([getSongType isEqualToString:@"getFavoriteSongList"]){
            [self getFavoriteSongList];
        }
        else if([getSongType isEqualToString:@"getSongListBySongListName"]){
            [self getSongListBySongListName:SongList_Name];
        }
        [self.tableView reloadData];
    }
    else
        NSLog(@"haha");
}
@end
