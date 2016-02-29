//
//  LFFView.m
//  健客
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFFView.h"

@implementation LFFView

//值得买 有帮助 中西医
+(UILabel*)createLabWithFrame:(CGRect)frame color:(UIColor *)color font:(UIFont*)font text:(NSString *)text
{
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.textColor = color;
    lab.text = text;
    lab.font = font;
    return lab;
}

//line Image
+(UIImageView*)createLineImageViewWithFrame:(CGRect)frame imageName:(NSString *)name
{
    UIImageView *line = [[UIImageView alloc]init];
    line.frame = frame;
    line.image = [UIImage imageNamed:name];
    return line;
}

//btn
+(UIButton*)createBtnWithFrame:(CGRect)fram imageName:(NSString *)imgName text:(NSString *)text target:(id)target sel:(SEL)sel textFont:(UIFont *)font textColor:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = fram;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setBackgroundImage:LFFImage(imgName) forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}

//pageController
+(UIPageControl*)createPageControllerWithFrame:(CGRect)frame pageNumberOfPages:(int)pageNum currentPage:(int)pageNumber currentPageIndicatorTinColor:(UIColor *)colorCurr PageIndicatorTinColor:(UIColor *)color
{
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:frame];

    pageControl.numberOfPages = pageNum;
    pageControl.currentPage = pageNumber;
    pageControl.currentPageIndicatorTintColor = colorCurr;
    pageControl.pageIndicatorTintColor = color;
    return pageControl;
}

//封装可按背景VIew
+(UIView*)createBackgroundViewWithFrame:(CGRect)frame color:(UIColor*)color
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    view.userInteractionEnabled = YES;
    return view;
}

//
+(void)showHUDWithText:(NSString *)text toView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
   
}
+(void)hiddenHUDWithText:(NSString *)text toView:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    
}

@end
