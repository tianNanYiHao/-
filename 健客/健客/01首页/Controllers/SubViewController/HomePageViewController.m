//
//  HomePageViewController.m
//  健客
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomaPageModel.h"
#import "HomePageView.h"

#import "MassageBoxViewController.h"
#import "FindMdeicViewController.h"
#import "AdverView.h"

#import "HomeAdverWebViewController.h"
#import "ProductDetailViewController.h"
#import "SearchViewController.h"

@interface HomePageViewController ()<UITableViewDelegate,AdverViewDelegate>
{
    HomePageView *_homePageView;
    HomaPageModel *_homePageModel;
    
    HomaPageModel *_wotrhToBuyModel; //药划算 model
    
    
    
    

    
    UITableView *_tableView;
    
    
    UIView *_bgview;
  
    

}
@property (nonatomic,strong)NSMutableArray *dataArray1; //广告滚动页数据
@property (nonatomic,strong)NSMutableArray *dataArray2; //值得买数据
@property (nonatomic,strong)NSMutableArray *dataArray3; //可能帮到你数据
@property (nonatomic,strong)NSMutableArray *dataArray4; //两性健康数据
@property (nonatomic,strong)NSMutableArray *dataArray5; //中西医药数据
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加消息通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump3:) name:JUMP3 object:nil];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; //关闭导航栏自动调整 保证切换页面位置正常
    
    [self createBarButtonItem];
    
    [self checkNetWork];
    
    //检测网络之后 请求网络数据
    [self loadDataWit];
    
    //初始化数据数组
    _dataArray1 = [NSMutableArray arrayWithCapacity:0];
    _dataArray2 = [NSMutableArray arrayWithCapacity:0];
    _dataArray3 = [NSMutableArray arrayWithCapacity:0];
    _dataArray4 = [NSMutableArray arrayWithCapacity:0];
    _dataArray5 = [NSMutableArray arrayWithCapacity:0];
    
    
}


