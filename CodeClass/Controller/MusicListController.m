//
//  MusicListController.m
//  A_musicDemo
//
//  Created by MengQingFei on 16/5/26.
//  Copyright © 2016年 MengQingFei. All rights reserved.
//

#import "MusicListController.h"
#import "MusicListCell.h"
#import "MusicInfo.h"
#import "MusicPlayController.h"

@interface MusicListController ()

@property (strong ,nonatomic) NSMutableArray *dataArray;

@end

@implementation MusicListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"歌曲列表";
    
    
    //隐藏cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.dataArray = [NSMutableArray array];
    //请求数据
    [[GetDataTool shareGetDataTool]getData:^(NSMutableArray *dataArray) {
        //用数组接收block传回来的数组
        
        self.dataArray = dataArray;
        //回到主线程刷新列表,(对UI的操作)
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MusicListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    MusicInfo *model = self.dataArray[indexPath.row];
    
    [cell.songImgView  sd_setImageWithURL:[NSURL URLWithString: model.picUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    cell.songName.text = model.name;
    cell.songerName.text = model.singer;
   
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   [MusicPlayController sharedMusicPlayController].index = indexPath.row;
//    
//    MusicPlayController *mVC = [[MusicPlayController alloc]init];
//    //属性传值
//    mVC.index = indexPath.row;
  
[self.navigationController showViewController:  [MusicPlayController sharedMusicPlayController] sender:self];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
