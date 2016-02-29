//
//  AboutProductModel.h
//  健客
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutProductModel : NSObject

@property (nonatomic,strong)NSString *productCode;
@property (nonatomic,strong)NSString *productImageUrl;
@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *ourPrice;
@property (nonatomic,strong)NSString *productEffect;

//搜索模型写在这里 主要是因为懒 不想再写一个model
@property (nonatomic,strong) NSString *searchResult;

@end
