//
//  MassageBoxViewController.m
//  健客
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MassageBoxViewController.h"
#import "MassageBoxModel.h"
#import "MassageBoxViewCell.h"
#import "MassageBoxLeftVIewControllerViewController.h"
#import "AllCategroyRightView.h"

@interface MassageBoxViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
//    NSMutableArray *_dataArray3;
    
}
@end

@implementation MassageBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //调用父类的方法 创建导航条按钮
    [self createBarButtonItem];
    
    self.view.backgroundColor = LFFBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = _titleName;
    
    [self createData];
    
    [self createUIVIew];
  
}

//构建本地数据
-(void)createData
{
    
    //1.
    _dataArray1 = [NSMutableArray array];
    NSArray *title = @[@"健客活动",@"物流助手",@"健康助手",@"积分",@"系统消息"];
    NSArray *imageName = @[@"information_tark@2x",@"information_logistics@2x",@"information_health@2x",@"information_invegeral@2x",@"information_tips@2x"];
    
    for (int i = 0 ; i<5; i++) {
        MassageBoxModel *model = [[MassageBoxModel alloc]init];
        model.titleName = title[i];
        model.iamgeName = imageName[i];
        [_dataArray1 addObject:model];
    }

    //2/
    _dataArray2 = [NSMutableArray array];
    NSArray *title2 = @[@"常备用药",@"男科用药",@"心脑血管",@"妇科用药",@"儿童用药",@"肝胆胰类",@"皮肤用药",@"泌尿系统"];
    NSArray *imageName2 = @[@"usual@2x",@"male@2x",@"heart@2x",@"female@2x",@"child@2x",@"infectionDisease@2x",@"skin@2x",@"urinary@2x"];
    NSArray *introduce2 = @[@"感冒发热|头疼牙疼|肌肉关节",@"补肾益气|性功能障碍|前列腺炎",@"高血压类|高血脂类|中风偏瘫",@"除湿止带|月经不调|乳腺疾病",@"感冒发热|补钙铁锌|消化不良",@"解酒护肝|乙肝用药|肝炎用药",@"烧伤创伤|皮肤过敏|扁平苔藓",@"尿路感染|尿路结实|肾病综合征|肾炎",];
    
    
    for (int i = 0; i<8; i++) {
        MassageBoxModel *model = [[MassageBoxModel alloc] init];
        model.titleName = title2[i];
        model.iamgeName = imageName2[i];
        model.introduce = introduce2[i];
        [_dataArray2 addObject:model];
    }
    

//    //3.
//    _dataArray3 = [NSMutableArray array];
//    NSArray *title3 = @[@"心血管疾病",@"消化系统疾病",@"神经系统疾病",@"妇产科疾病",@"呼吸系统疾病",@"内分泌疾病",@"感染疾病",@"泌尿生殖系统疾病",@"血液病",@"风湿免疫病",@"肿瘤",@"代谢疾病",@"口腔疾病",@"眼疾病",@"骨科疾病",@"耳鼻喉疾病",@"皮肤病",@"性病",@"男科性病",@"儿科疾病"];
//    
//    NSArray *introduce3 = @[@"心绞痛-心肌梗塞-心塞-心率失常",@"胃十二指肠溃疡-胃炎-肝炎",@"失眠-脑梗-脑出血",@"月经不调-痛经-妇科疾病",@"感冒-气管炎-肺炎",@"糖尿病-甲亢",@"感冒-水痘-肝炎",@"肾病-尿路感染",@"白血病-淋巴瘤",@"类风湿-干燥综合征-红斑狼疮",@"肿瘤-胃癌-乳腺癌",@"高血脂症-糖尿病",@"龉齿-牙周炎-口腔溃疡",@"近视-青光眼-白内障",@"颈椎病-肩周炎-骨折",@"中耳炎-鼻窦炎-扁桃体炎",@"皮炎-湿疹-痤疮",@"梅毒-淋病-前列腺炎",@"阳痿早泄-不育-前列腺炎",@"新生黄疸-小儿哮喘-流行性腮腺炎"];
//    NSArray *imageName3 = @[@"heartDisease@2x",@"digestionDisease@2x",@"nervousDisease@2x",@"gynaecologyDisease@2x",@"breatheDisease@2x",@"secretionDisease@2x",@"infectionDisease@2x",@"urogenitalDisease@2x",@"bloodDisease@2x",@"rheumatismDisease@2x",@"tumourDisease@2x",@"metabolicDisease@2x",@"mouthDisease@2x",@"eyeDisease@2x",@"orthopaedicsDisease@2x",@"ENTDisease@2x",@"skinDisease@2x",@"sexDisease@2x",@"maleSexDisease@2x",@"childDisease@2x"];
//    for (int i = 0; i<20; i++) {
//        MassageBoxModel *model = [[MassageBoxModel alloc] init];
//        model.titleName = title3[i];
//        model.introduce = introduce3[i];
//        model.iamgeName = imageName3[i];
//        [_dataArray3 addObject:model];
//    }
    
    [_tableview reloadData];

}

