//
//  ShowSongListViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/4/4.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "ShowSongListViewController.h"

@interface ShowSongListViewController ()

@end

@implementation ShowSongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alert.delegate=self;
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack.png"];
    background.alpha=0.4;
    [self.view addSubview:background];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getSongLists{
    SongListDBController *db =[[SongListDBController alloc]init];
    self.songLists=[db getAllSingList];
}
- (IBAction)editingMode:(id)sender {
//    [self.tableView setEditing:!self.tableView.editing];
    self.alert = [[UIAlertView alloc] initWithTitle:@"新歌单" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [self.alert show];
}
-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框
    UITextField *tf=[alertView textFieldAtIndex:0];
    if(buttonIndex==1)
    {
        [[[SongListDBController alloc]init] addSongList:tf.text];
        [self getSongLists];
        [self.tableView reloadData];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.songLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songlistscell"];
    SongList* songList = (self.songLists)[indexPath.row];
    cell.textLabel.text=songList.SongListName;
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SongList * songlist = (self.songLists)[indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SongListAViewController * songlistView =[story instantiateViewControllerWithIdentifier:@"songlista"];
    [songlistView getSongListBySongListName:songlist.SongListName];
    [self.navigationController pushViewController:songlistView animated:YES];
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
        SongList * songList = self.songLists[indexPath.row];
        [[[SongListDBController alloc]init]deleteSongList:songList.SongListName];
        [self getSongLists];
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
