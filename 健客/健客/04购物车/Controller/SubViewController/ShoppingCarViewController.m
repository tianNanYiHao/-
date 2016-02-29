//
//  ShoppingCarViewController.m
//  健客
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ShoppingCarViewController.h"

@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加消息通知中心 (执行跳转首页)
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump0) name:JUMP0 object:nil];
    
    
    
    self.view.backgroundColor = [UIColor lightTextColor];
    self.title = @"购物车";
    [self createNotEnterUIview];
    
}
#pragma mark - 创建未登录界面
-(void)createNotEnterUIview
{
    UIView *shoopingCarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64)];
    shoopingCarView.backgroundColor = LFFBGColor;
    shoopingCarView.userInteractionEnabled = YES;
    [self.view addSubview:shoopingCarView];
    
    UIImageView *colorIV = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, 120/2, 130/2) imageName:@"paycart@2x"];
    colorIV.center = CGPointMake(LFFScreenW/2, LFFScreenH/3);
    [shoopingCarView addSubview:colorIV];
    
    UILabel *noticeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, 20)];
    noticeLab.center = CGPointMake(LFFScreenW/2, colorIV.maxY+10);
    noticeLab.font = LFFFont(12);
    noticeLab.textAlignment = NSTextAlignmentCenter;
    noticeLab.textColor = [UIColor blackColor];
    noticeLab.text = @"您的购物车还是空的";
    [shoopingCarView addSubview:noticeLab];
    
    UILabel *noticeLab2 = [LFFView createLabWithFrame:CGRectMake(0, noticeLab.maxY, LFFScreenW, 20) color:[UIColor lightGrayColor] font:LFFFont(10) text:@"选几件必备的东西吧"];
    noticeLab2.textAlignment = NSTextAlignmentCenter;
    [shoopingCarView addSubview:noticeLab2];
    
    
    UIButton *nowAddBtn = [LFFView createBtnWithFrame:CGRectMake(0, 0, LFFScreenW/3, 51/2) imageName:@"blueBtn_short@2x" text:@"去逛逛" target:self sel:@selector(gotoHomePage) textFont:LFFFont(12) textColor:[UIColor whiteColor]];
    nowAddBtn.center = CGPointMake(LFFScreenW/2, noticeLab2.maxY+15);
    [shoopingCarView addSubview:nowAddBtn];
    
    nowAddBtn.tag = 0;

}

#pragma mark - 进入首页(去逛逛)
-(void)gotoHomePage
{
    
    //开始遍历 (通过tag值 开始判断)
    for (UIView *view in self.tabBarController.tabBar.subviews) {
        //找到_bgView
        if (view.tag == 200) {
            
            for (UIView *view2 in view.subviews) {
                if (view2.tag == 100) {
                    UIButton *btn = (UIButton*)view2;
                    btn.selected = YES;   //只有这样,才能遍历出btn 开启首页tabBar按钮的选中状态
                }
                if (view2.tag == 103) {
                    UIButton *btn = (UIButton*)view2;
                    btn.selected = NO;   //关闭 购物车tabBar按钮的选中状态
                }
            }
        }
    }
    self.tabBarController.selectedIndex = 0;
}

#pragma mark - 消息通知中心方法实现



@end
