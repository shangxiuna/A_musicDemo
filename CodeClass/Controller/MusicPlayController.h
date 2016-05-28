//
//  MusicPlayController.h
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayController : UIViewController

@property (assign ,nonatomic) NSInteger index;
@property (weak, nonatomic) IBOutlet UIImageView *songImgView;
//单利声明
singleton_interface(MusicPlayController);



@end
