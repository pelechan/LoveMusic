//
//  testViewController.m
//  LoveMusic
//
//  Created by Pele Chan on 15/3/23.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import "testViewController.h"

@interface testViewController ()

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)test:(id)sender {
    NSString * str =@"http://localhost:8888/music/周杰伦/周杰伦 - 一路向北.mp3";
    NSLog(str);
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.songPlayer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:str]];
    self.songPlayer.volume =0.5;
    //重新载入歌词词典
    [self.songPlayer play];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _songPlayer && [keyPath isEqualToString:@"status"]) {
        if (_songPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
        } else if (_songPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
        } else if (_songPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}
- (IBAction)asdf:(id)sender {
//    int hehe = CMTimeGetSeconds(self.songPlayer.currentItem.currentTime) / CMTimeGetSeconds(self.songPlayer.currentItem.duration);
//    NSLog(@"进度%d",hehe);
//    NSLog(@"%d",CMTimeGetSeconds(self.songPlayer.currentItem.duration));
//    NSLog(@"%f",CMTimeGetSeconds(self.songPlayer.currentItem.currentTime));
//    NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//    NSLog(@"Time Interval:%f",timeInterval);
//    NSLog(@"%f",self.songPlayer.currentItem.duration.timescale);
//    float s=(CGFloat)self.songPlayer.currentItem.duration.value/self.songPlayer.currentItem.duration.timescale;
//    NSLog(@"%d",s);
    CMTime totalTime = self.songPlayer.currentItem.duration;
    //因为slider的值是小数，要转成float，当前时间和总时间相除才能得到小数,因为5/10=0
    CGFloat totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
    NSLog(@"totalMovieDuration:%f",totalMovieDuration);
}
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.songPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}
- (IBAction)yui:(id)sender {
    NSString *str =@"http://127.0.0.1:8888/lrc/陈柏宇/陈柏宇 - 别怕失去.lrc";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