#pragma mark - 创建导航栏项
-(void)createBarButtonItem
{
    UIBarButtonItem *leftItme = [LFFTool createButtonItemStal:UIBarButtonSystemItemOrganize target:self action:@selector(newsBox:) color:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItme;
    
    UIBarButtonItem *rightItem =[LFFTool createButtonItemStal:UIBarButtonSystemItemCamera target:self action:@selector(cameraSao:) color:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    UIImageView *searchBar = [[UIImageView alloc]init];
    searchBar.image = LFFImage(@"searchCash@2x");
    searchBar.frame = CGRectMake(0, 0, 423/2, 59/2);
    searchBar.userInteractionEnabled = YES;
    searchBar.layer.cornerRadius = 3.0f;
    searchBar.layer.masksToBounds = YES;
    
    //搜索图标
    UIImageView *search = [[UIImageView alloc] init];
    search.image = LFFImage(@"searchIcon@2x");
    search.frame = CGRectMake(0, 0, 32/2, 33/2);
    search.center = CGPointMake(searchBar.width/2, searchBar.height/2);
    [searchBar addSubview:search];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"健客网";
    title.textColor = [UIColor lightGrayColor];
    title.frame = CGRectMake(search.maxX+5,search.y, 100, 33/2);
    title.font = LFFFont(14.0f);
    [searchBar addSubview:title];
    self.navigationItem.titleView = searchBar;
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchJump:)];
    [searchBar addGestureRecognizer:tap];
}
#pragma mark - 检测网络
-(void)checkNetWork
{
    //网络检测
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring]; //开始检测屏幕
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [LFFTool setObject:YES forkey:@"isNetWork"];
                [self notiUserNetWrok:@"未知网络"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [LFFTool setObject:NO forkey:@"isNetWork"];
                [self notiUserNetWrok:@"未连接"];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [LFFTool setObject:YES forkey:@"isNetWork"];
                [self notiUserNetWrok:@"数据流量"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [LFFTool setObject:YES forkey:@"isNetWork"];
                [self notiUserNetWrok:@"WIFI"];
                break;
                
            default:
                break;
        }
    }];
}
#pragma mark 提示用户网络状态
-(void)notiUserNetWrok:(NSString*)str
{
    //获取系统版本号
    CGFloat deviseVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (deviseVersion >=8) {
        UIAlertController *alerc = [UIAlertController alertControllerWithTitle:@"提示(1)" message:[NSString stringWithFormat:@"您当前网络状态为:%@",str] preferredStyle:UIAlertControllerStyleAlert];
        
        [alerc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            LFFLog(@"确定");
        }]];
        [self presentViewController:alerc animated:YES completion:nil];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示(2)" message:[NSString stringWithFormat:@"您当前网络状态为:%@",str] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }

}
#pragma mark - 请求网络数据
-(void)loadDataWit
{
    [LFFView showHUDWithText:@"正在读取..." toView:self.view];
    
    LFFLog(@"刷新数据");
    [LFFTool sendGETWtihURL:HomePage parameters:nil SuccessBlock:^(id responserData) {
        [LFFView hiddenHUDWithText:nil toView:self.view];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
        id data = [NSJSONSerialization JSONObjectWithData:responserData options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dict = data[@"info"];
    
        [_dataArray1 removeAllObjects];
        [_dataArray2 removeAllObjects];
        [_dataArray3 removeAllObjects];
        [_dataArray4 removeAllObjects];
        [_dataArray5 removeAllObjects];
        
        //广告页模型添加
        NSArray *adverArr = dict[@"advertiseList"];
        for (NSDictionary *dict1 in adverArr) {
            _homePageModel = [[HomaPageModel alloc] init];
            [_homePageModel setValuesForKeysWithDictionary:dict1];
            [_dataArray1 addObject:_homePageModel];
            LFFLog(@"%@+++",_homePageModel.head_img);
        }
    
        //值得买模型添加
        NSArray *wothBuyArr = dict[@"worthBuyImageList"];
        for (NSDictionary *dict2 in wothBuyArr) {
            _homePageModel = [[HomaPageModel alloc] init];
            [_homePageModel setValuesForKeysWithDictionary:dict2];
            [_dataArray2 addObject:_homePageModel];
            LFFLog(@"%@---",_homePageModel.img_url);
        }
        
        //可能帮助你模型添加
        NSArray *couleHelpArr = dict[@"couldHelpYouList"];
        for (NSDictionary *dict3 in couleHelpArr) {
            _homePageModel = [[HomaPageModel alloc] init];
            [_homePageModel setValuesForKeysWithDictionary:dict3];
            [_dataArray3 addObject:_homePageModel];
            LFFLog(@"%@****",_homePageModel.productImageUrl);
        }
  
        //两性健康模型添加
        NSArray *sexHealthArr = dict[@"sexualHealthList"];
        for (NSDictionary *dict4 in sexHealthArr) {
            _homePageModel = [[HomaPageModel alloc] init];
            [_homePageModel setValuesForKeysWithDictionary:dict4];
            LFFLog(@"%@&&&&",_homePageModel.productName);
            [_dataArray4 addObject:_homePageModel];
            
        }
        //中西医药模型添加
        NSArray *chineseWestMedArr = dict[@"chinaWesternMedicineList"];
        for (NSDictionary *dict5 in chineseWestMedArr) {
            _homePageModel = [[HomaPageModel alloc] init];
            [_homePageModel setValuesForKeysWithDictionary:dict5];
            [_dataArray5 addObject:_homePageModel];
            LFFLog(@"%@####",_homePageModel.productName);
        }
        
        //六大按钮 - (药划算Model)
        NSDictionary *dictWorthToBuy = dict[@"menuNavigationUrl"];
        _wotrhToBuyModel = [[HomaPageModel alloc] init];
        _wotrhToBuyModel.worthBuyingUrl = dictWorthToBuy[@"worthBuyingUrl"];
    
        
        //请求网络数据之后,开始创建界面(由于是Block回调 所以创建界面要写在回调里)
        [self createHomaPageView];
        
    } ErrorBlock:^(NSError *error) {
        [LFFView hiddenHUDWithText:nil toView:self.view];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    }];
    
}
#pragma mark 消息盒子按钮
-(void)newsBox:(UIBarButtonItem*)sender
{

    MassageBoxViewController *massageBox = [[MassageBoxViewController alloc]init];
    massageBox.index = 1;
    massageBox.titleName = @"消息盒子";
    
    massageBox.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:massageBox animated:YES];
}

#pragma mark 搜索手势
-(void)searchJump:(UITapGestureRecognizer*)tap
{
    LFFLog(@"search");
    SearchViewController *sarch = [[SearchViewController alloc] init];
    
    CATransition *anima = [CATransition animation];
    anima.type = @"push";
    anima.subtype = kCATransitionFromRight;
    
    sarch.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sarch animated:NO];
    [self.navigationController.view.layer addAnimation:anima forKey:nil];
    
}
#pragma mark 扫描二维码
-(void)cameraSao:(UIBarButtonItem*)sender
{
    LFFLog(@"扫一扫");
  
}

