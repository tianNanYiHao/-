//
//  PersonalCenterViewController.m
//  健客
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonCenterBtnView.h"
#import "PersonCentrlModel.h"
#import "SmallPersonTableViewCell.h"

#import "MyFavertViewController.h"
@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
 
    UITableView *_smallTableView;
    
    NSMutableArray *_dataSectionArray;
    
    NSArray *_dataNumArr;
   
}
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump2:) name:JUMP1 object:nil];
    
    
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"我的健客";
    
    [self createPersonCenterView];
    
    _dataNumArr = [[NSArray alloc] init];
    _dataNumArr = [[DBManger sharManger] selectAlldata];
    [_smallTableView reloadData];
    LFFLog(@"%ld",_dataNumArr.count);

    [self initData];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _dataNumArr = [[DBManger sharManger] selectAlldata];
     [self initData];
    [_smallTableView reloadData];
  
}


#pragma mark - 创建个人中心页
-(void)createPersonCenterView
{

    PersonCenterBtnView *peronBtnView = [PersonCenterBtnView personCenterBtnViewWithFrame:CGRectMake(0, 0, LFFScreenW, (LFFScreenH-64-49)/2)];

    _smallTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, LFFScreenW, LFFScreenH-64) style:UITableViewStyleGrouped];
    _smallTableView.delegate = self;
    _smallTableView.dataSource = self;
    _smallTableView.tableHeaderView = peronBtnView;
    _smallTableView.backgroundColor = LFFBGColor;
//    [[UIColor alloc]initWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]; //添加颜色 保证刷新小图不出现矩形白框
    
    [self.view addSubview:_smallTableView];
    
    
    MJChiBaoZiHeader *headeRefresh = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
    _smallTableView.header = headeRefresh;
    
    MJRefreshAutoFooter *footerRefresh = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
    _smallTableView.footer = footerRefresh;
    
  
    
}


-(void)initData
{

    [_dataSectionArray removeAllObjects];


    //*****伪请求数据代码 (提供后期请求数据使用)*************
    [LFFTool sendGETWtihURL:@"11" parameters:nil SuccessBlock:^(id responserData) {
    
        [_smallTableView.header endRefreshing];
        [_smallTableView.footer endRefreshing];
        
    } ErrorBlock:^(NSError *error) {
        [_smallTableView.header endRefreshing];
        [_smallTableView.footer endRefreshing];

    
        
    }];
   // *****伪请求数据代码 (提供后期请求数据使用)**************

    
    
       _dataSectionArray = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *iamgeNameArr1 = @[@"mycollection@2x",@"myIntegrated@2x",@"mydiscountcoupon@2x"];
    NSArray *iamgeNameArr2 = @[@"mysettings@2x",@"afterMarket@2x",@"share-packet@2x"];
    
    NSArray *titleLabArr1 = @[@"我的收藏",@"我的积分",@"我的优惠券和红包"];
    NSArray *titleLabArr2 = @[@"设置",@"在线售后",@"赢红包"];
    
      NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<iamgeNameArr1.count; i++) {
            PersonCentrlModel *model = [[PersonCentrlModel alloc] init];
            model.imageName = iamgeNameArr1[i];
            model.laberName = titleLabArr1[i];
            model.numberLab = [NSString stringWithFormat:@"%ld",_dataNumArr.count];
//            LFFLog(@"@@@@@@@%@",model.numberLab);
            [arr1 addObject:model];
           
        }
         [_dataSectionArray addObject:arr1];
        
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0 ; i<iamgeNameArr2.count; i++) {
            PersonCentrlModel *model = [[PersonCentrlModel alloc] init];
            model.imageName = iamgeNameArr2[i];
            model.laberName = titleLabArr2[i];
            [arr2 addObject:model];
        
        }
         [_dataSectionArray addObject:arr2];

}

#pragma mark - 代理(smallTabelview)
#pragma mark 组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSectionArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSectionArray[section] count];
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    SmallPersonTableViewCell *cell = [SmallPersonTableViewCell samllPersonCellWithTableview:tableView];
    NSMutableArray *arr = _dataSectionArray[indexPath.section];
    cell.model = arr[indexPath.row];

    return cell;
}

#pragma mark  - 调整section之间的间距
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MyFavertViewController *myf = [[MyFavertViewController alloc]init];
            myf.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myf animated:YES];
            
            
        }
    }
}


#pragma mark - 刷新数据
-(void)headerRefresh:(MJChiBaoZiHeader*)header;
{
    [self initData];
}

#pragma mark - 刷新数据2
-(void)footerRefresh:(MJChiBaoZiFooter*)footer;
{
    [self initData];
}




-(void)jump2:(NSNotification*)noti
{
    
//    //开始遍历 (通过tag值 开始判断)
//    for (UIView *view in self.tabBarController.tabBar.subviews) {
//        //找到_bgView
//        if (view.tag == 200) {
//            for (UIView *view2 in view.subviews) {
//                if (view2.tag == 103) {
//                    UIButton *btn = (UIButton*)view2;
//                    btn.selected = YES;   //只有这样,才能遍历出btn 开启首页tabBar按钮的选中状态
//                }
//                if (view2.tag == 102) {
//                    UIButton *btn = (UIButton*)view2;
//                    btn.selected = NO;   //关闭 购物车tabBar按钮的选中状态
//                }
//            }
//        }
//    }

    self.tabBarController.selectedIndex = 3;
    
    
}
@end
