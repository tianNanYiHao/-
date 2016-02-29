//
//  SearchViewController.m
//  健客
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "SubCategroyViewController.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_searchBar;
    NSMutableArray *_dataArray;
    
    UITableView *_tableview;
    NSString *_searchStr;   //输入的搜索文字
    int _currentPage;
    
    NSString *_url;
    
    
    
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LFFBGColor;
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    _currentPage = 1;
    [self createBarButtonItem];
    
    [self createBaseTableview];
    
    


}

//重写父类创建导航条方法
-(void)createBarButtonItem
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 15);
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backHomePage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
   
    _searchBar = [[UITextField alloc]init];
    
    _searchBar.font =LFFFont(12);
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(10, 20, (LFFScreenW-20)*8/10.0, 59/2);
    _searchBar.userInteractionEnabled = YES;
    _searchBar.layer.cornerRadius = 3.0f;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.backgroundColor = [UIColor whiteColor];
    UIImageView *search = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    search.image = LFFImage(@"searchIcon@2x");
    _searchBar.leftView = search;
    _searchBar.placeholder = @"请输入查询内容";
    
    [_searchBar addTarget:self action:@selector(keyboardChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.navigationItem.titleView = _searchBar;
    
}

#pragma mark 创建本地tableview
-(void)createBaseTableview
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    
    _tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableview];
  
}


#pragma mark - 请求网络数据

-(void)initData
{

    _searchStr = [_searchStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    LFFLog(@"After ==> %@",_searchStr);
    
    NSString *rul1 = [NSString stringWithFormat:SearchURL1,_searchStr];
    
    [LFFView showHUDWithText:@"正在搜索..." toView:self.view];
    
    [_dataArray removeAllObjects];
    [LFFTool sendGETWtihURL:rul1 parameters:nil SuccessBlock:^(id responserData) {
        [LFFView hiddenHUDWithText:nil toView:self.view];
        id baceDate = [NSJSONSerialization JSONObjectWithData:responserData options:NSJSONReadingMutableLeaves error:nil];
        LFFLog(@"%@",baceDate);
        NSArray *dictArr = baceDate[@"info"];
        for (NSDictionary *dict in dictArr) {
            NSString *strResult = dict[@"searchResult"];
            [_dataArray addObject:strResult];
        }
        [_tableview reloadData];
    } ErrorBlock:^(NSError *error) {
        [LFFView hiddenHUDWithText:nil toView:self.view];
        
    }];

    
}
#pragma mark - tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
static NSString *ID = @"id";
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSString *str = _dataArray[indexPath.row];
    
    cell.textLabel.text = str;
    
    return cell;
}

#pragma mark 点击cell进入
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];
    
    SubCategroyViewController *subCC = [[SubCategroyViewController alloc] init];
    subCC.urlStr = _dataArray[indexPath.row] ;
    subCC.isSearh = YES;
    [self.navigationController pushViewController:subCC animated:YES];
    
}


#pragma mark 返回主页
-(void)backHomePage
{
    [_searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 开始编辑 请求数据
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    LFFLog(@"----DidBeginEditing!");
    
}
#pragma mark 监听键盘变化
-(void)keyboardChange:(UITextField*)field
{
    
    LFFLog(@"----DidEndEditing");
    _searchStr = field.text;
    LFFLog(@"Befor == > %@",_searchStr);
    
    [self initData];

}


#pragma mark 结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    

    
    SubCategroyViewController *sub = [[SubCategroyViewController alloc] init];
    sub.urlStr = textField.text;
    sub.isSearh = YES;
    
    [self.navigationController pushViewController:sub animated:YES];
    [textField resignFirstResponder];
    return YES;
}

@end