#pragma mark - 创建首页view
-(void)createHomaPageView
{
    //1创建广告页!
    //创建tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64-49)];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //消除tabView的分隔线
    
    //通过数组创建首页 (广告页)
    _homePageView = [HomePageView homePageWithFrame:CGRectMake(0,0, LFFScreenW, LFFScreenH-64-49) array:_dataArray1];
    
    //获取按钮
    for (int i=0; i<_homePageView.adverBtnArr.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn = _homePageView.adverBtnArr[i];
        [btn addTarget:self action:@selector(adverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    //设置广告轮播页代理
    _homePageView.adverViewDele.delegate = self;
    [_tableView addSubview:_homePageView];
    

    //2创建值得买
    [_homePageView wothBuyWithArray:_dataArray2];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHomeAdverWebViewController1:)];
    [_homePageView.leftImg addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHomeAdverWebViewController2:)];
    [_homePageView.rightUpImg addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHomeAdverWebViewController3:)];
    [_homePageView.rightDownImg addGestureRecognizer:tap3];
    
    
    
    
    
     //3创建可能帮助你
    [_homePageView couldhelpWithArray:_dataArray3];
    
    for (int i = 0; i<_homePageView.couleHelpArr.count; i++) {
        UIButton *btn = _homePageView.couleHelpArr[i];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(btnClickCouldHele:) forControlEvents:UIControlEventTouchUpInside];
 
    }

    //4创建两性健康
    [_homePageView sexualHealthWithArray:_dataArray4];
    UITapGestureRecognizer *tapSex1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSex1:)];
    [_homePageView.leftImg1 addGestureRecognizer:tapSex1];
    UITapGestureRecognizer *tapSex2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSex2:)];
    [_homePageView.rightUpImg1 addGestureRecognizer:tapSex2];
    UITapGestureRecognizer *tapSex3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSex3:)];
    [_homePageView.rightDownImg1 addGestureRecognizer:tapSex3];
        

    //5创建中西医药
    [_homePageView chinaWesternMedicineWithArray:_dataArray5];
    for (int i = 0; i<_homePageView.eastWestArr.count; i++) {
        UIButton *btnEastWest = _homePageView.eastWestArr[i];
        btnEastWest.tag = [[_dataArray5[i] productCode] floatValue];
        [btnEastWest addTarget:self action:@selector(eastWestClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    

    //明杰新刷新方法!! (不用代理)
    MJChiBaoZiHeader *heard = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefresh:)];
    _tableView.header = heard;
    
    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerfresh:)];
    _tableView.footer = footer;
    
    
    
}
#pragma mark - 广告页六大按钮 点击方法
-(void)adverBtnClick:(UIButton*)sender
{
    if ([sender.currentTitle isEqualToString:@"全部分类"]) {
        LFFLog(@"全部分类");
        MassageBoxViewController * allCategray = [[MassageBoxViewController alloc]init];
        allCategray.index = 2;
        allCategray.titleName = @"全部分类";
        allCategray.hidesBottomBarWhenPushed = YES;
      [self.navigationController pushViewController:allCategray animated:YES];
    }
    if ([sender.currentTitle isEqualToString:@"对症找药"]) {
        LFFLog(@"对症找药");
        FindMdeicViewController *findMedicne = [[FindMdeicViewController alloc] init];
        findMedicne.titleName = @"对症找药";
        findMedicne.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:findMedicne animated:YES];
    }
    if ([sender.currentTitle isEqualToString:@"药划算"]) {
        LFFLog(@"药划算");
        HomeAdverWebViewController *homeADWebViewC = [[HomeAdverWebViewController alloc] init];
        homeADWebViewC.url = _wotrhToBuyModel.worthBuyingUrl;
        homeADWebViewC.titleName = sender.currentTitle;
        
        homeADWebViewC.hidesBottomBarWhenPushed = YES ; //因为在四个tabBar的item 上 所以有tabBar 可以做隐藏
        [self.navigationController pushViewController:homeADWebViewC animated:YES];

    }
    if ([sender.currentTitle isEqualToString:@"用药咨询"]) {
        LFFLog(@"用药咨询");
    }
    if ([sender.currentTitle isEqualToString:@"摇积分"]) {
        LFFLog(@"摇积分");
        
    }
    if ([sender.currentTitle isEqualToString:@"我的物流"]) {
        LFFLog(@"我的物流");
    }
}



#pragma mark - 上/下拉刷新方法实现
#pragma mark 下拉刷新
-(void)headrefresh:(MJChiBaoZiHeader*)header
{
    [self loadDataWit];

}

#pragma mark 上啦刷新
-(void)footerfresh:(MJChiBaoZiFooter*)footer
{
    [self loadDataWit];
}


