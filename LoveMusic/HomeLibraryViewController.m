//
//  HomeLibraryViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/30.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "HomeLibraryViewController.h"

@interface HomeLibraryViewController ()

@end

@implementation HomeLibraryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    CGRect   frame = self.view.bounds;
    UIImageView *background = [[UIImageView alloc]initWithFrame:frame];
    background.image = [UIImage imageNamed:@"TabBarBack2.png"];
    background.alpha=0.5;
    [self.view addSubview:background];
    self.homeLists = [NSMutableArray arrayWithCapacity:20];
    HomeList * homeList = [[HomeList alloc]init];
    homeList.ListName=@"歌手";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"国家";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"风格";
    [[self homeLists] addObject:homeList];
    homeList = [[HomeList alloc]init];
    homeList.ListName=@"排行";
    [[self homeLists] addObject:homeList];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self homeLists].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeLibraryCell"];
    HomeList * homelist = (self.homeLists)[indexPath.row];
    cell.textLabel.text=homelist.ListName;
    cell.detailTextLabel.text=homelist.ListDetail;
    if(indexPath.row==0)
        cell.image=[UIImage imageNamed:@"Singer.png"];
    else if(indexPath.row==1)
        cell.image=[UIImage imageNamed:@"Country.png"];
    else if(indexPath.row==2)
        cell.image=[UIImage imageNamed:@"Style.png"];
    else if(indexPath.row==3)
        cell.image=[UIImage imageNamed:@"Seniority.png"];
    return cell;
}
//实现didSelectRowAtIndexPath
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row]+1==1){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SingerListViewController* singerList =[story instantiateViewControllerWithIdentifier:@"singerList"];    //传递参数
        //跳转到appViewController
        [singerList getSingerListTI];
        [self.navigationController pushViewController:singerList animated:YES];
    }
    else if([indexPath row]+1==2){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CountryViewController* countryList =[story instantiateViewControllerWithIdentifier:@"countryList"];    //传递参数
        //跳转到appViewController
        [countryList getCountryListTI];
        [self.navigationController pushViewController:countryList animated:YES];
        
    }
    else if([indexPath row]+1==3){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        StyleViewController * styleList =[story instantiateViewControllerWithIdentifier:@"styleList"];    //传递参数
        //跳转到appViewController
        [styleList getAllStyleTI];
        [self.navigationController pushViewController:styleList animated:YES];
    }
    else if([indexPath row]+1==4){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SeniorityViewController * seniorityList =[story instantiateViewControllerWithIdentifier:@"seniorityList"];    //传递参数
        //跳转到appViewController
        [seniorityList getALLSeniorityTI];
        [self.navigationController pushViewController:seniorityList animated:YES];
    }
}
@end
