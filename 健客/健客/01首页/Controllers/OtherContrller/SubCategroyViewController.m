//
//  SubCategroyViewController.m
//  健客
//
//  Created by 刘斐斐 on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubCategroyViewController.h"
#import "SubCategroyModel.h"
#import "SubCateGroyViewCell.h"
#import "ProductDetailViewController.h"

@interface SubCategroyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_underBarView;
    NSMutableArray *_dataArray;
    
    int _currentPage;
    BOOL _isRemoeAll;

    
    
}
@end

@implementation SubCategroyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.itemName;
    
    //调用父类方法 创建导航条
    [self createBarButtonItem];
    
    [self createUnderBarChooseView];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _currentPage = 1;
    [self createTableview];
    
    [self initData];
    
}
-(void)createUnderBarChooseView
{
    _underBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, (LFFScreenH-64)/10)];
    _underBarView.backgroundColor = LFFBGColor;
    [self.view addSubview:_underBarView];
    
    NSArray *title = @[@"默认",@"销量",@"筛选条件"];
    
    for (int i = 0; i<3; i++ ) {
        UIView *view = [[LFFView alloc] initWithFrame:CGRectMake(i*(LFFScreenW/3), 0, LFFScreenW/3, _underBarView.height)];
        view.backgroundColor = LFFBGColor;
        view.userInteractionEnabled = YES;
        [_underBarView addSubview:view];
        
        
        UIButton *btn = [LFFView createBtnWithFrame:CGRectMake(0, 0, view.width*2.0/3, _underBarView.height) imageName:nil text:title[i] target:self sel:@selector(initDataWihtBtn:) textFont:LFFFont(12) textColor:[UIColor blackColor]];
    
        [view addSubview:btn];
     
        //设置小三角形的位置
        if (i == 0){
            UIImageView *arrowUnder1 = [LFFView createLineImageViewWithFrame:CGRectMake(btn.maxX-20, (_underBarView.height-15)/2, 15, 15) imageName:@"pullBtn@2x"];
            [view addSubview:arrowUnder1];
        }
        if (i==1) {
            UIImageView *arrowUnder1 = [LFFView createLineImageViewWithFrame:CGRectMake(btn.maxX-20, (_underBarView.height-15)/2, 15, 15) imageName:@"pullBtn@2x"];
            [view addSubview:arrowUnder1];
        }
        if (i == 2) {
            UIImageView *arrowUnder1 = [LFFView createLineImageViewWithFrame:CGRectMake(btn.maxX-10, (_underBarView.height-15)/2, 15, 15) imageName:@"pullBtn@2x"];
            [view addSubview:arrowUnder1];
        }
        
    }
}

#pragma  mark - 网络请求
-(void)initData
{
    if (_isSearh == NO) {
        NSString *url = [NSString stringWithFormat:SubCategroyURL,_currentPage,_itemID];
        LFFLog(@"%@",url);
        
        [LFFTool sendGETWtihURL:url parameters:nil SuccessBlock:^(id responserData) {
            id backData = [NSJSONSerialization JSONObjectWithData:responserData options:NSJSONReadingMutableLeaves error:nil];
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
            
            if (_isRemoeAll) {
                [_dataArray removeAllObjects];
            }
            
            NSDictionary *infoDict = backData[@"info"];
            NSArray *infoDictArr = infoDict[@"productResults"];
            for (NSDictionary *dict  in infoDictArr) {
                
                SubCategroyModel *model = [[SubCategroyModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            
        } ErrorBlock:^(NSError *error) {
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        }];
    }else
    {
        _urlStr = [_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
            NSString *url2 = [NSString stringWithFormat:SearchURL2,_currentPage,_urlStr];
        
        [LFFTool sendGETWtihURL:url2 parameters:nil SuccessBlock:^(id responserData) {
            id backData = [NSJSONSerialization JSONObjectWithData:responserData options:NSJSONReadingMutableLeaves error:nil];
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
            
            if (_isRemoeAll) {
                [_dataArray removeAllObjects];
            }
            
            NSDictionary *infoDict = backData[@"info"];
            NSArray *infoDictArr = infoDict[@"productResults"];
            for (NSDictionary *dict  in infoDictArr) {
                SubCategroyModel *model = [[SubCategroyModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            
        } ErrorBlock:^(NSError *error) {
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        }];

        
        
        
    }

}
#pragma mark -创建tableview
-(void)createTableview
{

    //这里为什么减110?
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _underBarView.maxY, LFFScreenW, LFFScreenH-110)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = [SubCateGroyViewCell cellHeight];
    
    [self.view addSubview:_tableView];
    
    //明杰吃包子 刷新下拉
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _tableView.header = header;
    
    //明杰吃包子 刷新上啦
    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _tableView.footer = footer;
    
    
}
#pragma mark - Tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        SubCateGroyViewCell *cell = [SubCateGroyViewCell cellWithTableView:tableView];
      
        [cell setModel:_dataArray[indexPath.row] WithisSearch:_isSearh];
        return cell;
   
}
#pragma mark 点击cell的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strID = [_dataArray[indexPath.row] productId];
    NSString *strName = [_dataArray[indexPath.row] productName];
    LFFLog(@"%@%@",strID,strName);
   
    ProductDetailViewController * productDet = [[ProductDetailViewController alloc] init];
    productDet.productCode = strID;
    productDet.productName = strName;
    
    
    [self.navigationController pushViewController:productDet animated:YES];
 
}


#pragma mark - 明杰吃包子刷新
-(void)headerRefresh{
    _currentPage = 1;
    _isRemoeAll = YES;
    [self initData];

}

-(void)footerRefresh{
    _currentPage++;
    _isRemoeAll = NO;
    [self initData];

}
#pragma mark - 销量按钮等 点击事件
-(void)initDataWihtBtn:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"默认"]) {
        LFFLog(@"默认");
    }
    if ([sender.currentTitle isEqualToString:@"销量"]) {
        LFFLog(@"销量");
    }
    if ([sender.currentTitle isEqualToString:@"筛选条件"]) {
        LFFLog(@"筛选条件");
    }
    
}


@end
