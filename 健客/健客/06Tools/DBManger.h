//
//  DBManger.h
//  健客
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProductDetailModel;
@interface DBManger : NSObject

+(instancetype)sharManger;



//插入数据
-(BOOL)insertDataWithProductDetailModel:(ProductDetailModel*)model;

//删除数据
-(BOOL)deleteDataWithProductCode:(NSString*)productCode;

//根据appid查找单条数据
-(BOOL)selectOneDatawithproductCode:(NSString *)productCode;

//查询所有数据
-(NSArray*)selectAlldata;
@end
