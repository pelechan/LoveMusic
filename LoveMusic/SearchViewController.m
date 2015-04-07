//
//  SearchViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/4/1.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack3.png"];
    background.alpha=0.5;
    [self.view addSubview:background];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    NSString * str =@"http://127.0.0.1:8888/getSongListBySearch/";
    str=[str stringByAppendingString:[searchBar text]];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    self.songList = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        Song * s = [[Song alloc]init];
        NSDictionary *singer = [arr objectAtIndex:i];
        s.SongID = [[singer objectForKey:@"SongID"] intValue];
        s.SingerID=[[singer objectForKey:@"SingerID"] intValue];
        s.SongName =[singer objectForKey:@"SongName"];
        s.StyleName =[singer objectForKey:@"StyleName"];
        s.SongAddress =[singer objectForKey:@"SongAddress"];
        s.SongLength=[[singer objectForKey:@"SongLength"]intValue];
        [self.songList addObject:s];
    }
    str =@"http://127.0.0.1:8888/getSingerListBySearch/";
    str=[str stringByAppendingString:[searchBar text]];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:str];
    request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    arr = (NSArray *)[received  mutableObjectFromJSONData];
    self.singerList = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        Singer * s = [[Singer alloc]init];
        NSDictionary *singer = [arr objectAtIndex:i];
        s.SingerID = [[singer objectForKey:@"SingerID"] intValue];
        s.SingerName=[singer objectForKey:@"SingerName"];
        s.CountryName=[singer objectForKey:@"CountryName"];
        [self.singerList addObject:s];
    }
    [self.searchTableView reloadData];
    
    [searchBar resignFirstResponder];
}
//cancel button clicked...
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar                    // called when cancel button pressed
{
    NSLog( @"%s,%d" , __FUNCTION__ , __LINE__ );
    
    [searchBar resignFirstResponder];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section==0)
        return self.songList.count;
    else
        return self.singerList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchcell"];
    //    HomeList * homelist = (self.homeLists)[indexPath.row];
    //    cell.textLabel.text=homelist.ListName;
    //    cell.detailTextLabel.text=homelist.ListDetail;
    //    return cell;
    if(indexPath.section==0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchcell"];
        Song * song = (self.songList)[indexPath.row];
        cell.textLabel.text=song.SongName;
        cell.image=[UIImage imageNamed:@"Song.png"];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchcell"];
        Singer * singer = (self.singerList)[indexPath.row];
        cell.textLabel.text=singer.SingerName;
        cell.image=[UIImage imageNamed:@"Singer.png"];
        return cell;
    }
}
//实现didSelectRowAtIndexPath
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        Singer  * singer = self.singerList[indexPath.row];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SongListViewController * s =[story instantiateViewControllerWithIdentifier:@"songList"];    //传递参数
        //跳转到appViewController
        [s getSongListBySingerIDTI:singer.SingerID];
        [self.navigationController pushViewController:s animated:YES];    }
    else{
        MusicViewController* musicView =[MusicViewController sharedInstance];    //传递参数
        [musicView getMusicArray:self.songList :[indexPath row]];
        [self.navigationController pushViewController:musicView animated:YES];
//        NSLog(@"%d",[indexPath row]);

    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        if(self.songList.count!=0){
            
            UIView *headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            
            label.backgroundColor = [UIColor colorWithRed:137/255.0 green:154/255.0 blue:168/255.0 alpha:0.8];
            
            label.font = [UIFont boldSystemFontOfSize:14];
            
            //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.8];
            
            label.textAlignment = UITextAlignmentLeft;
            
            label.textColor = [UIColor whiteColor];
            
            label.text = [NSString stringWithFormat:@"歌曲"];
            
            [headerView addSubview:label];
            return headerView;
        }
        else
            return nil;
    }
    else{
        if(self.singerList.count!=0){
            UIView *headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            
            label.backgroundColor = [UIColor colorWithRed:137/255.0 green:154/255.0 blue:168/255.0 alpha:0.8];
            
            label.font = [UIFont boldSystemFontOfSize:14];
            
            //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.8];
            
            label.textAlignment = UITextAlignmentLeft;
            
            label.textColor = [UIColor whiteColor];
            
            label.text = [NSString stringWithFormat:@"歌手"];
            
            [headerView addSubview:label];
            return headerView;
        }
        else
            return nil;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
