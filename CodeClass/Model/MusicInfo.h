//
//  MusicInfo.h
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfo : NSObject
@property (copy ,nonatomic) NSString *name;//歌曲名
@property (copy ,nonatomic) NSString *singer;//歌手
@property (copy ,nonatomic) NSString *mp3Url;//歌曲地址
@property (copy ,nonatomic) NSString *picUrl;//图片地址
@property (copy ,nonatomic) NSString *duration;//歌曲时长
@property (strong ,nonatomic)NSArray *lyricArr;//歌词


@end
