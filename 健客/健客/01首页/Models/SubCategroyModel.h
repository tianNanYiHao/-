//
//  SubCategroyModel.h
//  健客
//
//  Created by 刘斐斐 on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCategroyModel : NSObject

@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong) NSString *productPic;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *productSize;
@property (nonatomic,strong) NSString *productMake;
@property (nonatomic,strong) NSString *productOurprice;
@property (nonatomic,strong) NSString *productMarketPrice;

@property (nonatomic,assign) BOOL eMark;
@property (nonatomic,assign) BOOL iShopCart;



//搜索页接口模型
@property (nonatomic,strong) NSString *productImageUrl;
@property (nonatomic,strong) NSString *ourPrice;
@property (nonatomic,strong) NSString *productCode;




@end
