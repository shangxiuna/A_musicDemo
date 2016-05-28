//
//  MusicInfo.m
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import "MusicInfo.h"

@implementation MusicInfo
//重写歌词(容错处理)
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"lyric"]) {
        self.lyricArr = [value componentsSeparatedByString:@"\n"];//根据后面的字符串来截取前面的字符串,并放入一个数组中.
}
    
    
 
    
    
    
}




@end
