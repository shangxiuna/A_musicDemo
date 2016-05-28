//
//  GetDataTool.h
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PassValue)(NSMutableArray *dataArray);


@interface GetDataTool : NSObject

@property (strong ,nonatomic)NSMutableArray *dataArray;


//单利声明
+(instancetype)shareGetDataTool;
//请求完成,调用block ,把数组参数传回来.
-(void)getData:(PassValue)passValue;

@end
