//
//  HomeTabViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/25.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "HomeTabViewController.h"
#import "MusicViewController.h"
@interface HomeTabViewController ()

@end

@implementation HomeTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMusicController:(id)sender {
    MusicViewController* musicView =[MusicViewController sharedInstance];    //传递参数
    //跳转到appViewController
    [self.navigationController pushViewController:musicView animated:YES];
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
