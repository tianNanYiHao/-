//
//  ProductDetailModel.h
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject


//总key (info -包字典)


@property (nonatomic,strong) NSArray *imgList;
//1商品广告图(imgList -包字典数组)
@property (nonatomic,strong) NSString *head_img; //广告图片 (需要拼接)


//2商品详情(productInfo) (字典)
@property (nonatomic,strong) NSString *productCode; // id
@property (nonatomic,strong) NSString *productName; // 名字
@property (nonatomic,strong) NSString *packing;     //规格
@property (nonatomic,strong) NSString *ourPrice;    //我价格
@property (nonatomic,strong) NSString *marketPrice; //市场价
@property (nonatomic,strong) NSString *productEffect;//产品简介
@property (nonatomic,strong) NSString *productDescription; //产品说明书

  //规格数据 (packings)
@property (nonatomic,strong) NSArray *packings;

@property (nonatomic,strong) NSArray *userEvaluateNum; //用户评论数


//3 相关推荐(relatedRecommend)
//@property (nonatomic,strong) NSString *productCode;
@property (nonatomic,strong) NSArray *relatedRecommend;
@property (nonatomic,strong) NSString *productImageUrl; //图片链接

@property (nonatomic,assign) CGFloat cellHeight2;
@property (nonatomic,assign) CGFloat cellSection1Row2height;

@end
