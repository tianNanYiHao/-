////
////  AllCategroyRightView.m
////  健客
////
////  Created by qianfeng on 15/10/16.
////  Copyright (c) 2015年 qianfeng. All rights reserved.
////
//
//#import "AllCategroyRightView.h"
//
//#import "AllCategroyModel.h"
//#import "AllCategroyRightCell.h"
//
//#import "SubCategroyViewController.h"
//
//@interface AllCategroyRightView ()<UITableViewDataSource,UITableViewDelegate>
//{
//    UITableView *_tabeleView;
//    NSMutableArray *_dataArray;
//    
//    AllCategroyModel *_model;
//  
//}
//@end
//@implementation AllCategroyRightView
//
//
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        
//    }return self;
//}
//
//-(void)addSubviews
//{  
//    _tabeleView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 0, LFFScreenW*2/3, LFFScreenH-64) style:UITableViewStylePlain];
//    _tabeleView.delegate = self;
//    _tabeleView.dataSource = self;
//    [self addSubview:_tabeleView];
//    
//
//    _tabeleView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//}
//
//-(void)initData
//{
//    
//    _dataArray = [NSMutableArray arrayWithCapacity:0];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProductType.plist" ofType:nil];
//    NSArray *arr2 = [NSArray arrayWithContentsOfFile:path];
//
//    for (int i = 0; i<8; i++) {
//        NSString *str = arr2[i][@"CategoryName"];
//        if ([str isEqualToString:_CategoryName]) {
//            for (NSDictionary *dict in arr2[i][@"symptomName"]) {
//                _model = [[AllCategroyModel alloc] init];
//                [_model setValuesForKeysWithDictionary:dict];
//                [_dataArray addObject:_model];
//            
//            }
//        }
//    }
//}
//
//#pragma mark - Tabelview代理方法
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return _dataArray.count;
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    AllCategroyRightCell *cell = [AllCategroyRightCell cellWithTabelview:tableView];
//    cell.model = _dataArray[indexPath.row];
//    
//    return cell;
//    
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    LFFLog(@"%@--%@",[_dataArray[indexPath.row] itemID],[_dataArray[indexPath.row] itemName]);
// 
//    
//    
//    
//    
//    
//    
//    
//}
//
//@end
