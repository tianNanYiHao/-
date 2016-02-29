//
//  FindMdeicDetailModel.h
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindMdeicDetailModel : NSObject

//疾病简介
@property (nonatomic,strong) NSString *summarize;

//治疗方案
@property (nonatomic,strong) NSString *treated;

//治疗药物 (key:treatMedecines)
  //-code
@property (nonatomic,strong)NSString  *productCode;
  //-图片
@property (nonatomic,strong)NSString  *productPic;
//-产品名
@property (nonatomic,strong)NSString  *productName;
//-产品简介
@property (nonatomic,strong)NSString  *introduction;
//-我们价格
@property (nonatomic,strong)NSString  *ourPrice;
//-时长价格
@property (nonatomic,strong)NSString  *marketPrice;
//- 是否eMark 是否iShopCar
@property (nonatomic,assign)BOOL      *eMark;
@property (nonatomic,assign)BOOL      *iShopCart;

//相关问题(key:relateArticle)
  //id
@property (nonatomic,strong)NSString *ID;
  //title(问题title)
@property (nonatomic,strong)NSString *title;
  //url
@property (nonatomic,strong)NSString *url;

@property (nonatomic,assign)CGFloat cellHeight1;
@property (nonatomic,assign)CGFloat cellHeight2;

@end
