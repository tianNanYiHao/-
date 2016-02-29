//
//  PinLunViewController.m
//  健客
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PinLunViewController.h"
#import "PinlunModel.h"
#import "PinlunViewCell.h"

@interface PinLunViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_dataArray1; //view 数据源
    
    NSMutableArray *_dataArray2; //tabelview数据源
    int _currentpage;
    
    UIView  *_underBarView;
    
    BOOL _isRemoveAllData;
    BOOL _isDataArray1;
    bool _isDataArray2;
    
    
}
@end

@implementation PinLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户评论";
    self.view.backgroundColor = LFFBGColor;
    _currentpage = 1;
    _isDataArray1 = YES;

    
    [self createBarButtonItem];
    
    
    [self initDataArray]; //初始化数组
    
    //请求网络数据
    [self initNetWorkData];
    
    [self createTabelview];


}
-(void)initDataArray
{
    _dataArray1 = [NSMutableArray arrayWithCapacity:0];
    _dataArray2 = [NSMutableArray arrayWithCapacity:0];
    
}

-(void)initNetWorkData
{
    NSString *str = [NSString stringWithFormat:CommentURL,_currentpage,_priductID];
    
    [LFFView showHUDWithText:@"评论加载中..." toView:self.view];
    [LFFTool sendGETWtihURL:str parameters:nil SuccessBlock:^(id responserData) {
        [LFFView hiddenHUDWithText:nil toView:self.view];
        id backData = [NSJSONSerialization JSONObjectWithData:responserData options:NSJSONReadingMutableLeaves error:nil];
        
        if (_isRemoveAllData) {
            [_dataArray2 removeLastObject];
        }
        
        NSDictionary *dictInfo = backData[@"info"];
        PinlunModel *model = [[PinlunModel alloc] init];
        [model setValuesForKeysWithDictionary:dictInfo];
        [_dataArray1 addObject:model];
        LFFLog(@"%@",[_dataArray1[0] totalcount]);
        
        
        NSArray *dictArr = dictInfo[@"EvaluationDetials"];
        for (NSDictionary *dict in dictArr) {
            PinlunModel *model2 = [[PinlunModel alloc] init];
            [model2 setValuesForKeysWithDictionary:dict];
            [_dataArray2 addObject:model2];
        }
        
        
        if (_isDataArray1) {
           [self createUnderBarView]; //创建导航条下面的view
        }
        
        
        
        
        [_tableview reloadData];
        
    } ErrorBlock:^(NSError *error) {
        [LFFView hiddenHUDWithText:nil toView:self.view];
    }];
    
}

-(void)createUnderBarView
{

  _underBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 32)];
    [self.view addSubview:_underBarView];
    _underBarView.backgroundColor = [UIColor lightGrayColor];
    
    
    //1
    UILabel *leftCommLab = [LFFView createLabWithFrame:CGRectMake(6, 6, LFFScreenW/3, 20) color:nil font:nil text:nil];
    leftCommLab.font = LFFFont(10);
    //设置可变字符串
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共有%@位网友评论",[_dataArray1[0] totalcount]]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,[_dataArray1[0] totalcount].length-1)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(3+[_dataArray1[0] totalcount].length,5)];
    
    
    leftCommLab.attributedText = str;
    [_underBarView addSubview:leftCommLab];
    
    //2总评分
    UILabel *rightComLab = [LFFView createLabWithFrame:CGRectMake(leftCommLab.maxX*3/4.0, 6, LFFScreenW/3, 20) color:nil font:nil text:nil];
    rightComLab.textColor = [UIColor redColor];
    rightComLab.font = LFFFont(10);
    //设置可变字符串
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总评分:%@分",[_dataArray1[0] totalStar]]];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(5, 1)];
    rightComLab.attributedText = str2;
    rightComLab.textAlignment = NSTextAlignmentRight;
    [_underBarView addSubview:rightComLab];
    
    //3 starBG
    for (int i = 0; i<5; i++) {
        UIImageView * starBg = [LFFView createLineImageViewWithFrame:CGRectMake(rightComLab.maxX+5+i*(15+1), 10, 15, 15) imageName:@"evaluate_star_normal@2x"];
        [_underBarView addSubview:starBg];
        
    }
    for (int i = 0; i<[[_dataArray1[0] totalStar] floatValue]; i++) {
        
        UIImageView * starForeg = [LFFView createLineImageViewWithFrame:CGRectMake(rightComLab.maxX+5+i*(15+1), 10, 15, 15) imageName:@"evaluate_star_selected@2x"];
        [_underBarView addSubview:starForeg];
        
    }


}
-(void)createTabelview
{

    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,32, LFFScreenW, LFFScreenH-64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    
    //下拉刷新
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerReferesh)];
    _tableview.header = header;
    
    //上拉加载
    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _tableview.footer = footer;
    
  
}

#pragma mark -tableview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray2.count;
}


#pragma mark 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0 == [_dataArray2[indexPath.row] cellHeight]?110:[_dataArray2[indexPath.row] cellHeight];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PinlunViewCell *cell = [PinlunViewCell cellWithTableview:tableView];
    cell.model = _dataArray2[indexPath.row];
    return cell;
}
#pragma mark - 刷新操作
-(void)headerReferesh
{
    
    _currentpage = 1;
    _isDataArray1 = NO;
    _isRemoveAllData = YES;
    [self initNetWorkData];
    
}
-(void)footerRefresh
{
    _currentpage++;
    _isRemoveAllData = NO;
    
    [self initNetWorkData];
}

@end
