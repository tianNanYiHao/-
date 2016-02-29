//
//  MassageBoxLeftVIewControllerViewController.m
//  健客
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MassageBoxLeftVIewControllerViewController.h"
#import "MassageBoxLeftModel.h"
#import "MassageBoxLeftCell.h"

//#import "AllCategroyRightListController.h"
#import "AllCategroyModel.h"

#import "AllCategroyRightCell.h"
#import "AllCategroyRightView.h"

#import "SubCategroyViewController.h"

@interface MassageBoxLeftVIewControllerViewController ()<UITableViewDataSource,UITableViewDelegate,WYPopoverControllerDelegate>
{
    UITableView *_tableView;
    
    UITableView *_tableView2;
  
    NSMutableArray *_dataArray;
    
    NSMutableArray *_dataArray2;
    

    MassageBoxLeftModel *_model;
    AllCategroyModel *_model2;
    

    
}
@end

@implementation MassageBoxLeftVIewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LFFBGColor;
    
    self.title = _CategoryName;
    
    //调用父类的方法 创建导航条按钮
    [self createBarButtonItem];
 
    //左边的tableview
    [self createTabelView];
    
    [self initData];

    //创建  //右边的tabbleview ()
    [self createTabelViewRight];
    
    //请求数据, 从MassageBoxViewController 传进CategroyName
    [self initDataRight];
    
}

#pragma mark  - 创建左边的tableview
-(void)createTabelView
{

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW/3, LFFScreenH)];
    [self.view addSubview:scrollView];
    
    scrollView.alwaysBounceVertical = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.contentSize = CGSizeMake(0, LFFScreenH);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW/3, LFFScreenH-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = [MassageBoxLeftCell cellHeight];
    _tableView.separatorStyle = UITableViewScrollPositionNone;//取消自带的线
    _tableView.backgroundColor = LFFBGColor;
    
    [scrollView addSubview:_tableView];
    
}
-(void)initData
{
    /**
     *  读取plist文件
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProductType.plist" ofType:nil];
    NSArray *arr2 = [NSArray arrayWithContentsOfFile:path];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i<arr2.count; i++) {
    MassageBoxLeftModel *model = [[MassageBoxLeftModel alloc] init];
        model.CategoryName = arr2[i][@"CategoryName"];
        _model = model;
        [_dataArray addObject:model];
    }
    
}


#pragma mark - 创建右边的tableview
-(void)createTabelViewRight
{
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(LFFScreenW/3 , 0, LFFScreenW*2/3, LFFScreenH-64) style:UITableViewStylePlain];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    [self.view addSubview:_tableView2];
    
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(void)initDataRight
{

    _dataArray2 = [NSMutableArray arrayWithCapacity:0];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProductType.plist" ofType:nil];
    NSArray *arr2 = [NSArray arrayWithContentsOfFile:path];
    
    for (int i = 0; i<8; i++) {
        NSString *str = arr2[i][@"CategoryName"];
        if ([str isEqualToString:_CategoryName]) {
            for (NSDictionary *dict in arr2[i][@"symptomName"]) {
                _model2 = [[AllCategroyModel alloc] init];
                [_model2 setValuesForKeysWithDictionary:dict];
                [_dataArray2 addObject:_model2];
                
            }
            [_tableView2 reloadData];
        }
    }

}


#pragma mark tableview代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView2) {
        return _dataArray2.count;
    }
    
    if (tableView == _tableView) {
        return _dataArray.count;
    }
    return 0;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView2) {
        
        AllCategroyRightCell *cell = [AllCategroyRightCell cellWithTabelview:tableView];
        cell.model = _dataArray2[indexPath.row];
        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //设置cell右边的小箭头!!
  
        return cell;
    }
    
    if (tableView == _tableView ) {
        MassageBoxLeftCell *cell = [MassageBoxLeftCell cellWithTabelView:tableView selected:YES];
        cell.model = _dataArray[indexPath.row];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //设置cell点击时候 没有点击效果
        
        return cell;
    }
    return nil;
 
}

#pragma mark  - 点击cell方法 进入跳转页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //点击创建右边的cell
    if (tableView == _tableView) {
        self.CategoryName = [_dataArray[indexPath.row] CategoryName];
        self.title = [_dataArray[indexPath.row] CategoryName];
        //传递数据CategoryName  然后请求右边数据, 创建右边页面
        [self initDataRight];

    }
    //点击右边cell 进入分类控制页
    if (tableView == _tableView2) {
        
        SubCategroyViewController *subC = [[SubCategroyViewController alloc] init];
        subC.itemID = [_dataArray2[indexPath.row] itemID]; //传递ID
        subC.itemName = [_dataArray2[indexPath.row] itemName];// 传递名字
        subC.isSearh = NO;
        
        
        CATransition *anima = [CATransition animation];
        anima.type = @"push";
        anima.subtype = kCATransitionFromTop;

        [self.navigationController pushViewController:subC animated:NO];
        [self.navigationController.view.layer addAnimation:anima forKey:nil];
        
    }
    
    

}

@end