-(void)createUIVIew
{
//    if (_index == 3) {
//        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64) style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.backgroundColor = [UIColor whiteColor];
//        _tableview.rowHeight = [MassageBoxViewCell cellHeight];
//        
//        [self.view addSubview:_tableview];
//    }
    if (_index == 2) {
        
        UIScrollView *viewBG = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 2*CELLHeight*_dataArray2.count)];
        viewBG.userInteractionEnabled = YES;
        viewBG.contentSize = CGSizeMake(0, viewBG.height);
        viewBG.alwaysBounceVertical = YES;
        
        [self.view addSubview:viewBG];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, LFFScreenW, CELLHeight*_dataArray2.count)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.alwaysBounceVertical = NO;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.rowHeight = [MassageBoxViewCell cellHeight];
        [viewBG addSubview:_tableview];

    
    }
    if (_index == 1) {
        UIScrollView *viewBG = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 2*CELLHeight*_dataArray1.count)];
        viewBG.userInteractionEnabled = YES;
        viewBG.contentSize = CGSizeMake(0, viewBG.height);
        viewBG.alwaysBounceVertical = YES;
        
        [self.view addSubview:viewBG];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, LFFScreenW, CELLHeight*_dataArray1.count)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.alwaysBounceVertical = NO;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.rowHeight = [MassageBoxViewCell cellHeight];
        [viewBG addSubview:_tableview];
    }
  
}
#pragma mark - tableView 代理
#pragma mark 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_index == 3) {
//        return _dataArray3.count;
//    }
    if (_index == 2) {
        return _dataArray2.count;
    }
    return _dataArray1.count;
    
}
#pragma mark 填充cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_index == 3) {
//        MassageBoxViewCell *cell = [MassageBoxViewCell cellWithTableView:tableView withNumber:3];
//        cell.model = _dataArray3[indexPath.row];
//        return cell;
//
//    }
    if (_index == 2) {
        MassageBoxViewCell *cell = [MassageBoxViewCell cellWithTableView:tableView withNumber:2];
        cell.model = _dataArray2[indexPath.row];
        return cell;

    }
    MassageBoxViewCell *cell = [MassageBoxViewCell cellWithTableView:tableView withNumber:1];
        cell.model = _dataArray1[indexPath.row];
    return cell;
    
}
#pragma mark - cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     if (_index == 2) {
        MassageBoxLeftVIewControllerViewController *massageBoxLeftController = [[MassageBoxLeftVIewControllerViewController alloc]init];
         
         massageBoxLeftController.CategoryName = [_dataArray2[indexPath.row] titleName];
         
         [self.navigationController pushViewController:massageBoxLeftController animated:YES];
         
         
     }
}


@end
