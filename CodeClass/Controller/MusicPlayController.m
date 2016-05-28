//
//  MusicPlayController.m
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import "MusicPlayController.h"
#import "MusicInfo.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicPlayController ()< MusicPlayToolDelegate >

@property (weak, nonatomic) IBOutlet UILabel *currentTime;

@property (weak, nonatomic) IBOutlet UILabel *totalTime;

@property (weak, nonatomic) IBOutlet UISlider *prossSlider;


@property (weak, nonatomic) IBOutlet UILabel *songName;


@property (weak, nonatomic) IBOutlet UILabel *singerName;


//按钮
@property (weak, nonatomic) IBOutlet UIButton *lastSong;

@property (weak, nonatomic) IBOutlet UIButton *playSong;

@property (weak, nonatomic) IBOutlet UIButton *nextSong;

@property (strong ,nonatomic) NSTimer *time;

@end

@implementation MusicPlayController

//单例的实现
singleton_implementation(MusicPlayController);

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     在build setting 里搜
     prefix Header 进行设置 一些宏定义写在里面
    */
    //导航栏设置不透明
    self.navigationController.navigationBar.translucent = NO;
    
    self.songImgView.layer.masksToBounds = YES;
    self.songImgView.layer.cornerRadius = self.songImgView.frame.size.height/2;

    //设置音乐播放器代理
    [MusicPlayTool sharedMusicPlayTool].delegate = self;
    
    //添加观察者,监听AVPlayer 的rate(播放速率)属性的值,若果是0.就是暂停了.非0,就是在播放.
    [[MusicPlayTool sharedMusicPlayTool].player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    
    //画面旋转
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
}
#pragma mark 监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"rate"]) {
        if ([[change valueForKey:@"new"]integerValue] == 0) {
            //若果是0.就是在暂停,按钮提示应该是播放
            [self.playSong setTitle:@"播放" forState:(UIControlStateNormal)];
        }else{
            [self.playSong setTitle:@"暂停" forState:(UIControlStateNormal)];
        }
    }
}
#pragma mark 工具类代理方法
-(void)getCurTime:(NSString* )curTime ToTime:(NSString* )totalTime Prograss:(CGFloat)prograss{
    self.currentTime.text = curTime;
    self.totalTime.text = totalTime;
    self.prossSlider.value = prograss;
  
}
-(void)endofPlay{
    //播放完成,继续播放下一首
    [self nextSongAction:nil];
   
}

//播放和暂停
- (IBAction)playSongAction:(UIButton *)sender {
    // [[MusicPlayTool sharedMusicPlayTool] musicPrePlay];
  
    
    if ([MusicPlayTool sharedMusicPlayTool].player.rate == 0) {
        [[MusicPlayTool sharedMusicPlayTool] musicPlay];
        self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    }else{
        [[MusicPlayTool sharedMusicPlayTool] musicPlayOrPause];
        [self.time invalidate];
        self.time = nil;
    }
    
    
    
}

//上一首
- (IBAction)lastSongAction:(UIButton *)sender {
    if (self.index == 0) {
        self.index = [GetDataTool shareGetDataTool].dataArray.count - 1;
    }else{
        self.index -= 1;
    }
     [self musicRealPlay];
}

//下一首
- (IBAction)nextSongAction:(UIButton *)sender {
    if (self.index == [GetDataTool shareGetDataTool].dataArray.count - 1) {
        self.index = 0;
    }else{
        self.index += 1;
    }
      [self musicRealPlay];
}

-(void)musicRealPlay{
    
    MusicInfo *musicIn = [GetDataTool shareGetDataTool].dataArray[_index];
    
    [self.songImgView sd_setImageWithURL:[NSURL URLWithString:musicIn.picUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    self.songName.text = musicIn.name;
    self.singerName.text = musicIn.singer;
    //判断点击的是否是同一个cell.若果是,不进行操作,若果不是把新点击的cell对应的musicInfo赋值给MusicPlayTool 的musicInfo
    if ([[GetDataTool shareGetDataTool].dataArray[_index] isEqual:[MusicPlayTool sharedMusicPlayTool].musicInfo]) {
        return;
    }
    
    
    [MusicPlayTool sharedMusicPlayTool].musicInfo = musicIn ;
    
    [[MusicPlayTool sharedMusicPlayTool] musicPrePlay];
    
}

-(void)timeAction{
    [UIView animateWithDuration:2 animations:^{
       self.songImgView.transform = CGAffineTransformRotate(self.songImgView.transform, M_PI/3);
    }];
    
}


//监听Slider数值变化(进度条)
- (IBAction)progressChange:(UISlider *)sender {
    [[MusicPlayTool sharedMusicPlayTool] seekToTimeWithValue:sender.value];
}

//放页面将要出现,播放
-(void)viewWillAppear:(BOOL)animated{
    //单独一个方法,可以重复调用
    [self musicRealPlay];
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

@end
