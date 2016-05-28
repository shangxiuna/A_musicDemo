//
//  MusicPlayTool.m
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/27.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import "MusicPlayTool.h"

@implementation MusicPlayTool

singleton_implementation(MusicPlayTool);

//为什么写初始化方法
//因为我们要获取音乐播放结束这个事件,但是AVplayer并没有通过代理或者block 给我们返回这个事件,它所做的处理,是在通知中心注册了一条通知,我们只能在创建AVplaer时,通过通知中心添加观察者来观察播放状态,
- (instancetype)init
{
    self = [super init];
    _player = [[AVPlayer alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endofPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    return self;
}
-(void)endofPlay:(NSNotification *)sender{
    
    [self musicPlayOrPause]; 
    [self.delegate endofPlay];//调用代理
    
}

//准备播放
-(void)musicPrePlay{
    //根据下面的操作,每创建一个新的item.就会马上为其添加一个观察者.
    //如果 AVplayer 有currentItem,说明他一定存在一个观察者,所以我们要对它进行移除.
    if (self.player.currentItem != nil) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
        
    //根据传入的歌曲地址,(URL)创建一个item,用于播放音乐.
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.musicInfo.mp3Url]];
    NSLog(@"%@",self.musicInfo.mp3Url);
    
    //给item添加观察者,观察播放状态的改变,一旦准备完成,直接播放音乐.
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //用带有观察者的 item 去替换当前的 item
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    
}
#pragma mark 当观察值发生变化之后,要做的操作
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        switch ([[change valueForKey:@"new"] integerValue]) {
            case AVPlayerStatusUnknown:
                NSLog(@"未知状态");
                break;
            case AVPlayerStatusReadyToPlay:
                NSLog(@"准备完成,播放音乐");
                //播放音乐
                [self musicPlay];
                break;
            case AVPlayerStatusFailed:
                NSLog(@"播放失败");
                break;
                
            default:
                break;
        }
    }
}

//播放音乐
-(void)musicPlay{
    //若果定时器,已经存在,说明音乐正在播放,就不在进行操作了.
    if (self.timer != nil) {
        return;
    }
    
    //音乐播放启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeAC:) userInfo:nil repeats:YES];
    [self.player play];
}
//定时器调用方法
-(void)timeAC:(NSTimer *)timer{

    [self.delegate getCurTime:  [NSString stringWithFormat:@"%.2ld:%.2ld",[self getCurTime]/60,[self getCurTime]%60 ]ToTime:[NSString stringWithFormat:@"%.2ld:%.2ld",[self getTotalTime]/60,[self getTotalTime]%60] Prograss:[self getProrass]];
    
    
    
}
//获取当前时间
-(NSInteger )getCurTime{
    //CMTtime 获取秒数计算公式
    if (self.player.currentItem) {
        return self.player.currentTime.value/self.player.currentTime.timescale;
    }else{
        return 0;
    }
}
//获取总时间
-(NSInteger )getTotalTime{
    CMTime totalTime = self.player.currentItem.duration;
    if (totalTime.timescale == 0) {
        return 1;
    }else{
        return totalTime.value/totalTime.timescale;
    }
    
   // return [self.musicInfo.duration integerValue];
}

//获取进度条进度
-(CGFloat)getProrass{
    //当前时间除以总时间,得到一个0-1之间的小数,就是进度条的进度
    return (CGFloat) [self getCurTime]/(CGFloat)[self getTotalTime];
    
}



//暂停或者播放
-(void)musicPlayOrPause{
    [self.timer invalidate];//暂停计时器
    self.timer = nil; //置空
    [self.player pause];//暂停
    
}

//跳转播放(进度条)
-(void)seekToTimeWithValue:(CGFloat)value{
   //跳转前,先把音乐暂停,跳转至相应进度在开始播放
    [self musicPlayOrPause];
    [self.player seekToTime:CMTimeMake(value *[self getTotalTime], 1) completionHandler:^(BOOL finished) {
        //若果完成,就按着当前进度播放
        if (finished) {
            [self musicPlay];
        }
        
    }];
}





@end
