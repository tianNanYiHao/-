//
//  LFFView.h
//  健客
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFFView : UIView

//值得买 有帮助 中西医 等lab
+(UILabel*)createLabWithFrame:(CGRect)frame color:(UIColor*)color font:(UIFont*)font text:(NSString*)text;

//line Image
+(UIImageView*)createLineImageViewWithFrame:(CGRect)frame imageName:(NSString*)name;

//btn
+(UIButton*)createBtnWithFrame:(CGRect)fram imageName:(NSString*)imgName text:(NSString*)text target:(id)target sel:(SEL)sel textFont:(UIFont*)font textColor:(UIColor*)color;

//封装pageController
+(UIPageControl*)createPageControllerWithFrame:(CGRect)frame pageNumberOfPages:(int)pageNum currentPage:(int)pageNumber currentPageIndicatorTinColor:(UIColor *)colorCurr PageIndicatorTinColor:(UIColor *)color;

//封装可按背景VIew
+(UIView*)createBackgroundViewWithFrame:(CGRect)frame color:(UIColor*)color;


+(void)showHUDWithText:(NSString*)text toView:(UIView*)view;

+(void)hiddenHUDWithText:(NSString*)text toView:(UIView*)view;



@end
