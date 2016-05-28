//
//  Singleton.h
//  MusicPlayr
//
//  Created by 刘洋 on 16/5/17.
//  Copyright © 2016年 LY. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

//单例类的声明
#define singleton_interface(className)\
+ (instancetype)shared##className

//单例类的实现
#define singleton_implementation(className)\
static className * manager;\
+ (instancetype)shared##className\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    manager = [[[self class] alloc] init];\
    });\
    return manager;\
}

#endif /* Singleton_h */
