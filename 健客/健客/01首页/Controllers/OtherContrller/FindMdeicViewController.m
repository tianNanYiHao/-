//
//  FindMdeicViewController.m
//  健客
//
//  Created by qianfeng on 15/10/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//创建页面 写两个v 一个是section的View 一个是cell 的Tableviewcell

#import "FindMdeicViewController.h"

#import "FindMdeicModel.h"
#import "FindMdeicView.h"
#import "FindMdeicVIewCell.h"

#import "FindMdeicDetailViewController.h"

//代表当前section是否是展开
#define kIsExpand @"isExpand"
//当前section对应的数组
#define kDataArray @"dataArray"




@interface FindMdeicViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray3; //界面数据源
    
    NSMutableArray *_dataAllArray3; //section数据源 装载2个字典
    NSMutableArray *_dataCellArray3; //cell数据源 创建cell
    
    
    UITableView *_tableview;
    
    //标识当前展开的section
//    NSInteger _expandSection;

}
@end

@implementation FindMdeicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //调用父类的方法 创建导航条按钮
    [self createBarButtonItem];
    
    self.view.backgroundColor = LFFBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = _titleName;
    
    [self createData]; //创建数据源
    
    [self createUIVIew]; //创建tableView
}
//构建本地数据
-(void)createData
{
    //3.
    _dataArray3 = [NSMutableArray array];
    _dataAllArray3 = [NSMutableArray array];
    _dataCellArray3 = [NSMutableArray array];
    
    NSArray *title3 = @[@"心血管疾病",@"消化系统疾病",@"神经系统疾病",@"妇产科疾病",@"呼吸系统疾病",@"内分泌疾病",@"感染疾病",@"泌尿生殖系统疾病",@"血液病",@"风湿免疫病",@"肿瘤",@"代谢疾病",@"口腔疾病",@"眼疾病",@"骨科疾病",@"耳鼻喉疾病",@"皮肤病",@"性病",@"男科性病",@"儿科疾病"];
    
    NSArray *introduce3 = @[@"心绞痛-心肌梗塞-心塞-心率失常",@"胃十二指肠溃疡-胃炎-肝炎",@"失眠-脑梗-脑出血",@"月经不调-痛经-妇科疾病",@"感冒-气管炎-肺炎",@"糖尿病-甲亢",@"感冒-水痘-肝炎",@"肾病-尿路感染",@"白血病-淋巴瘤",@"类风湿-干燥综合征-红斑狼疮",@"肿瘤-胃癌-乳腺癌",@"高血脂症-糖尿病",@"龉齿-牙周炎-口腔溃疡",@"近视-青光眼-白内障",@"颈椎病-肩周炎-骨折",@"中耳炎-鼻窦炎-扁桃体炎",@"皮炎-湿疹-痤疮",@"梅毒-淋病-前列腺炎",@"阳痿早泄-不育-前列腺炎",@"新生黄疸-小儿哮喘-流行性腮腺炎"];
    NSArray *imageName3 = @[@"heartDisease@2x",@"digestionDisease@2x",@"nervousDisease@2x",@"gynaecologyDisease@2x",@"breatheDisease@2x",@"secretionDisease@2x",@"infectionDisease@2x",@"urogenitalDisease@2x",@"bloodDisease@2x",@"rheumatismDisease@2x",@"tumourDisease@2x",@"metabolicDisease@2x",@"mouthDisease@2x",@"eyeDisease@2x",@"orthopaedicsDisease@2x",@"ENTDisease@2x",@"skinDisease@2x",@"sexDisease@2x",@"maleSexDisease@2x",@"childDisease@2x"];
    
    
    //创建section数据源!!!
    for (int i = 0; i<20; i++) {
        FindMdeicModel *model = [[FindMdeicModel alloc] init];
        model.mdeicTitleName = title3[i];
        model.mdeicDetail = introduce3[i];
        model.mdeicImaName = imageName3[i];

        [_dataArray3 addObject:model];
    }
    
   //创建cell数据源 通知 以字典方式保存 折叠  cell
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DiseaseTypes.plist" ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    for (int i =0; i<arr.count; i++) {
        NSMutableArray *arrayAllNum = [NSMutableArray array];//创建20个数组,分别装载每个section下的cell!!!
        
        NSMutableDictionary *dictNs = [NSMutableDictionary dictionary]; //创建20个字典,来保存!
        NSArray *diseaseNameArr = arr[i][@"diseaseName"];  //循环取出20个数组!!
        
            for (NSDictionary *dict in diseaseNameArr) {
                FindMdeicModel *model = [[FindMdeicModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [arrayAllNum addObject:model];
        }
        
        [_dataCellArray3 addObject:arrayAllNum]; //20个数组 每个数组 都装各自cell
        
        //键值对保存!!!
        [dictNs setObject:_dataCellArray3 forKey:kDataArray];
        [dictNs setObject:@(NO) forKey:kIsExpand];
        
        
        [_dataAllArray3 addObject:dictNs]; //section数据源 保存字典

    }
    [_tableview reloadData];
    
}


-(void)createUIVIew
{
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.rowHeight = [FindMdeicViewCell cellHeight];
        _tableview.separatorStyle = UITableViewCellSelectionStyleNone; //设置分离样式 cell没有分离线 效果
    
        [self.view addSubview:_tableview];
    
   }
#pragma mark - tableView 代理

#pragma mark 返回section的个数 (组数)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataAllArray3.count;
}

