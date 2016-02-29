//
//  FindMdeicDetailViewController.m
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FindMdeicDetailViewController.h"
#import "FindMdeicDetailModel.h"
#import "FindMdeicDetailViewCell.h"

#import "ProductDetailViewController.h"

@interface FindMdeicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView; //
    
    NSArray *_dataUIArray;//界面数据源
    
    NSMutableArray *_dataArray; //总数据源!(section数据源) 装载2个字典
    NSMutableArray *_dataarrayCellAllArray; //cell总数据源 装载四个数组
    
    NSMutableArray *_dataCellArray1; //cell数据源1
    NSMutableArray *_dataCellArray2; //cell数据源2
    NSMutableArray *_dataCellArray3; //cell数据源3
    NSMutableArray *_dataCellArray4; //cell数据源4
    
    BOOL _isExpand; //设置按钮是否选中
    
    
}

@end

@implementation FindMdeicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LFFBGColor;
    self.title = _nameTitle;
    
    
    [self createBarButtonItem];
    
    [self initDataArray];
    
    [self initData];
    
    [self createTableView];
    
}

#pragma mark - 初始化数据
-(void)initDataArray
{
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    _dataarrayCellAllArray = [NSMutableArray arrayWithCapacity:0];
    _dataCellArray1 = [NSMutableArray arrayWithCapacity:0];
    _dataCellArray2 = [NSMutableArray arrayWithCapacity:0];
    _dataCellArray3 = [NSMutableArray arrayWithCapacity:0];
    _dataCellArray4 = [NSMutableArray arrayWithCapacity:0];
    
    
}
#pragma mark - 请求网络数据
-(void)initData
{
    _dataUIArray = @[@"疾病简介",@"治疗方案",@"治疗药物",@"相关问题"];
    
    NSString *url = [NSString stringWithFormat:FindMdeicDetailURL,_diseaseID];
    
    [LFFTool sendGETWtihURL:url parameters:nil SuccessBlock:^(id responserData) {
        id backData  = [NSJSONSerialization JSONObjectWithData:responserData options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dictInfo = backData[@"info"];
        
        //1
            FindMdeicDetailModel *model1 = [[FindMdeicDetailModel alloc] init];
            model1.summarize = dictInfo[@"summarize"];
            [_dataCellArray1 addObject:model1];
        [_dataarrayCellAllArray addObject:_dataCellArray1];
        
        
        //2
            FindMdeicDetailModel *model2 = [[FindMdeicDetailModel alloc] init];
            model2.treated = dictInfo[@"treated"];
            [_dataCellArray2 addObject:model2];
         [_dataarrayCellAllArray addObject:_dataCellArray2];
        
        
        //3
        for (NSDictionary *dict  in dictInfo[@"treatMedecines"]) {
            FindMdeicDetailModel *model3 = [[FindMdeicDetailModel alloc] init];
            [model3 setValuesForKeysWithDictionary:dict];
            [_dataCellArray3 addObject:model3];
     
        }[_dataarrayCellAllArray addObject:_dataCellArray3];
        
        //4
        for (NSDictionary *dict in dictInfo[@"relateArticle"]) {
            FindMdeicDetailModel *model4 = [[FindMdeicDetailModel alloc] init];
            [model4 setValuesForKeysWithDictionary:dict];
             model4.ID = dict[@"id"];
            [_dataCellArray4 addObject:model4];
            
        }[_dataarrayCellAllArray addObject:_dataCellArray4];
        
        
        //构建section数据源
        for (int i = 0 ; i<_dataUIArray.count; i++) {
            NSMutableDictionary *dictNS = [NSMutableDictionary dictionary];
            //构建cell总数据源
            [dictNS setObject:_dataarrayCellAllArray forKey:kDataArray];
            [dictNS setObject:@(NO) forKey:kIsExpand];
            
            //构建section数据源
            [_dataArray addObject:dictNS];
        }
        
        [_tableView reloadData];
        
    } ErrorBlock:^(NSError *error) {
        
    }];

}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = LFFBGColor;
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableView代理方法集合
#pragma mark 返回section 组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataarrayCellAllArray.count;
    
}
#pragma mark 根据section返回cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *dict = _dataArray[section];
    NSMutableArray *arr = dict[kDataArray];
    NSMutableArray *arrCell = arr[section];
    BOOL isExpand = [dict[kIsExpand] boolValue];
    
    if (isExpand) {
        return arrCell.count;
    }else
        return 0;
    
}
#pragma mark 填充cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FindMdeicDetailViewCell *cell = [FindMdeicDetailViewCell cellWithTableview:tableView WithNum:indexPath];

    if (indexPath.section == 0) {
        [cell setModel:_dataCellArray1[indexPath.row] WithNum:indexPath];
        return cell;
    }if (indexPath.section == 1) {
        [cell setModel:_dataCellArray2[indexPath.row] WithNum:indexPath];
        return cell;
    }if (indexPath.section == 2) {
        [cell setModel:_dataCellArray3[indexPath.row] WithNum:indexPath];
        return cell;
    }if (indexPath.section == 3) {
        [cell setModel:_dataCellArray4[indexPath.row] WithNum:indexPath];
        return cell;
    }else
        return nil;

}
#pragma mark 返回cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 0 == [_dataCellArray1[indexPath.row] cellHeight1]?44:[_dataCellArray1[indexPath.row] cellHeight1];
        
    }if (indexPath.section == 1) {
        return 0 == [_dataCellArray2[indexPath.row] cellHeight2]?44:[_dataCellArray2[indexPath.row] cellHeight2];
        
    }if (indexPath.section == 2) {
        return 110;
    }if (indexPath.section == 3) {
        return 25;
    }else
    
    
    return 0;
    
}

