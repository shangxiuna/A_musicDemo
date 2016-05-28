//
//  MusicListCell.h
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *songImgView;


@property (weak, nonatomic) IBOutlet UILabel *songName;


@property (weak, nonatomic) IBOutlet UILabel *songerName;


@end