#pragma mark 返回section对应cell个数 (行数)
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *dict = _dataAllArray3[section];
    NSMutableArray *array  = dict[kDataArray]; //取得section对应的真正数据源
    
    NSMutableArray *arrayNum = array[section]; //根据每个section 取出cell数组!!
    
    BOOL isExtend = [dict[kIsExpand] boolValue];
    if (isExtend) {
        return arrayNum.count;
    }else
        return 0;
 
}
#pragma mark 填充cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FindMdeicViewCell *cell = [FindMdeicViewCell cellWithTableView:tableView];
    NSDictionary *dict = _dataAllArray3[indexPath.section];
    NSArray *array = dict[kDataArray];
    NSArray *arrayNum = array[indexPath.section];
    
    if (indexPath.row == 1) {
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 35)];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 35)];
        img.image = [UIImage imageNamed:@"menuFristBackView@2x"];
        [view addSubview:img];
        cell.backgroundView = view;
    }
    cell.model = arrayNum[indexPath.row];
    
    return cell;
  
}
#pragma mark 返回section的高度 (返回组头的高度)
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CELLHeight;
}


#pragma mark 自定义section (重要点!!!)
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    FindMdeicView *view = [FindMdeicView sectionViewWithFrame:CGRectMake(0, 0, LFFScreenW, CELLHeight) iamgeName:[_dataArray3[section] mdeicImaName] titleName:[_dataArray3[section] mdeicTitleName] mdeicDetail:[_dataArray3[section] mdeicDetail]];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, CELLHeight)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(changeExpandSection:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 100+section;
    
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, btn.maxY-1, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [view addSubview:lineH];
    
    [view addSubview:btn];

    return view;
}

//改变展开的section
-(void)changeExpandSection:(UIButton*)sender
{
    NSInteger section = sender.tag -100;
    NSMutableDictionary *dict = _dataAllArray3[section];
    
    BOOL isExtend = [dict[kIsExpand] boolValue];
    
    [dict setObject:@(!isExtend) forKey:kIsExpand]; //保存开合状态!
    

    //根据section变化 刷新动画!!
    [_tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
  
}

#pragma mark 点击cell的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr =   _dataCellArray3[indexPath.section];
    NSString *str = [arr[indexPath.row] name];
    NSString *strID = [arr[indexPath.row] diseaseID];
    LFFLog(@"%@:ID->%@",str,strID);
    
    
    FindMdeicDetailViewController *finDetailVc = [[FindMdeicDetailViewController alloc] init];
    finDetailVc.nameTitle = str;
    finDetailVc.diseaseID = strID;
    
    CATransition *anima = [CATransition animation];
    anima.type = @"push";
    anima.subtype = kCATransitionFromTop;
    
    [self.navigationController pushViewController:finDetailVc animated:NO];
    [self.navigationController.view.layer addAnimation:anima forKey:nil];
        
}



@end