#pragma mark - 消息通知中心方法实现
-(void)jump3:(NSNotification*)noti
{

//    //开始遍历 (通过tag值 开始判断)
//    for (UIView *view in self.tabBarController.tabBar.subviews) {
//        //找到_bgView
//        if (view.tag == 200) {
//            for (UIView *view2 in view.subviews) {
//                if (view2.tag == 101) {
//                    UIButton *btn = (UIButton*)view2;
//                    btn.selected = YES;   //只有这样,才能遍历出btn 开启首页tabBar按钮的选中状态
//                }
//                if (view2.tag == 100) {
//                    UIButton *btn = (UIButton*)view2;
//                    btn.selected = NO;   //关闭 购物车tabBar按钮的选中状态
//                }
//            }
//        }
//    }

    self.tabBarController.selectedIndex = 3;
}

#pragma mark - HomePage页的代理方法集合
#pragma mark 广告滚动页点击的代理方法
-(void)sentAdverView:(AdverView *)view withUrl:(NSString *)url
{
    HomeAdverWebViewController *homeADWebViewC = [[HomeAdverWebViewController alloc] init];
    homeADWebViewC.url = url;
    
    //解析html文件 获取网页标题
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    TFHpple *xpath = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elemetns = [xpath searchWithXPathQuery:@"//title"];

    for (TFHppleElement *titleElement in elemetns) {
        LFFLog(@"()()()()()()%@",titleElement.raw);
        LFFLog(@"()()()()()()%@",titleElement.text);
        //2 传递title
        homeADWebViewC.titleName = titleElement.text;
    }
    
    
    homeADWebViewC.hidesBottomBarWhenPushed = YES ; //因为在四个tabBar的item 上 所以有tabBar 可以做隐藏
    [self.navigationController pushViewController:homeADWebViewC animated:YES];
    
}
#pragma mark - 值得买轻按点击
-(void)tapToHomeAdverWebViewController1:(UITapGestureRecognizer*)tap
{
    HomeAdverWebViewController *homeWebVc = [[HomeAdverWebViewController alloc] init];
    homeWebVc.url = [_dataArray2[0] jump_url];
    
    homeWebVc.titleName = [LFFTool getTitleWithURL:homeWebVc.url withString:@"//title"];

    homeWebVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeWebVc animated:YES];
}
-(void)tapToHomeAdverWebViewController2:(UITapGestureRecognizer*)tap
{
    HomeAdverWebViewController *homeWebVc = [[HomeAdverWebViewController alloc] init];
    homeWebVc.url = [_dataArray2[1] jump_url];
    homeWebVc.titleName = [LFFTool getTitleWithURL:homeWebVc.url withString:@"//title"];
    
    homeWebVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeWebVc animated:YES];
}
-(void)tapToHomeAdverWebViewController3:(UITapGestureRecognizer*)tap
{
    HomeAdverWebViewController *homeWebVc = [[HomeAdverWebViewController alloc] init];

    homeWebVc.url = [_dataArray2[2] jump_url];
    homeWebVc.titleName = [LFFTool getTitleWithURL:homeWebVc.url withString:@"//title"];
    homeWebVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeWebVc animated:YES];
}

#pragma mark - 可能帮到你点击
-(void)btnClickCouldHele:(UIButton*)btn
{

    ProductDetailViewController *proVC = [[ProductDetailViewController alloc] init];
    proVC.productCode = [_dataArray3[btn.tag-1] productCode];
    
    proVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:proVC animated:YES];
}
#pragma mark - 两性健康点击
-(void)tapSex1:(UITapGestureRecognizer*)tapSex1
{
    ProductDetailViewController *proSex1 = [[ProductDetailViewController alloc] init];
    proSex1.productCode = [_dataArray4[0] productCode];
    [self.navigationController pushViewController:proSex1 animated:YES];
    
}
-(void)tapSex2:(UITapGestureRecognizer*)tapSex2
{
    ProductDetailViewController *proSex2 = [[ProductDetailViewController alloc] init];
    proSex2.productCode = [_dataArray4[1] productCode];
    [self.navigationController pushViewController:proSex2 animated:YES];
}

-(void)tapSex3:(UITapGestureRecognizer*)tapSex3
{
    ProductDetailViewController *proSex3 = [[ProductDetailViewController alloc] init];
    proSex3.productCode = [_dataArray4[2] productCode];
    [self.navigationController pushViewController:proSex3 animated:YES];
}
#pragma mark - 中西医药按钮点击bnt
-(void)eastWestClick:(UIButton*)btn
{
    LFFLog(@"11111");
    ProductDetailViewController *proEast = [[ProductDetailViewController alloc] init];
    proEast.productCode = [NSString stringWithFormat:@"%ld",btn.tag];
    
    proEast.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:proEast animated:YES];

}


@end
