//
//  SeniorityViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/16.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "SeniorityViewController.h"

@interface SeniorityViewController ()

@end

@implementation SeniorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack.png"];
    background.alpha=0.4;
    [self.view addSubview:background];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getALLSeniorityTI{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/getSeniorityList"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    self.seniorityList = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        Seniority * s = [[Seniority alloc]init];
        NSDictionary *seniority = [arr objectAtIndex:i];
        s.SeniorityName = [seniority objectForKey:@"SeniorityName"];
        [self.seniorityList addObject:s];
        NSLog(s.SeniorityName);
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.seniorityList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"senioritycell"];
    Seniority * seniority = (self.seniorityList)[indexPath.row];
    cell.textLabel.text=seniority.SeniorityName;
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Seniority * seniority = (self.seniorityList)[indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SongListViewController* songListView =[story instantiateViewControllerWithIdentifier:@"songList"];
    [songListView getSongListBySeniorityNameTI:seniority.SeniorityName];
    [self.navigationController pushViewController:songListView animated:YES];
}
@end