#pragma mark 自定义section
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 35)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *titleLab = [LFFView createLabWithFrame:CGRectMake(20, 0, LFFScreenW*2/3.0, 35) color:[UIColor blackColor] font:LFFFont(15) text:_dataUIArray[section]];
    [view addSubview:titleLab];
    
    UIButton *imagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imagBtn.frame = CGRectMake(LFFScreenW-LFFScreenW/10, (35-16)/2, 16, 16);
    [imagBtn setBackgroundImage:LFFImage(@"presentAll@2x") forState:UIControlStateNormal];
    [imagBtn setBackgroundImage:LFFImage(@"upArrow@2x") forState:UIControlStateSelected];
    
    imagBtn.selected = _isExpand; //给按钮 赋值 =>选中状态
    
    [view addSubview:imagBtn];

    UIButton *bgBtn = [LFFView createBtnWithFrame:CGRectMake(0, 0, LFFScreenW, 35) imageName:nil text:nil target:self sel:@selector(changeExpand:) textFont:nil textColor:[UIColor clearColor]];
    bgBtn.tag = section+100;
    [view addSubview:bgBtn];
    
    return view;
  
}
#pragma mark 返回组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

#pragma mark 点击cell进入详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        ProductDetailViewController *productDet = [[ProductDetailViewController alloc] init];
        productDet.productCode = [_dataCellArray3[indexPath.row] productCode];
        productDet.productName = [_dataCellArray3[indexPath.row] productName];
        
        [self.navigationController pushViewController:productDet animated:YES];
        
    }
}

//改变展开的section 状态
-(void)changeExpand:(UIButton*)sender
{
    NSInteger section = sender.tag -100;
    
    NSMutableDictionary *dict = _dataArray[section];
    
    BOOL isExpand = [dict[kIsExpand] boolValue];
    _isExpand = isExpand;
  
    [dict setObject:@(!isExpand) forKey:kIsExpand];

    //刷新Tableview
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
       sender.selected = !_isExpand; //点击一次  改变按钮的选中状态!
  
}



@end
