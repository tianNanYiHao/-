//
//  MyFavertViewController.m
//  健客
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyFavertViewController.h"
#import "MyFavertViewCell.h"
#import "ProductDetailModel.h"
#import "ProductDetailViewController.h"

@interface MyFavertViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
    UITableView *_tableview;
    
}
@end

@implementation MyFavertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = LFFBGColor;
    
    [self createBarButtonItem];
    
    //初始数据源
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _dataArray = [[DBManger sharManger] selectAlldata];
    
   
    [self crateTableview];
    [_tableview reloadData];

    
}
#pragma mark cell重复刷新 重复调用 (跟新取消收藏的cell状态
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _dataArray = [[DBManger sharManger] selectAlldata];
    [_tableview reloadData];

}

-(void)crateTableview
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
 
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFavertViewCell *cell = [MyFavertViewCell cellWithTableview:tableView];
    cell.model = _dataArray[indexPath.row];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailViewController *prodC = [[ProductDetailViewController alloc] init];
    
    prodC.productCode = [_dataArray[indexPath.row] productCode];
    [self.navigationController pushViewController:prodC animated:YES];
}

@end
