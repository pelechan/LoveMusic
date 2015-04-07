//
//  AddSongToSongListViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/4/4.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "AddSongToSongListViewController.h"

@interface AddSongToSongListViewController ()

@end

@implementation AddSongToSongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
-(void)getSongList{
    SongDBController *db = [[SongDBController alloc]init];
    self.songLists=[db getAllSong];
    self.selectList=[[NSMutableArray alloc]initWithCapacity:self.songLists.count];
    for(int i=0;i<self.songLists.count;i++)
    {
        [self.selectList addObject:@"Y"];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (IBAction)finishedAddingSong:(id)sender {
    SongListDBController * songlistDB = [[SongListDBController alloc]init];
    for(int i=0;i<self.selectList.count;i++){
        NSString * YorN = self.selectList[i];
        if([YorN isEqualToString:@"Y"]){
            Song * s = self.songLists[i];
            [songlistDB addSongList_Song:self.SongListName :s.SongID];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addsongcell"];
    Song* song = (self.songLists)[indexPath.row];
    cell.textLabel.text=song.SongName;
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
    if (oneCell.accessoryType == UITableViewCellAccessoryNone) {
        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectList replaceObjectAtIndex:indexPath.row withObject:@"Y"];
    }
    else{
        oneCell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectList replaceObjectAtIndex:indexPath.row withObject:@"N"];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
