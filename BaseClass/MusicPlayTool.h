//
//  MusicPlayTool.h
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/27.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicInfo.h"
@protocol MusicPlayToolDelegate <NSObject>
/*
 获取播放音乐的信息
 @pram curTime 当前时间
 @pram TotalTime 总时间
 @pram Prograss 进度条进度
  */
-(void)getCurTime:(NSString* )curTime ToTime:(NSString* )totalTime Prograss:(CGFloat)prograss;
//当音乐播放完,要做的操作
-(void)endofPlay;

@end


@interface MusicPlayTool : NSObject
//播放器
@property (strong ,nonatomic) AVPlayer *player;
//代理对象
@property (weak ,nonatomic) id delegate;
//定时器
@property (strong ,nonatomic) NSTimer *timer;
//
@property (strong ,nonatomic) MusicInfo *musicInfo;
//单例的声明
singleton_interface(MusicPlayTool);

//准备播放
-(void)musicPrePlay;

//播放
-(void)musicPlay;

//暂停或者播放
-(void)musicPlayOrPause;

//跳转播放(进度条)
-(void)seekToTimeWithValue:(CGFloat)value;







@end
