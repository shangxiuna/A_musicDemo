//
//  GetDataTool.m
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import "GetDataTool.h"
#import "MusicInfo.h"


@implementation GetDataTool
//单利模式
//singleton_implementation(GetDataTool);//单例的宏模式

+(instancetype)shareGetDataTool{
    static GetDataTool *gd = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gd = [[GetDataTool alloc]init];
          });
    return gd;
}
//网络请求 block
-(void)getData:(PassValue)passValue{
    /*
     为什么要加多线程?
     //因为arrayWithContentURL方法是同步请求,放在主线程,会造成主线程阻塞.
    */
    
    dispatch_queue_t globle = dispatch_get_global_queue(0, 0);
    //发起异步请求
    dispatch_async(globle, ^{
        //这种方法,是通过打开远端服务器,的文件来获取数据,没有网的情况不会造成崩溃.
        NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:K_MUSIC_URL]];
        //解析
        for (NSDictionary *dic in array) {
            MusicInfo *musicInfo = [[MusicInfo alloc]init];
            [musicInfo setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:musicInfo];
        }
       //请求完成,调用block,把装有数据的数组当做参数传出去
        passValue(self.dataArray);
   
    });
   
}
//数组懒加载
-(NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
 }

@end
