//
//  CountryViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/31.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController ()

@end

@implementation CountryViewController

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
-(void)getCountryListTI{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/getCountryList"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSArray *arr = (NSArray *)[received  mutableObjectFromJSONData];
    self.countryList = [NSMutableArray arrayWithCapacity:arr.count];
    for(int i=0;i<arr.count;i++)
    {
        Country * c = [[Country alloc]init];
        NSDictionary *country = [arr objectAtIndex:i];
        c.CountryName = [country objectForKey:@"CountryName"];
        [self.countryList addObject:c];
        NSLog(c.CountryName);
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.countryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"countrycell"];
    Country * country = (self.countryList)[indexPath.row];
    cell.textLabel.text=country.CountryName;
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Country * country = (self.countryList)[indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SingerListViewController * singerListView =[story instantiateViewControllerWithIdentifier:@"singerList"];
    [singerListView getSingerListByCountryNameTI:country.CountryName];
    [self.navigationController pushViewController:singerListView animated:YES];
}
@end
