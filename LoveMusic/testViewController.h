//
//  testViewController.h
//  LoveMusic
//
//  Created by Pele Chan on 15/3/23.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
#import "Singer.h"
#import <AVFoundation/AVFoundation.h>
@interface testViewController : UIViewController
@property(strong,nonatomic) AVPlayer * songPlayer;
@property(strong,nonatomic) AVPlayerItem *mp3PlayerItem;
@property (strong, nonatomic) IBOutlet UILabel *testLabel;

@end
