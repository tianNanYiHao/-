//
//  HomePageView.h
//  健客
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomaPageModel,AdverView;
@protocol HomePageViewDelegate <NSObject>

@end

@interface HomePageView : UIView

@property (nonatomic,strong)HomaPageModel *model;
@property (nonatomic,assign)id<HomePageViewDelegate> delegate;


@property (nonatomic,strong) NSMutableArray *adverBtnArr; //传递出去的按钮数组

@property (nonatomic,strong) AdverView *adverViewDele; //传递出去的广告轮播view;

//值得买 三张图
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UIImageView *rightUpImg;
@property (nonatomic,strong) UIImageView *rightDownImg;


//传递出去的 可能帮到你 数组
@property (nonatomic,strong) NSMutableArray *couleHelpArr;
//传递出去的 可能帮到你 数组
//两性健康 三张图
@property (nonatomic,strong) UIView *leftImg1;
@property (nonatomic,strong) UIView *rightUpImg1;
@property (nonatomic,strong) UIView *rightDownImg1;


@property (nonatomic,strong) UIButton *eastWestBtn;
@property (nonatomic,strong) NSMutableArray *eastWestArr;






//根据尺寸和模型创建首页页面
+(instancetype)homePageWithFrame:(CGRect)frame array:(NSArray*)arr;

//值得买页面
-(UIView*)wothBuyWithArray:(NSArray*)arr;

//可能帮到你滚动视图
-(UIView*)couldhelpWithArray:(NSArray*)arr;

//两性健康View
-(UIView*)sexualHealthWithArray:(NSArray*)arr;

//中西医药
-(UIView*)chinaWesternMedicineWithArray:(NSArray*)arr;

@end
