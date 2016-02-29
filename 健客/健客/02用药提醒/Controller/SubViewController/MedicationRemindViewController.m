//
//  MedicationRemindViewController.m
//  健客
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MedicationRemindViewController.h"
#import "HomePageViewController.h"
@interface MedicationRemindViewController ()

@end

@implementation MedicationRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加消息通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump1:) name:JUMP1 object:nil];
    
    self.view.backgroundColor = LFFBGColor;
    self.title = @"用药提醒";
    
    [self createNotEnterUIview];
    
}
-(void)createNotEnterUIview
{
    UIView *remaindView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64)];
    remaindView.backgroundColor = LFFBGColor;
    remaindView.userInteractionEnabled = YES;
    [self.view addSubview:remaindView];
    
    UIImageView *colorIV = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, 120/2, 130/2) imageName:@"notification@2x"];
    colorIV.center = CGPointMake(LFFScreenW/2, LFFScreenH/3);
    [remaindView addSubview:colorIV];
    
    UILabel *noticeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, 20)];
    noticeLab.center = CGPointMake(LFFScreenW/2, colorIV.maxY+10);
    noticeLab.font = LFFFont(12);
    noticeLab.textAlignment = NSTextAlignmentCenter;
    noticeLab.textColor = [UIColor lightGrayColor];
    noticeLab.text = @"您还未对药品创建用药提醒";
    [remaindView addSubview:noticeLab];
    
    UIButton *nowAddBtn = [LFFView createBtnWithFrame:CGRectMake(0, 0, LFFScreenW/3, 51/2) imageName:@"blueBtn_short@2x" text:@"现在添加" target:self sel:nil textFont:LFFFont(12) textColor:[UIColor whiteColor]];
    nowAddBtn.center = CGPointMake(LFFScreenW/2, noticeLab.maxY+15);
    [remaindView addSubview:nowAddBtn];
  
}

#pragma mark - 消息通知中心方法实现

-(void)jump1:(NSNotification*)noti
{
    
  
    self.tabBarController.selectedIndex = 2;
    
}

@end
