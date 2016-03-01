//
//  JumpTabBarListViewController.m
//  健客
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JumpTabBarListViewController.h"
#import "JumpTabBarListModel.h"
#import "JumpTabBarListCell.h"


@interface JumpTabBarListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_dataArray;
    
}
@end

@implementation JumpTabBarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createtableview];
    [self initDta];
    
   
    
}
-(void)createtableview
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, 22*4)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.alwaysBounceVertical = NO;
    [self.view addSubview:_tableview];
}
-(void)initData
{
    _dataArray = [NSMutableArray array];
    
     NSArray *nomalPic = @[@"shouye_inactive@2x",@"yongyaotixing_inactive@2x",@"gerenzhongxin_inactive@2x",@"gouwuche_inactive@2x"];
    NSArray *titleArr = @[@"首页",@"用药提醒",@"个人中心",@"购物车"];
    
    for (int i = 0; i<4; i++) {
        
        JumpTabBarListModel *model = [[JumpTabBarListModel alloc] init];
        model.iamgeName = nomalPic[i];
        model.titleName = titleArr[i];
        [_dataArray addObject:model];
    }

}

#pragma mark - 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count
    ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JumpTabBarListCell *cell = [JumpTabBarListCell cellWithTabelView:tableView];
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 22;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.row == 0) {
        LFFLog(@"1");
        
        
    }
    if (indexPath.row == 1) {
        LFFLog(@"2");

        
    }
    if (indexPath.row == 2) {
        LFFLog(@"3");

        
    }
    if (indexPath.row == 3) {
        LFFLog(@"4");
        
        
    }
    
}

@end
