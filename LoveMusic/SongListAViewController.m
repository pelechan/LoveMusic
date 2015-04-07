//
//  SongListAViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/4/5.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SongListAViewController.h"

@interface SongListAViewController ()

@end

@implementation SongListAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack.png"];
    background.alpha=0.4;
    [self.view addSubview:background];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    [self getSongListBySongListName:self.SongListName];
    [self.tableView reloadData];
}
-(void)getSongListBySongListName:(NSString *)SongListName{
    self.SongListName=SongListName;
    SongDBController *db = [[SongDBController alloc]init];
    self.songList=[db getSonglistbySongListName:SongListName];
}
- (IBAction)editingMode:(id)sender {
    //    [self.tableView setEditing:!self.tableView.editing];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddSongToSongListViewController * addSong =[story instantiateViewControllerWithIdentifier:@"addSong"];    //传递参数
    //跳转到appViewController
    addSong.SongListName=self.SongListName;
    [addSong getSongList];
    [self.navigationController pushViewController:addSong animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.songList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songcell"];
    Song * song = (self.songList)[indexPath.row];
    cell.textLabel.text=song.SongName;
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicViewController* musicView =[MusicViewController sharedInstance];    //传递参数
    [musicView getMusicArray:self.songList :[indexPath row]];
    [self.navigationController pushViewController:musicView animated:YES];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
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
        Song * song = self.songList[indexPath.row];
        [[[SongListDBController alloc]init]deleteSongList:self.SongListName :song.SongID];
        [self getSongListBySongListName:self.SongListName];
        [self.tableView reloadData];
    }
    else
        NSLog(@"haha");
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
