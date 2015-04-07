//
//  ShowListViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/14.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "ShowListViewController.h"

@interface ShowListViewController ()

@end

@implementation ShowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack2.png"];
    background.alpha=0.4;
    [self.view addSubview:background];
    self.homeLists = [NSMutableArray arrayWithCapacity:20];
    HomeList * homeList = [[HomeList alloc]init];
    homeList.ListName=@"歌曲";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"歌手";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"专辑";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"类别";
    [[self homeLists] addObject:homeList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self homeLists].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lists"];
    HomeList * homelist = (self.homeLists)[indexPath.row];
    cell.textLabel.text=homelist.ListName;
    cell.detailTextLabel.text=homelist.ListDetail;
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSString *imageName = [NSString stringWithFormat:@"%d",[indexPath row]+1];
    //    NSString *appName = [[self songs] objectAtIndex:[indexPath row]];
    //初始化appViewController
    if([indexPath row]+1==1){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SongListViewController* songListView =[story instantiateViewControllerWithIdentifier:@"songList"];
        //传递参数
        [songListView getSongList];
        //跳转到appViewController
        [self.navigationController pushViewController:songListView animated:YES];
    }
    else if([indexPath row]+1==2){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SingerListViewController* singerListView =[story instantiateViewControllerWithIdentifier:@"singerList"];
        //传递参数
        [singerListView getSingerList];
        //跳转到appViewController
        [self.navigationController pushViewController:singerListView animated:YES];
    }
    else if([indexPath row]+1==3){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        AlbumListViewController* albumListView =[story instantiateViewControllerWithIdentifier:@"albumList"];
        //传递参数
        [albumListView getAlbumList];
        //跳转到appViewController
        [self.navigationController pushViewController:albumListView animated:YES];
    }
    else if([indexPath row]+1==4){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        StyleViewController * styleListView =[story instantiateViewControllerWithIdentifier:@"styleList"];
        //传递参数
        [styleListView getAllStyle];
        //跳转到appViewController
        [self.navigationController pushViewController:styleListView animated:YES];
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
