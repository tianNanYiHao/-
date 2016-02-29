//
//  MainNavgationController.m
//  健客
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainNavgationController.h"

@interface MainNavgationController ()

@end

@implementation MainNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航控制器 颜色
    [self.navigationBar setBarTintColor:[[UIColor alloc] initWithRed:0/255.0 green:130/255.0 blue:240/255.0 alpha:1.0]];
    //设施导航控制器 颜色 不透明 //设置半透明属性 也会让导航控制器导航条 不用减64
    self.navigationBar.translucent = NO;
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName:[UIColor whiteColor],
                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]
                                                          }];   
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackOpaque;
}

@end
