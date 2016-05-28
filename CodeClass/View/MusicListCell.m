//
//  MusicListCell.m
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import "MusicListCell.h"

@implementation MusicListCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.songImgView.layer.masksToBounds = YES;
    self.songImgView.layer.cornerRadius = self.songImgView.frame.size.width*5/17;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
