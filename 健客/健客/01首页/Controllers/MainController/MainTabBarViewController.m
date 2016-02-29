//
//  MainTabBarViewController.m
//  健客
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomePageViewController.h"
#import "MedicationRemindViewController.h"
#import "PersonalCenterViewController.h"
#import "ShoppingCarViewController.h"

#import "MainNavgationController.h"


@interface MainTabBarViewController ()
{
    UIImageView *_bgView; //自定义tabBar底色
    
}
@end

@implementation MainTabBarViewController

#pragma mark - 加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //1**1.自定义TabBar 首先不隐藏self.tabBar ,因为后面需要在self.tabBar上添加自定义的tabBar;
    self.tabBar.hidden = NO;
    
    self.view.backgroundColor = LFFBGColor;
    
    [self createUITabBarContrller];
    [self createTabBArView];

   
}
#pragma mark - 自定义tabBar
-(void)createTabBArView
{
    //2**2遍历tabBar子类. 首先删除所有子类 然后下一步
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    
    //3**3 这里是下一步 在空的self.tabBar上 ,创建自定义的tabBar  这样就完成了自定义tabBar
    _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, 49)];
    _bgView.backgroundColor = [[UIColor alloc]initWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1.0];

    [self.tabBar addSubview:_bgView];  //往self.tabBar 上添加自定义的tabBar
    _bgView.userInteractionEnabled = YES;
    _bgView.tag = 200;
    
    NSArray *nomalPic = @[@"shouye_inactive@2x",@"yongyaotixing_inactive@2x",@"gerenzhongxin_inactive@2x",@"gouwuche_inactive@2x"];
    NSArray *selectPic = @[@"shouye_active@2x",@"yongyaotixing_active@2x",@"gerenzhongxin_active@2x",@"gouwuche_active@2x"];
    
    CGFloat kMagin = (LFFScreenW-39*4)/5;
    
    for (int i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kMagin+(kMagin+39)*i, 0, 39, 49);
        [btn addTarget:self action:@selector(btnClock:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i +100;
        UIImage *nomaImg = LFFImageSelect(nomalPic[i]);
        UIImage *selectImg = LFFImageSelect(selectPic[i]);
        [btn setBackgroundImage:nomaImg forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        
        if (i == 0) {
            btn.selected = YES;
        }
        [_bgView addSubview:btn];
    }
}
#pragma mark 按钮方法(切换页面)
-(void)btnClock:(UIButton*)sender
{
    
    //找到下表
    NSUInteger index = sender.tag-100;
    self.selectedIndex=index; //UITabBarController自带selecedIndex属性,用于标记barItem

    for (UIButton *btn in _bgView.subviews) {
            if (btn.tag == sender.tag) {
                btn.selected = YES;
            }else
            {
                btn.selected = NO;
            }
    }
}

#pragma mark - 添加tabBar子控制器
-(void)createUITabBarContrller
{
    HomePageViewController * homePageVc = [[HomePageViewController alloc] init];
    MainNavgationController *homePageNav = [[MainNavgationController alloc]initWithRootViewController:homePageVc];
    
    MedicationRemindViewController *medicVc = [[MedicationRemindViewController alloc] init];
    MainNavgationController *medicNav = [[MainNavgationController alloc] initWithRootViewController:medicVc];
    
    PersonalCenterViewController *personVc = [[PersonalCenterViewController alloc] init];
    MainNavgationController *personNav = [[MainNavgationController alloc] initWithRootViewController:personVc];
    
    ShoppingCarViewController *shoppingVc = [[ShoppingCarViewController alloc] init];
    MainNavgationController *shoppingNav = [[MainNavgationController alloc]initWithRootViewController:shoppingVc];
 
    self.viewControllers = @[homePageNav,medicNav,personNav,shoppingNav];
}

@end
