//
//  Song.h
//  LoveMusic
//
//  Created by Pele Chan on 15/4/3.
//  Copyright (c) 2015年 Pele Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject
@property int SongID;
@property int SingerID;
@property int SongLength;
@property(nonatomic,strong)NSString * SongName;
@property(nonatomic,strong)NSString * StyleName;
@property(nonatomic,strong)NSString * SongAddress;
@property Boolean IsFavorite;
@end
