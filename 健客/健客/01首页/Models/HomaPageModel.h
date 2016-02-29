//
//  HomaPageModel.h
//  健客
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomaPageModel : NSObject
//广告页
@property (nonatomic,strong) NSString *head_img; //广告页图片
@property (nonatomic,strong) NSString *url; //广告页链接


@property (nonatomic,strong) NSString * productId;
@property (nonatomic,strong) NSString * productPic;
@property (nonatomic,strong) NSString * productImageUrl;//点击进入大图
@property (nonatomic,strong) NSString * productName;    // 商品名
@property (nonatomic,strong) NSString * productEffect; //商品简介
@property (nonatomic,strong) NSString * productCode;
@property (nonatomic,strong) NSString * ourPrice;

@property (nonatomic,strong) NSArray  * advertiseList; //广告页数组

//值得买 连接跳转
@property (nonatomic,strong) NSString * jump_url;//跳转网页
@property (nonatomic,strong) NSString * img_url; //首页值得买等图片

//menuNavigationUrl
@property (nonatomic,strong) NSString *worthBuyingUrl; //药划算按钮点击

@end
